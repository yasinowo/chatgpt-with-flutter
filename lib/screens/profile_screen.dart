import 'package:flutter/material.dart';
import 'package:my_chat_gpt/components/appbar_global.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
      ),
    );
  }
}
