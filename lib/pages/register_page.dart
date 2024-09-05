import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_password_field.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/themes/text_theme.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordtroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(
            'Register',
            style: titleTextTheme,
          ),
          centerTitle: true,
          // foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: nameController,
                    labelText: 'Enter your name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: emailController,
                    labelText: 'Enter your email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  MyPasswordField(
                    controller: passwordController,
                    labelText: 'Enter your password',
                  ),
                  const SizedBox(height: 20),
                  MyPasswordField(
                    controller: confirmPasswordtroller,
                    labelText: 'Confirm your password',
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    text: 'Register',
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an Account?',
                          style: bodyTextTheme.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Login',
                            style: bodyTextTheme.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
