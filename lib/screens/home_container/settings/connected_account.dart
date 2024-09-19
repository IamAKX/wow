import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/providers/connect_social_account.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/phone_verification.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/country_continent.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../providers/generic_auth_provider.dart';
import '../../../services/fcm_service.dart';
import '../../../services/location_service.dart';
import '../../../utils/api.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../utils/helpers.dart';

class ConnectedAccountScreen extends StatefulWidget {
  const ConnectedAccountScreen({super.key});
  static const String route = '/connectedAccountScreen';

  @override
  State<ConnectedAccountScreen> createState() => _ConnectedAccountScreenState();
}

class _ConnectedAccountScreenState extends State<ConnectedAccountScreen> {
  UserProfileDetail? user;
  late ApiCallProvider apiCallProvider;
  CountryContinent? countryContinent;
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
        user = value;
        log('sid = ${user?.socialId}');
        setState(() {});
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
        ListTile(
          leading: SvgPicture.asset(
            'assets/svg/smartphone_call.svg',
            width: 22,
            color: const Color(0xFF92BA7C),
          ),
          title: const Text('Phone'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(user?.phone ?? ''),
              const Icon(Icons.chevron_right),
            ],
          ),
          tileColor: Colors.white,
          onTap: () {
            Navigator.of(context).pushNamed(PhoneVerificationScreen.route);
          },
        ),
        const Divider(
          height: 1,
          color: Color(0xFFE5E5E5),
        ),
        ListTile(
          leading: SvgPicture.asset(
            'assets/svg/facebook_1_.svg',
            width: 22,
          ),
          title: const Text('Facebook'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text((user?.facebookUserName?.isNotEmpty ?? false)
                  ? user?.facebookUserName ?? ''
                  : 'ADD'),
              Icon(Icons.chevron_right),
            ],
          ),
          tileColor: Colors.white,
          onTap: (user?.email?.isNotEmpty ?? false)
              ? () async {
                  showUnboundPrompt(context, () async {
                    await ConnectSocialAccount().logoutWithFacebook();

                    Map<String, dynamic> reqBody = {
                      'socialIdType': 'facebookId',
                      'userId': user?.id
                    };
                    apiCallProvider
                        .postRequest(API.removeSocialIds, reqBody)
                        .then(
                      (value) {
                        showToastMessage(value['message']);
                        loadUserData();
                      },
                    );
                  });
                }
              : () async {
                  Map<String, dynamic> facebookUserData =
                      await ConnectSocialAccount().loginWithFacebook();
                  if (facebookUserData['id'] != null) {
                    Map<String, dynamic> reqBody = {
                      'isAddGoogleId': 'No',
                      'googleSocialId': '',
                      'googleEmailId': '',
                      'facebookId': facebookUserData['id'],
                      'facebookUserName': facebookUserData['name'],
                      'userId': user?.id
                    };
                    apiCallProvider.postRequest(API.addSocialIds, reqBody).then(
                      (value) async {
                        if (value['success'] == '0') {
                          await ConnectSocialAccount().logoutWithFacebook();
                        }
                        showToastMessage(value['message']);
                        loadUserData();
                      },
                    );
                  }
                },
        ),
        const Divider(
          height: 1,
          color: Color(0xFFE5E5E5),
        ),
        ListTile(
            leading: SvgPicture.asset(
              'assets/svg/google.svg',
              width: 22,
            ),
            title: const Text('Google'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text((user?.socialId?.isNotEmpty ?? false)
                    ? user?.email ?? ''
                    : 'ADD'),
                Icon(Icons.chevron_right),
              ],
            ),
            tileColor: Colors.white,
            onTap: (user?.socialId?.isNotEmpty ?? false)
                ? () async {
                    showUnboundPrompt(context, () async {
                      await ConnectSocialAccount().logoutWithGoogle();
                      Map<String, dynamic> reqBody = {
                        'socialIdType': 'gmailId',
                        'userId': user?.id
                      };
                      apiCallProvider
                          .postRequest(API.removeSocialIds, reqBody)
                          .then(
                        (value) {
                          showToastMessage(value['message']);
                          loadUserData();
                        },
                      );
                    });
                  }
                : () async {
                    GoogleSignInAccount? googleSignInAccount =
                        await ConnectSocialAccount().loginWithGoogle();
                    if (googleSignInAccount != null) {
                      Map<String, dynamic> reqBody = {
                        'isAddGoogleId': 'Yes',
                        'googleSocialId': googleSignInAccount.id,
                        'googleEmailId': googleSignInAccount.email,
                        'facebookId': '',
                        'facebookUserName': '',
                        'userId': user?.id
                      };
                      apiCallProvider
                          .postRequest(API.addSocialIds, reqBody)
                          .then(
                        (value) async {
                          if (value['success'] == '0') {
                            await ConnectSocialAccount().logoutWithGoogle();
                          }
                          showToastMessage(value['message']);
                          loadUserData();
                        },
                      );
                    }
                  }),
        const Divider(
          height: 1,
          color: Color(0xFFE5E5E5),
        ),
        Container(
          width: double.infinity,
          height: pagePadding,
          color: Colors.white,
        ),
        const Divider(
          height: 1,
          color: Color(0xFFE5E5E5),
        ),
        ListTile(
          leading: SvgPicture.asset(
            'assets/svg/cancel.svg',
            width: 30,
          ),
          title: const Text('Delete account'),
          trailing: const Icon(Icons.chevron_right),
          tileColor: Colors.white,
          onTap: () {
            showDeleteAccountDialog(context);
          },
        ),
        const Divider(
          height: 1,
          color: Color(0xFFE5E5E5),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(pagePadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Why to Connect Account?',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                verticalGap(10),
                const Text(
                  'Connect to Phone is recommended to protect your WOW! Live account.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                ),
                const Text(
                  'Your connected phone will be used to recieve verification code when account setting changed.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                ),
                const Text(
                  'Once connected, you can easily to log in WOW! Live with any connected account from anywhere.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                ),
                const Text(
                  'You can set to show your social account to your profile.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                ),
                verticalGap(20),
                const Text(
                  'If you want to unbound your social account, tap on the linked email/account number.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                ),
              ],
            ),
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
          'Connected Accounts',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void showUnboundPrompt(BuildContext context, Function funtion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unbound Account'),
          content: const Text(
              'Are you sure you want to unbound your social account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                funtion();
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }

  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }
}
