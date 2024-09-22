import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../utils/helpers.dart';
import '../../../widgets/gaps.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});
  static const String route = '/privacyScreen';

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  late ApiCallProvider apiCallProvider;
  UserProfileDetail? user;

  bool isPrivacyOn = false;

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
          isPrivacyOn = (user?.countryShowUnshow ?? '0') == '1';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Privacy'),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          value: isPrivacyOn,
          onChanged: (value) {
            setState(() {
              showHideUnhide();
            });
          },
          title: const Text(
            'Hide Country',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: const Text(
            'On the profile page, your country will appear as unknown country(exclusive privilege of VIP 4)',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
      ],
    );
  }

  void showHideUnhide() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tips',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              verticalGap(20),
              const Text(
                'VIP exclusive privilege. Activate VIP 4 then you can use it.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                textAlign: TextAlign.end,
              ),
              verticalGap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  horizontalGap(20),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context, rootNavigator: true).pop();
                        Map<String, dynamic> reqBody = {
                          'userId': user?.id,
                        };

                        await apiCallProvider
                            .postRequest(API.hideUnHideCountry, reqBody)
                            .then((value) {
                          if (value['message'] != null) {
                            showToastMessage(value['message']);

                            loadUserData();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFF73201),
                      ),
                      child: const Text(
                        'Activate',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
