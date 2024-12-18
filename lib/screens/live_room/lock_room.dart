import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';

import '../../main.dart';
import '../../models/joinable_live_room_model.dart';
import '../../providers/api_call_provider.dart';
import '../../services/live_room_firebase.dart';
import '../../utils/api.dart';
import '../../utils/prefs_key.dart';

class LockRoom extends StatefulWidget {
  const LockRoom({super.key, required this.roomDetail, required this.userId});
  final JoinableLiveRoomModel roomDetail;
  final String userId;
  @override
  State<LockRoom> createState() => _LockRoomState();
}

class _LockRoomState extends State<LockRoom> {
  String otpInput = '';
  final _otpPinFieldKey = GlobalKey<OtpPinFieldState>();
  late ApiCallProvider apiCallProvider;

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return AlertDialog(
      title: const Text(
        'Set Room Password',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OtpPinField(
            fieldHeight: 30,
            fieldWidth: 30,
            key: _otpPinFieldKey,
            autoFillEnable: false,
            textInputAction: TextInputAction.done,

            onSubmit: (text) {
              otpInput = text;
            },
            onChange: (text) {
              otpInput = text;

              /// return the entered pin
            },
            onCodeChanged: (code) {
              otpInput = code;
            },

            /// to decorate your Otp_Pin_Field
            otpPinFieldStyle: OtpPinFieldStyle(
              activeFieldBorderColor: Colors.white,
              defaultFieldBorderColor: Colors.white,
              filledFieldBackgroundColor: Colors.white,
              defaultFieldBackgroundColor: Colors.white,
              filledFieldBorderColor: Colors.white,
              activeFieldBackgroundColor: Colors.white,
              defaultFieldBoxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
              activeFieldBoxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              filledFieldBoxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            maxLength: 6,

            showCursor: true,

            cursorColor: Colors.black,

            mainAxisAlignment: MainAxisAlignment.center,

            otpPinFieldDecoration:
                OtpPinFieldDecoration.roundedPinBoxDecoration,
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
              onPressed: () async {
                // Handle confirm action
                if (otpInput.length == 6) {
                  lockRoom();
                  Navigator.of(context, rootNavigator: true).pop();
                } else {
                  showToastMessage('Enter 6 digits code');
                }
              },
              child: const Text('Confirm'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> lockRoom() async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'liveId': widget.roomDetail.id,
      'password': otpInput
    };
    await apiCallProvider
        .postRequest(API.lockUserLive, reqBody)
        .then((value) async {
      if (value['success'] == '1') {
        showToastMessage(value['message']);
        widget.roomDetail.password = otpInput;
        await LiveRoomFirebase.updateLiveRoomInfo(widget.roomDetail);
      }
    });
  }
}
