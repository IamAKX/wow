import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/phone_verification.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class ConnectedAccountScreen extends StatefulWidget {
  const ConnectedAccountScreen({super.key});
  static const String route = '/connectedAccountScreen';

  @override
  State<ConnectedAccountScreen> createState() => _ConnectedAccountScreenState();
}

class _ConnectedAccountScreenState extends State<ConnectedAccountScreen> {
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
          leading: SvgPicture.asset(
            'assets/svg/smartphone_call.svg',
            width: 22,
            color: const Color(0xFF92BA7C),
          ),
          title: const Text('Phone'),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('919999999992'),
              Icon(Icons.chevron_right),
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
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add'),
              Icon(Icons.chevron_right),
            ],
          ),
          tileColor: Colors.white,
          onTap: () {},
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
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add'),
              Icon(Icons.chevron_right),
            ],
          ),
          tileColor: Colors.white,
          onTap: () {},
        ),
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
