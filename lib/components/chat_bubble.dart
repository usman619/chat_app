import 'package:chat_app/themes/text_theme.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
      decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green.shade500 : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        message,
        style: textFieldTheme(context).copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
