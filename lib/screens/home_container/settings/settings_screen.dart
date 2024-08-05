import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worldsocialintegrationapp/providers/auth_provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/about_us.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/blocked_user.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/connected_account.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/privacy.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/splash.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const String route = '/settingsScreen';
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        getTopBar(),
        ListTile(
          title: const Text('Connected Accounts'),
          tileColor: Colors.white,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationX(3.14159),
                child: SvgPicture.asset(
                  'assets/svg/unprotected.svg',
                  width: 20,
                  color: const Color(0xFFD00201),
                ),
              ),
              horizontalGap(5),
              const Text(
                'Unprotected',
                style: TextStyle(
                  color: Color(0xFFD00201),
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ConnectedAccountScreen.route);
          },
        ),
        const Divider(
          color: Color(0xFFF9F9F9),
          height: 1,
        ),
        ListTile(
          tileColor: Colors.white,
          title: const Text('Privacy'),
          onTap: () {
            Navigator.of(context).pushNamed(PrivacyScreen.route);
          },
        ),
        const Divider(
          height: 1,
          color: Color(0xFFF9F9F9),
        ),
        ListTile(
          tileColor: Colors.white,
          title: const Text('Blocked List'),
          onTap: () {
            Navigator.of(context).pushNamed(BlockedUserScreen.route);
          },
        ),
        const Divider(
          height: 10,
          color: Color(0xFFF9F9F9),
        ),
        ListTile(
          tileColor: Colors.white,
          title: const Text('About Us'),
          onTap: () {
            Navigator.of(context).pushNamed(AboutUsScreen.route);
          },
        ),
        const Divider(
          height: 1,
          color: Color(0xFFF9F9F9),
        ),
        ListTile(
          tileColor: Colors.white,
          title: const Text('Clean Cache'),
          onTap: () {
            showCleanCacheDialog(context);
          },
        ),
        const Divider(
          height: 10,
          color: Color(0xFFF9F9F9),
        ),
        ListTile(
          tileColor: Colors.white,
          title: const Text('Sign Out'),
          onTap: () {
            showLogoutDialog(context);
          },
        ),
        const Divider(
          height: 1,
          color: Color(0xFFF9F9F9),
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
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void showCleanCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              const Text('Are you sure do you want to clean your storage?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await GenericAuthProvider.instance.logoutUser().then(
                  (value) {
                    log('loging out');
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      SplashScreen.route,
                      (route) => false,
                    );
                  },
                );
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () async {
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
