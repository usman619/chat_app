import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*
  Chat Service
    - get firestore instance [Done]
    - get user chat stream [Done]
    - send messages [Done]
    - get messages [Done]
    - Report [Done]
    - Block Users [Done]
    - Unblock User [Done]
    - get block users stream [Done]
*/
class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through all the users
        final user = doc.data();
        // add them to the list
        return user;
      }).toList();
    });
  }

  // Get the stream all the users except the blocked users
  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
    final currentUser = _auth.currentUser;

    return _firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("BlockedUsers")
        .snapshots()
        .asyncMap(
      (snapshot) async {
        final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();
        final userSnapshot = await _firestore.collection("Users").get();

        return userSnapshot.docs
            .where((doc) =>
                doc.data()['email'] != currentUser.email &&
                !blockedUserIds.contains(doc.id))
            .map((doc) => doc.data())
            .toList();
      },
    );
  }

  Future<void> sendMessage(String receiverID, message) async {
    // Get sender's UID and Email
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Creating a message with the given parameters
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // Creating a chat room Id
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(
          newMessage.toMap(),
        );
  }

  Stream<QuerySnapshot> getMessages(String currentUserID, otherUserID) {
    // Reconstruct the chat room id
    List<String> ids = [currentUserID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  // Report Users
  Future<void> reportUser(String messageID, String userID) async {
    final currentUser = _auth.currentUser;
    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageID,
      'messageOwnerId': userID,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore.collection("Reports").add(report);
  }

  // Block User
  Future<void> blockUser(
    String userID,
  ) async {
    final currentUserId = _auth.currentUser!.uid;

    await _firestore
        .collection("Users")
        .doc(currentUserId)
        .collection("BlockedUsers")
        .doc(userID)
        .set({});
    notifyListeners();
  }

  // Unblock User
  Future<void> unblockUser(String userID) async {
    final currentUserId = _auth.currentUser!.uid;

    await _firestore
        .collection("Users")
        .doc(currentUserId)
        .collection("BlockedUsers")
        .doc(userID)
        .delete();
  }

  // Block Users Stream
  Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userID) {
    return _firestore
        .collection("Users")
        .doc(userID)
        .collection("BlockedUsers")
        .snapshots()
        .asyncMap((snapshot) async {
      final blockUserIds = snapshot.docs.map((doc) => doc.id).toList();

      final userDocs = await Future.wait(blockUserIds
          .map((id) => _firestore.collection("Users").doc(id).get()));
      return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}
