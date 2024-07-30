import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/verify_otp.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../utils/colors.dart';
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

  @override
  void initState() {
    super.initState();
    _countryCtrl.text = widget.phoneNumberModel.countryCode?.name ?? '';
    _phoneCtrl.text = widget.phoneNumberModel.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              Navigator.of(context)
                  .pushNamed(VerifyOtpScreen.route,
                      arguments: widget.phoneNumberModel)
                  .then((res) {
                if (res == true) {
                  Navigator.of(context).pushNamed(LoginScreen.route,
                      arguments: widget.phoneNumberModel);
                }
              });
            },
            child: gradientButton(),
          )
        ],
      ),
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
