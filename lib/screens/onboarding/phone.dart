import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/models/phone_number.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/verify_phone.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});
  static const String route = '/PhoneScreen';
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _phoneCtrl = TextEditingController();
  bool isNextEnabled = false;
  CountryCode selectedCountryCode = CountryCode.fromDialCode('+91');

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
      appBar: AppBar(),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    selectedCountryCode.localize(context);
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
                    ? () {
                        if (_phoneCtrl.text.isEmpty) {
                          showToastMessageWithLogo(
                              'Enter your phone number', context);
                          return;
                        }
                        Navigator.of(context).pushNamed(
                          VerifyPhoneScreen.route,
                          arguments: PhoneNumberModel(
                            countryCode: selectedCountryCode,
                            phoneNumber: _phoneCtrl.text,
                          ),
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
              Text(
                'More',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.withOpacity(0.7),
                ),
              ),
              horizontalGap(10),
              Container(
                width: 50,
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
            ],
          ),
          verticalGap(pagePadding),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: gradientButton(),
            ),
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
}
