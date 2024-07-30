import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/models/phone_number.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/reset_password.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/verify_otp.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';

import '../../widgets/gaps.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.phoneNumberModel});
  static const String route = '/login';
  final PhoneNumberModel phoneNumberModel;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  bool obsurePassword = true;

  @override
  void initState() {
    super.initState();
    _phoneCtrl.text = widget.phoneNumberModel.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
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
            controller: _phoneCtrl,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: 'Mobile Number',
              labelText: 'Mobile Number',
              labelStyle: TextStyle(fontSize: 20),
              border: UnderlineInputBorder(),
            ),
          ),
          verticalGap(pagePadding),
          TextField(
            controller: _passwordCtrl,
            obscureText: obsurePassword,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Enter Password',
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsurePassword = !obsurePassword;
                  });
                },
                icon: Icon(
                  obsurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.red,
                ),
              ),
              labelStyle: const TextStyle(fontSize: 20),
              border: const UnderlineInputBorder(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(VerifyOtpScreen.route,
                        arguments: widget.phoneNumberModel)
                    .then((res) {
                  if (res == true) {
                    Navigator.of(context).pushNamed(ResetPasswordScreen.route,
                        arguments: widget.phoneNumberModel);
                  }
                });
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: gradientButton(),
          )
        ],
      ),
    );
  }

  Container gradientButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: pagePadding),
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
