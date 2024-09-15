import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/themes/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  // Auth and Chat Service
  final AuthService _auth = AuthService();
  final ChatService _chatService = ChatService();

  // Unblock User
  void _showUnblockUserDialog(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Unblock User',
          style: titleTextTheme,
        ),
        content: Text(
          'Are you sure you want to unblock this user?',
          style: bodyTextTheme,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: bodyTextTheme.copyWith(
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _chatService.unblockUser(userId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'User ublocked successfully!',
                    style: bodyTextTheme.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
            child: Text(
              'Unblock',
              style: bodyTextTheme.copyWith(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = _auth.getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blocked Users',
          style: titleTextTheme,
        ),
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getBlockedUsersStream(userId),
        builder: (context, snapshot) {
          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error',
                style: bodyTextTheme,
              ),
            );
          }
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            );
          }
          // Blocked Users List
          final blockedUsers = snapshot.data ?? [];
          if (blockedUsers.isEmpty) {
            return Center(
              child: Text(
                'No blocked Users',
                style: bodyTextTheme,
              ),
            );
          }
          return ListView.builder(
            itemCount: blockedUsers.length,
            itemBuilder: (context, index) {
              final user = blockedUsers[index];
              return UserTile(
                text: user['email'],
                onTap: () => _showUnblockUserDialog(context, user['uid']),
              );
            },
          );
        },
      ),
    );
  }
}
