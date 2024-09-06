import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/change_password.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/change_phone.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/models/phone_number.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../utils/helpers.dart';
import '../../onboarding/verify_otp.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});
  static const String route = '/phoneVerificationScreen';

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  UserProfileDetail? user;
  late ApiCallProvider apiCallProvider;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  void loadUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        getTopBar(),
        verticalGap(60),
        SvgPicture.asset(
          'assets/svg/smartphone_1_.svg',
          color: const Color(0xFF3CB371),
          width: 100,
        ),
        verticalGap(20),
        Text(
          '+${user?.phone ?? ''}',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        verticalGap(20),
        ListTile(
          leading: SvgPicture.asset(
            'assets/svg/smartphone_call.svg',
            width: 22,
          ),
          title: const Text('Change Phone Number'),
          trailing: const Icon(Icons.chevron_right),
          tileColor: Colors.white,
          onTap: isLoading
              ? null
              : () {
                  sendOtp(context);
                },
        ),
        const Divider(
          height: 1,
          color: Color(0xFFF9F9F9),
        ),
        ListTile(
          leading: SvgPicture.asset(
            'assets/svg/open_lock.svg',
            width: 22,
          ),
          title: const Text('Change Password'),
          trailing: const Icon(Icons.chevron_right),
          tileColor: Colors.white,
          onTap: () {
            PhoneNumberModel phoneNumberModel =
                PhoneNumberModel(phoneNumber: user?.phone);
            Navigator.of(context).pushNamed(ChangePasswordScreen.route,
                arguments: phoneNumberModel);
          },
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Container getTopBar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xffFE3400),
            Color(0xffFBC108),
          ],
        ),
      ),
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Phone Verification',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> sendOtp(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    return FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+${user?.phone}',
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
        PhoneNumberModel phoneNumberModel = PhoneNumberModel(
            verificationId: verificationId, phoneNumber: user?.phone);

        Navigator.of(context)
            .pushNamed(VerifyOtpScreen.route, arguments: phoneNumberModel)
            .then((res) {
          if (res == true) {
            Navigator.of(context).pushNamed(ChangePhoneScreen.route).then(
              (value) {
                loadUserData();
              },
            );
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
