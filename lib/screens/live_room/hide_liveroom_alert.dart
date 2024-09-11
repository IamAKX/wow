import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class HideLiveRoom extends StatefulWidget {
  const HideLiveRoom({super.key});

  @override
  State<HideLiveRoom> createState() => _HideLiveRoomState();
}

class _HideLiveRoomState extends State<HideLiveRoom> {
  String prompt =
      '''Afetr activating hidden Room,other people won't know about the gifts sent and won;t appear in any gift record.
After activating Hidden
Room, nobody will be able to join the room.

To activate the Hidden Room for 30 min you need to pay:''';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Hidden',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(prompt),
          verticalGap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '1000',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Image.asset(
                'assets/image/money.png',
                width: 30,
              ),
            ],
          )
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
            OutlinedButton(
              onPressed: () {
                // Handle cancel action
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ],
    );
  }
}
