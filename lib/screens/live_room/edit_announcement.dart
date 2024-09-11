import 'package:flutter/material.dart';

class EditAnnouncement extends StatefulWidget {
  const EditAnnouncement({super.key});

  @override
  State<EditAnnouncement> createState() => _EditAnnouncementState();
}

class _EditAnnouncementState extends State<EditAnnouncement> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Edit the announcement',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              fillColor: Colors.grey.shade300,
              filled: true,
              labelText: 'Type your announcement',
              border: InputBorder.none,
            ),
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
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle confirm action
                print('Entered text: ${_textController.text}');
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
