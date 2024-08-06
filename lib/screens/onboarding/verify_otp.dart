import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../utils/colors.dart';
import 'models/phone_number.dart';

class VerifyOtpScreen extends StatefulWidget {
  static const String route = '/verifyOtpScreen';
  final PhoneNumberModel phoneNumberModel;
  const VerifyOtpScreen({super.key, required this.phoneNumberModel});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  int _seconds = 59;
  String otpInput = '';
  late Timer _timer;
  bool _isButtonEnabled = false;
  final _otpPinFieldKey = GlobalKey<OtpPinFieldState>();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _isButtonEnabled = true;
          _timer.cancel();
        }
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _seconds = 59;
      _isButtonEnabled = false;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verification',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        verticalGap(20),
        const Align(
          alignment: Alignment.center,
          child: Text('A verification code has been sent to you.'),
        ),
        verticalGap(20),
        Align(
          alignment: Alignment.center,
          child: Text(
            widget.phoneNumberModel.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        verticalGap(20),
        OtpPinField(
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
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
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

          otpPinFieldDecoration: OtpPinFieldDecoration.roundedPinBoxDecoration,
        ),
        verticalGap(20),
        InkWell(
          onTap: () async {
            if (otpInput.length < 6) {
              showToastMessageWithLogo('Enter 6 digit OTP', context);
              return;
            }
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: widget.phoneNumberModel.verificationId ?? '',
                smsCode: otpInput);
            UserCredential userCredential = await FirebaseAuth.instance
                .signInWithCredential(credential)
                .catchError((onError) {
              showToastMessage('Invalid OTP');
            });
            if (userCredential.user != null) {
              Navigator.of(context).pop(true);
            } else {
              showToastMessage('Invalid OTP');
            }
          },
          child: gradientButton(),
        ),
        verticalGap(10),
        StatefulBuilder(
          builder: (context, setState) {
            return _isButtonEnabled
                ? InkWell(
                    onTap: _isButtonEnabled ? _resetTimer : null,
                    child: const Text('Resend Code'),
                  )
                : Text(
                    '00:$_seconds',
                  );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Container gradientButton() {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: pagePadding, horizontal: pagePadding),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [buttonGradientPurple, buttonGradientPink],
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: const Text(
        'Next',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
