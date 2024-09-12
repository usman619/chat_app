import 'package:cloud_firestore/cloud_firestore.dart';

/*
  Chat Service
    - get firestore instance
    - get user chat stream
    - send messages
    - get messages
*/
class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
