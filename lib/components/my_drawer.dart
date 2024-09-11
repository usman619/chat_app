import 'package:chat_app/auth/auth_gate.dart';
import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_drawer_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final _auth = AuthService();

  void logout(BuildContext context) async {
    await _auth.logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthGate()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Image(
                  image: const AssetImage('assets/images/speech_bubble.png'),
                  height: 72,
                  width: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 10),
              MyDrawerTile(
                title: 'HOME',
                icon: Icons.home_outlined,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              MyDrawerTile(
                title: 'SETTINGS',
                icon: Icons.settings_outlined,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              const Spacer(),
              MyDrawerTile(
                title: 'LOGOUT',
                icon: Icons.logout_outlined,
                onTap: () => logout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
