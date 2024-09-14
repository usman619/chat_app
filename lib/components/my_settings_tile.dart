import 'package:chat_app/themes/text_theme.dart';
import 'package:flutter/material.dart';

class MySettingsTile extends StatelessWidget {
  final String title;
  final Widget action;
  const MySettingsTile({
    super.key,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: bodyTextTheme.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          action,
        ],
      ),
    );
  }
}
