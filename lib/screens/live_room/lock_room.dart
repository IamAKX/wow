import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class LockRoom extends StatefulWidget {
  const LockRoom({super.key});

  @override
  State<LockRoom> createState() => _LockRoomState();
}

class _LockRoomState extends State<LockRoom> {
  String otpInput = '';
  final _otpPinFieldKey = GlobalKey<OtpPinFieldState>();

  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle confirm action

                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
