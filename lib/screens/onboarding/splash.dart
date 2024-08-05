import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:worldsocialintegrationapp/providers/auth_provider.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/phone.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String route = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAgreementChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTermsOfServiceTap() {
    openInBrowser(API.termsOfService);
  }

  void _onPrivacyPolicyTap() {
    openInBrowser(API.privacyPolicy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(pagePadding),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/image/wow_logo.png',
              fit: BoxFit.fitWidth,
              width: 300,
            ),
          ),
          SocialLoginButton(
            buttonType: SocialLoginButtonType.google,
            height: 40,
            width: 240,
            imageWidth: 20,
            onPressed: () async {
              if (!isAgreementChecked) {
                showToastMessageWithLogo(
                    'Please accept the terms and conditions', context);
                return;
              }
              await GenericAuthProvider.instance.loginWithGoogle();
            },
          ),
          verticalGap(20),
          SocialLoginButton(
            height: 40,
            width: 240,
            imageWidth: 20,
            buttonType: SocialLoginButtonType.facebook,
            onPressed: () {
              if (!isAgreementChecked) {
                showToastMessageWithLogo(
                    'Please accept the terms and conditions', context);
                return;
              }
            },
          ),
          verticalGap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (!isAgreementChecked) {
                    showToastMessageWithLogo(
                        'Please accept the terms and conditions', context);
                    return;
                  }
                  Navigator.of(context).pushNamed(PhoneScreen.route);
                },
                child: getMobileButton(),
              ),
              horizontalGap(20),
              InkWell(
                onTap: () {
                  if (!isAgreementChecked) {
                    showToastMessageWithLogo(
                        'Please accept the terms and conditions', context);
                    return;
                  }
                },
                child: getSnapchatButton(),
              ),
            ],
          ),
          verticalGap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: pagePadding),
            child: Row(
              children: [
                Switch(
                  value: isAgreementChecked,
                  onChanged: (value) {
                    setState(() {
                      isAgreementChecked = !isAgreementChecked;
                    });
                  },
                ),
                Flexible(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By Continuing you agree to the ',
                      style: const TextStyle(
                        color: hintColor,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: const TextStyle(
                            color: textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTermsOfServiceTap,
                        ),
                        const TextSpan(
                          text: ' and ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            color: textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onPrivacyPolicyTap,
                        ),
                        const TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Center getSnapchatButton() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(1.0),
        decoration: const BoxDecoration(
          color: hintColor,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/image/login_snapchat_icon.png',
            width: 20,
          ),
        ),
      ),
    );
  }

  Center getMobileButton() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(1.0),
        decoration: const BoxDecoration(
          color: hintColor,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: SvgPicture.asset(
            'assets/svg/phone.svg',
            width: 16,
          ),
        ),
      ),
    );
  }
}
