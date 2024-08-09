import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/models/phone_number.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/splash.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';

import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/helpers.dart';
import '../../widgets/gaps.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.phoneNumberModel});
  static const String route = '/resetPassword';
  final PhoneNumberModel phoneNumberModel;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  bool obsurePassword = true;
  late ApiCallProvider apiCallProvider;

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
          'Reset Password',
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
          InkWell(
            onTap: () {
              Map<String, dynamic> reqBody = {
                'phone':
                    '${widget.phoneNumberModel.countryCode?.dialCode}${widget.phoneNumberModel.phoneNumber}'
                        .replaceAll('+', ''),
                'password': _passwordCtrl.text,
              };

              apiCallProvider.postRequest(API.resetPassword, reqBody).then(
                (value) {
                  if (apiCallProvider.status == ApiStatus.success) {
                    if (value['success'] == '1') {
                      showToastMessageWithLogo('${value['message']}', context);

                      Navigator.of(context).pushNamedAndRemoveUntil(
                        SplashScreen.route,
                        (route) => false,
                        arguments: widget.phoneNumberModel,
                      );
                    } else {
                      showToastMessageWithLogo('${value['message']}', context);
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
