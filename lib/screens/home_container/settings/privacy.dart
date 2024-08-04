import 'package:flutter/material.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});
  static const String route = '/privacyScreen';

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool isPrivacyOn = false;

  @override
  Widget build(BuildContext context) {
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
              isPrivacyOn = !isPrivacyOn;
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
}
