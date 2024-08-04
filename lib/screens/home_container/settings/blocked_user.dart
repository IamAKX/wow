import 'package:flutter/material.dart';

class BlockedUserScreen extends StatefulWidget {
  const BlockedUserScreen({super.key});
  static const String route = '/blockedUserScreen';

  @override
  State<BlockedUserScreen> createState() => _BlockedUserScreenState();
}

class _BlockedUserScreenState extends State<BlockedUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Blocked User'),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('No User Found'),
      ),
    );
  }
}
