import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home_container.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/models/phone_number.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/reset_password.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/verify_otp.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';

import '../../main.dart';
import '../../providers/api_call_provider.dart';
import '../../providers/generic_auth_provider.dart';
import '../../utils/api.dart';
import '../../utils/helpers.dart';
import '../../utils/prefs_key.dart';
import '../../widgets/button_loader.dart';
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
  late ApiCallProvider apiCallProvider;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneCtrl.text = widget.phoneNumberModel.toString();
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

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
                sendOtp(context);
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
            onTap: isLoading || apiCallProvider.status == ApiStatus.loading
                ? null
                : () {
                    if (_passwordCtrl.text.isEmpty) {
                      showToastMessageWithLogo(
                          'Password is mandatory', context);
                      return;
                    }

                    Map<String, dynamic> reqBody = {
                      'phone':
                          '${widget.phoneNumberModel.countryCode?.dialCode}${widget.phoneNumberModel.phoneNumber}'
                              .replaceAll('+', ''),
                      'password': _passwordCtrl.text,
                    };
                    apiCallProvider.postRequest(API.mobileLogin, reqBody).then(
                      (value) {
                        if (apiCallProvider.status == ApiStatus.success) {
                          if (value['success'] == '1') {
                            showToastMessageWithLogo(
                                '${value['message']}', context);
                            prefs.setString(
                                PrefsKey.userId, value['details']['id']);
                            prefs.setString(PrefsKey.userName,
                                value['details']['username']);
                            prefs.setString(PrefsKey.familyId,
                                value['details']['familyId']);
                            prefs.setBool(PrefsKey.showProfileUpdatePopup,
                                value['details']['name'].toString().isEmpty);

                            // prefs.setString(PrefsKey.userId, "176");
                            // prefs.setString(PrefsKey.userName, "10269");
                            // prefs.setString(PrefsKey.familyId, "42");
                            // prefs.setBool(
                            //     PrefsKey.showProfileUpdatePopup, false);

                            prefs.setString(PrefsKey.loginProvider, 'Phone');
                            Navigator.of(context, rootNavigator: true)
                                .pushNamedAndRemoveUntil(
                              HomeContainer.route,
                              (route) => false,
                            );
                          } else {
                            GenericAuthProvider.instance.logoutUser();
                            showToastMessageWithLogo(
                                '${value['message']}', context);
                          }
                        } else {
                          GenericAuthProvider.instance.logoutUser();
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
      child: isLoading || apiCallProvider.status == ApiStatus.loading
          ? const ButtonLoader()
          : const Text(
              'Next',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Future<void> sendOtp(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    return FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:
          '${widget.phoneNumberModel.countryCode?.dialCode}${widget.phoneNumberModel.phoneNumber}',
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (firebaseAuthException) {
        setState(() {
          isLoading = false;
        });
        log(firebaseAuthException.toString());
        showToastMessageWithLogo(
            'Error : ${firebaseAuthException.message}', context);
      },
      codeSent: (verificationId, forceResendingToken) {
        setState(() {
          isLoading = false;
        });
        widget.phoneNumberModel.verificationId = verificationId;
        Navigator.of(context, rootNavigator: true)
            .pushNamed(VerifyOtpScreen.route,
                arguments: widget.phoneNumberModel)
            .then((res) {
          if (res == true) {
            Navigator.of(context, rootNavigator: true).pushNamed(
                ResetPasswordScreen.route,
                arguments: widget.phoneNumberModel);
          }
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() {
          isLoading = false;
        });
        showToastMessageWithLogo('Error : Code retrieval timeout', context);
      },
    );
  }
}
