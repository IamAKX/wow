// ignore_for_file: unnecessary_const

import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/country_continent.dart';
import 'package:worldsocialintegrationapp/providers/api_call_provider.dart';
import 'package:worldsocialintegrationapp/providers/generic_auth_provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home_container.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/phone.dart';
import 'package:worldsocialintegrationapp/services/location_service.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../services/fcm_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String route = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAgreementChecked = false;
  static const platform = const MethodChannel('com.example.snapchat/login');
  CountryContinent? countryContinent;
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    fetchLocationInfo();
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
    apiCallProvider = Provider.of<ApiCallProvider>(context);
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
              GoogleSignInAccount? googleSignInAccount =
                  await GenericAuthProvider.instance.loginWithGoogle();
              if (googleSignInAccount != null) {
                String? fcmToken = await FCMService.instance.getFCMToken();
                String? deviceId = await getDeviceId();
                Map<String, dynamic> reqBody = {
                  'social_id': googleSignInAccount.id,
                  'reg_id': fcmToken,
                  'dev_id': deviceId,
                  'dev_type': Platform.isAndroid ? 'android' : 'ios',
                  'phone': '',
                  'name': googleSignInAccount.displayName,
                  'email': googleSignInAccount.email,
                  'continent': countryContinent?.continent,
                  'Country': countryContinent?.country,
                  'isAddingAccount': false,
                  'userName': '',
                  'facebookId': '',
                  'snapchatId': '',
                  'facebookUserName': ''
                };
                apiCallProvider.postRequest(API.socialLogin, reqBody).then(
                  (value) {
                    if (apiCallProvider.status == ApiStatus.success) {
                      if (value['success'] == '1') {
                        showToastMessageWithLogo(
                            '${value['message']}', context);
                        prefs.setString(
                            PrefsKey.userId, value['details']['id']);
                        prefs.setString(
                            PrefsKey.userName, value['details']['username']);
                        prefs.setString(PrefsKey.loginProvider, 'Google');
                        Navigator.of(context).pushNamedAndRemoveUntil(
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
              }
            },
          ),
          verticalGap(20),
          SocialLoginButton(
            height: 40,
            width: 240,
            imageWidth: 20,
            buttonType: SocialLoginButtonType.facebook,
            onPressed: () async {
              if (!isAgreementChecked) {
                showToastMessageWithLogo(
                    'Please accept the terms and conditions', context);
                return;
              }
              if (!isAgreementChecked) {
                showToastMessageWithLogo(
                    'Please accept the terms and conditions', context);
                return;
              }
              Map<String, dynamic> facebookUserData =
                  await GenericAuthProvider.instance.loginWithFacebook();
              if (facebookUserData['id'] != null) {
                String? fcmToken = await FCMService.instance.getFCMToken();
                String? deviceId = await getDeviceId();
                Map<String, dynamic> reqBody = {
                  'social_id': '',
                  'reg_id': fcmToken,
                  'dev_id': deviceId,
                  'dev_type': Platform.isAndroid ? 'android' : 'ios',
                  'phone': '',
                  'name': facebookUserData['name'],
                  'email': '',
                  'continent': countryContinent?.continent,
                  'Country': countryContinent?.country,
                  'isAddingAccount': false,
                  'userName': '',
                  'facebookId': facebookUserData['id'],
                  'snapchatId': '',
                  'facebookUserName': facebookUserData['name']
                };
                apiCallProvider.postRequest(API.socialLogin, reqBody).then(
                  (value) {
                    if (apiCallProvider.status == ApiStatus.success) {
                      if (value['success'] == '1') {
                        showToastMessageWithLogo(
                            '${value['message']}', context);
                        prefs.setString(
                            PrefsKey.userId, value['details']['id']);
                        prefs.setString(
                            PrefsKey.userName, value['details']['username']);
                        prefs.setString(PrefsKey.loginProvider, 'Facebook');
                        Navigator.of(context).pushNamedAndRemoveUntil(
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
                  loginSnapchat(context);
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

  Future<void> loginSnapchat(BuildContext context) async {
    showToastMessageWithLogo('Coming soon', context);
    return;
    // try {
    //   final String result = await platform.invokeMethod('login');
    //   print(result);
    // } on PlatformException catch (e) {
    //   print("Failed to log in: '${e.message}'.");
    // }
  }

  void fetchLocationInfo() async {
    countryContinent = await LocationService().getCurrentLocation();
    log('Fetched user location');
    log('Country : ${countryContinent?.country}');
    log('continent : ${countryContinent?.continent}');
    log('LatLong : ${countryContinent?.position?.latitude},${countryContinent?.position?.longitude}');
  }

  
}
