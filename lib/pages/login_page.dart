import 'package:chat_app/themes/text_theme.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: titleTextTheme,
        ),
      ),
      body: Text(
        'Welcome to Login Page',
        style: bodyTextTheme,
      ),
    );
  }
}
