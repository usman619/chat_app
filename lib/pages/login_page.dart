import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_password_field.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/themes/text_theme.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(
            'Login',
            style: titleTextTheme,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Image(
                    image: const AssetImage('assets/images/speech_bubble.png'),
                    height: 100,
                    width: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  MyTextField(
                    controller: emailController,
                    labelText: "Enter your email",
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyPasswordField(
                    controller: passwordController,
                    labelText: "Enter your password",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forget Password?",
                        style: bodyTextTheme.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    text: 'Login',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not Registered Yet?',
                          style: bodyTextTheme.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'Register',
                            style: bodyTextTheme.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
