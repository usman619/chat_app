import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/themes/text_theme.dart';
import 'package:chat_app/util/timestamp_to_time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String messageId;
  final String userId;
  final Timestamp timestamp;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.messageId,
    required this.userId,
    required this.timestamp,
    required this.isCurrentUser,
  });

  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              // report message
              ListTile(
                leading: const Icon(Icons.flag),
                title: Text(
                  'Report',
                  style: bodyTextTheme,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _reportMessage(context, messageId, userId);
                },
              ),
              // block user
              ListTile(
                leading: const Icon(Icons.block),
                title: Text(
                  'Block User',
                  style: bodyTextTheme,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _blockUser(context, userId);
                },
              ),
              // cancel
              ListTile(
                leading: const Icon(Icons.cancel),
                title: Text(
                  'Cancel',
                  style: bodyTextTheme,
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _reportMessage(BuildContext context, String messageId, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Report Message',
          style: titleTextTheme,
        ),
        content: Text(
          'Are you sure you want to report this message?',
          style: bodyTextTheme,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: bodyTextTheme.copyWith(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              ChatService().reportUser(messageId, userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Message reported successfully!',
                    style: bodyTextTheme.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
            child: Text(
              'Report',
              style: bodyTextTheme.copyWith(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  void _blockUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Block User',
          style: titleTextTheme,
        ),
        content: Text(
          'Are you sure you want to block this user?',
          style: bodyTextTheme,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: bodyTextTheme.copyWith(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              ChatService().blockUser(userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'User blocked successfully!',
                    style: bodyTextTheme.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
            child: Text(
              'Block',
              style: bodyTextTheme.copyWith(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
        decoration: BoxDecoration(
            color: isCurrentUser ? Colors.green.shade600 : Colors.grey.shade600,
            borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  message,
                  style: textFieldTheme(context).copyWith(
                    color: Colors.white,
                  ),
                ),
                // Adding a blank line space
                const Text('\t'),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 4,
              child: Text(
                timestampToTime(timestamp),
                style: textFieldTheme(context)
                    .copyWith(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
