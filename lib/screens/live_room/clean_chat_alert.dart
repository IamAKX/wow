import 'package:flutter/material.dart';

class CleanChatRoom extends StatefulWidget {
  const CleanChatRoom({super.key});

  @override
  State<CleanChatRoom> createState() => _CleanChatRoomState();
}

class _CleanChatRoomState extends State<CleanChatRoom> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Tips',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text('Are you sure you want to clean the chat?'),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                // Handle cancel action
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle confirm action

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Confirm'),
            ),
          ],
        ),
      ],
    );
  }
}
