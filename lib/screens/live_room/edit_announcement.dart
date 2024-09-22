import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/services/live_room_firebase.dart';

import '../../models/joinable_live_room_model.dart';

class EditAnnouncement extends StatefulWidget {
  const EditAnnouncement({super.key, required this.roomDetail});
  final JoinableLiveRoomModel roomDetail;

  @override
  State<EditAnnouncement> createState() => _EditAnnouncementState();
}

class _EditAnnouncementState extends State<EditAnnouncement> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
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
              hintText: 'Type your announcement',
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
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                LiveRoomFirebase.updateLiveRoomAnnoucement(
                    widget.roomDetail.id ?? '', _textController.text);
                Navigator.of(context, rootNavigator: true).pop();
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
