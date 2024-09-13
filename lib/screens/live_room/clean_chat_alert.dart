import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/models/liveroom_chat.dart';
import 'package:worldsocialintegrationapp/services/live_room_firebase.dart';

class CleanChatRoom extends StatefulWidget {
  const CleanChatRoom(
      {super.key, required this.chatRoomId, required this.chat});
  final String chatRoomId;
  final LiveroomChat chat;

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
                LiveRoomFirebase.clearChat(widget.chatRoomId, widget.chat);

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
