import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/models/phone_number.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../onboarding/verify_otp.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({super.key});
  static const String route = '/ChangePhoneScreen';
  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  final TextEditingController _phoneCtrl = TextEditingController();
  bool isNextEnabled = false;
  bool isLoading = false;
  CountryCode selectedCountryCode = CountryCode.fromDialCode('+91');
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    _phoneCtrl.addListener(() {
      setState(() {
        isNextEnabled = _phoneCtrl.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Phone Number'),
      ),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    selectedCountryCode.localize(context);
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Input your number'),
          Padding(
            padding: const EdgeInsets.only(top: pagePadding),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: CountryCodePicker(
                    showDropDownButton: true,
                    onChanged: (c) {
                      setState(() {
                        selectedCountryCode = c;
                      });
                    },
                    initialSelection: selectedCountryCode.dialCode,
                    showCountryOnly: false,
                    showFlagDialog: true,
                    showFlag: false,
                    showFlagMain: false,
                    showOnlyCountryWhenClosed: false,
                    favorite: const ['+91'],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.black,
                  margin: const EdgeInsets.only(right: 20),
                ),
                Expanded(
                  child: TextField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: 'Enter you phone number',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black,
            margin: const EdgeInsets.only(left: 10, right: 10),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isNextEnabled
                    ? () async {
                        if (_phoneCtrl.text.isEmpty) {
                          showToastMessageWithLogo(
                              'Enter your phone number', context);
                          return;
                        }
                        PhoneNumberModel phoneNumberModel = PhoneNumberModel(
                          countryCode: selectedCountryCode,
                          phoneNumber: _phoneCtrl.text,
                        );
                        Map<String, dynamic> reqBody = {
                          'phone':
                              '${phoneNumberModel.countryCode?.dialCode}${phoneNumberModel.phoneNumber}'
                                  .replaceAll('+', '')
                        };
                        await apiCallProvider
                            .postRequest(API.checkNumber, reqBody)
                            .then(
                          (value) {
                            if (apiCallProvider.status == ApiStatus.success) {
                              if (value['isRegistered'] == 'false') {
                                sendOtp(context, phoneNumberModel);
                              } else {
                                showToastMessage(value['message']);
                              }
                            } else {
                              showToastMessageWithLogo(
                                  'Request failed', context);
                            }
                          },
                        );
                      }
                    : null,
                style: ButtonStyle(
                  shape:
                      WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.disabled)) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        );
                      }
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      );
                    },
                  ),
                  elevation: WidgetStateProperty.resolveWith<double>(
                    (Set<WidgetState> states) {
                      return 0;
                    },
                  ),
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.disabled)) {
                        return Colors.grey.withOpacity(0.3);
                      }
                      return Colors.red;
                    },
                  ),
                ),
                child: const Text('Next'),
              ),
            ),
          ),
          verticalGap(pagePadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
              horizontalGap(10),
            ],
          ),
        ],
      ),
    );
  }

  Container gradientButton() {
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: const LinearGradient(
          colors: [buttonGradientPurple, buttonGradientPink],
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: const Text(
        'Back to Log in',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> sendOtp(
      BuildContext context, PhoneNumberModel phoneNumberModel) {
    setState(() {
      isLoading = true;
    });
    log('${phoneNumberModel.countryCode?.dialCode}${phoneNumberModel.phoneNumber}');
    return FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:
          '${phoneNumberModel.countryCode?.dialCode}${phoneNumberModel.phoneNumber}',
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (firebaseAuthException) {
        setState(() {
          isLoading = false;
        });
        log(firebaseAuthException.toString());
        showToastMessageWithLogo(
            'Error : ${firebaseAuthException.message}', context);
      },
      codeSent: (verificationId, forceResendingToken) async {
        setState(() {
          isLoading = false;
        });
        phoneNumberModel.verificationId = verificationId;
        Navigator.of(context)
            .pushNamed(VerifyOtpScreen.route, arguments: phoneNumberModel)
            .then((res) async {
          if (res == true) {
            Map<String, dynamic> reqBody = {
              'userId': prefs.getString(PrefsKey.userId),
              'phoneNumber':
                  '${phoneNumberModel.countryCode?.dialCode}${phoneNumberModel.phoneNumber}'
                      .replaceAll('+', '')
            };
            await apiCallProvider
                .postRequest(API.updatePhoneNumber, reqBody)
                .then(
              (value) {
                showToastMessage(value['message']);
                Navigator.of(context).pop();
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

