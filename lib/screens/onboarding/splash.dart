// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String route = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _translationAnimation;
  late AnimationController _sizeController;
  late Animation<double> _sizeAnimation;
  bool _isExpanded = false;

  bool isAgreementChecked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _translationAnimation =
        Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _sizeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _sizeAnimation =
        Tween<double>(begin: 150, end: 300).animate(CurvedAnimation(
      parent: _sizeController,
      curve: Curves.easeInOut,
    ));
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    setState(() {
      _controller.forward().then((_) {
        // setState(() {
        _isExpanded = true;
        // });
        _sizeController.forward();
      });
    });
  }

  void _onTermsOfServiceTap() {
    print('Terms of Service clicked');
    // Add your navigation logic or other functionality here
  }

  void _onPrivacyPolicyTap() {
    print('Privacy Policy clicked');
    // Add your navigation logic or other functionality here
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
            child: Container(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation:
                    Listenable.merge([_translationAnimation, _sizeAnimation]),
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                        _translationAnimation.value *
                            MediaQuery.of(context).size.width,
                        0),
                    child: Image.asset(
                      'assets/image/wow_logo.png',
                      fit: BoxFit.fitWidth,
                      width: _isExpanded ? _sizeAnimation.value : 150,
                    ),
                  );
                },
              ),
            ),
          ),
          SocialLoginButton(
            buttonType: SocialLoginButtonType.google,
            height: 40,
            width: 240,
            imageWidth: 20,
            onPressed: () {},
          ),
          verticalGap(20),
          SocialLoginButton(
            height: 40,
            width: 240,
            imageWidth: 20,
            buttonType: SocialLoginButtonType.facebook,
            onPressed: () {},
          ),
          verticalGap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: getMobileButton(),
              ),
              horizontalGap(20),
              InkWell(
                onTap: () {},
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
        decoration: BoxDecoration(
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
        decoration: BoxDecoration(
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
