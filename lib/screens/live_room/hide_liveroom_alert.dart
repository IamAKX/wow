import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/helpers.dart';
import '../../utils/prefs_key.dart';

class HideLiveRoom extends StatefulWidget {
  const HideLiveRoom({super.key});

  @override
  State<HideLiveRoom> createState() => _HideLiveRoomState();
}

class _HideLiveRoomState extends State<HideLiveRoom> {
  late ApiCallProvider apiCallProvider;

  Future<void> hideUnhideRoom() async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
    };
    await apiCallProvider
        .postRequest(API.hideUnHideLiveUser, reqBody)
        .then((value) {
      showToastMessage(value['message']);
    });
  }

  String prompt =
      '''Afetr activating hidden Room,other people won't know about the gifts sent and won;t appear in any gift record.
After activating Hidden
Room, nobody will be able to join the room.

To activate the Hidden Room for 30 min you need to pay:''';

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

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
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            OutlinedButton(
              onPressed: () {
                hideUnhideRoom();
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
