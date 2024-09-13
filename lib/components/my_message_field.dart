import 'package:chat_app/themes/text_theme.dart';
import 'package:flutter/material.dart';

class MyMessageField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode? focusNode;
  const MyMessageField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: textFieldTheme(context),
        decoration: InputDecoration(
          focusColor: Theme.of(context).colorScheme.primary,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintText,
          hintStyle: textFieldTheme(context),
        ),
      ),
    );
  }
}
