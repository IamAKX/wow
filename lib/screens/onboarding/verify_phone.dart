import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/signup.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/verify_otp.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../providers/api_call_provider.dart';
import '../../utils/colors.dart';
import '../../utils/helpers.dart';
import 'login.dart';
import 'models/phone_number.dart';

class VerifyPhoneScreen extends StatefulWidget {
  static const String route = '/verifyPhoneScreen';
  final PhoneNumberModel phoneNumberModel;
  const VerifyPhoneScreen({super.key, required this.phoneNumberModel});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController _countryCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    _countryCtrl.text = widget.phoneNumberModel.countryCode?.name ?? '';
    _phoneCtrl.text = widget.phoneNumberModel.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phone Number',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(pagePadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            readOnly: true,
            controller: _countryCtrl,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: 'Country',
              labelText: 'Country',
              labelStyle: TextStyle(fontSize: 20),
              border: UnderlineInputBorder(),
            ),
          ),
          verticalGap(pagePadding),
          TextField(
            readOnly: true,
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: 'Phone Number',
              labelText: 'Phone Number',
              labelStyle: TextStyle(fontSize: 20),
              suffix: Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
              ),
              border: UnderlineInputBorder(),
            ),
          ),
          InkWell(
            onTap: () async {
              Map<String, dynamic> reqBody = {
                'phone':
                    '${widget.phoneNumberModel.countryCode?.dialCode}${widget.phoneNumberModel.phoneNumber}'
                        .replaceAll('+', '')
              };
              apiCallProvider.postRequest(API.checkNumber, reqBody).then(
                (value) {
                  if (apiCallProvider.status == ApiStatus.success) {
                    if (value['isRegistered'] == 'false') {
                      sendOtp(context);
                    } else {
                      Navigator.of(context).pushNamed(LoginScreen.route,
                          arguments: widget.phoneNumberModel);
                    }
                  } else {
                    showToastMessageWithLogo('Request failed', context);
                  }
                },
              );
            },
            child: gradientButton(),
          )
        ],
      ),
    );
  }

  Future<void> sendOtp(BuildContext context) {
    return FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:
          '${widget.phoneNumberModel.countryCode?.dialCode}${widget.phoneNumberModel.phoneNumber}',
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (firebaseAuthException) {
        log(firebaseAuthException.toString());
        showToastMessageWithLogo(
            'Error : ${firebaseAuthException.message}', context);
      },
      codeSent: (verificationId, forceResendingToken) {
        widget.phoneNumberModel.verificationId = verificationId;
        Navigator.of(context)
            .pushNamed(VerifyOtpScreen.route,
                arguments: widget.phoneNumberModel)
            .then((res) {
          if (res == true) {
            Navigator.of(context).pushNamed(SignUpScreen.route,
                arguments: widget.phoneNumberModel);
          }
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        showToastMessageWithLogo('Error : Code retrieval timeout', context);
      },
    );
  }

  Container gradientButton() {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: pagePadding, vertical: pagePadding),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [buttonGradientPurple, buttonGradientPink],
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: const Text(
        'Sign Up/Login with Phone',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
