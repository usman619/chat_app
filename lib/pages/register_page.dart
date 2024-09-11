import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_password_field.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/themes/text_theme.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordtroller = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // Register New User
  void register(BuildContext context) async {
    final authService = AuthService();
    if (_passwordController.text == _confirmPasswordtroller.text) {
      try {
        await authService.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              e.toString(),
              style: titleTextTheme,
            ),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Passwords doesn't Match!",
            style: titleTextTheme,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        resizeToAvoidBottomInset: false,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image(
                    image: const AssetImage('assets/images/speech_bubble.png'),
                    height: 100,
                    width: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: _emailController,
                    labelText: 'Enter your email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  MyPasswordField(
                    controller: _passwordController,
                    labelText: 'Enter your password',
                  ),
                  const SizedBox(height: 20),
                  MyPasswordField(
                    controller: _confirmPasswordtroller,
                    labelText: 'Confirm your password',
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    text: 'Register',
                    onTap: () => register(context),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an Account?',
                          style: bodyTextTheme.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: onTap,
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
