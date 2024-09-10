import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/themes/text_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: titleTextTheme,
        ),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const MyDrawer(),
    );
  }
}
