import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});
  static const String route = '/aboutUsScreen';

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF6F7F9),
        appBar: AppBar(
          title: const Text('About'),
          backgroundColor: Colors.white,
        ),
        body: getBody(context));
  }

  getBody(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          verticalGap(40),
          Image.asset(
            'assets/image/security.png',
            width: 80,
            color: const Color(0xFFD32E2F),
          ),
          verticalGap(20),
          const Text(
            'Wows 2.0',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w200,
            ),
          ),
          verticalGap(20),
          ListTile(
            tileColor: Colors.white,
            title: const Text(
              'Rate Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => openInBrowser(API.privacyPolicy),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text(
              'Terms of Service',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => openInBrowser(API.termsOfService),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text(
              'Privacy Policy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => openInBrowser(API.privacyPolicy),
          ),
          const Spacer(),
          const Text(
            'Copyright @2018-2022 Wows Media Limited',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w200,
              fontSize: 12,
            ),
          ),
          const Text(
            'All Right Reserved',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w200,
              fontSize: 12,
            ),
          ),
          verticalGap(30),
        ],
      ),
    );
  }
}
