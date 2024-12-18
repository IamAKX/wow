import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/generic_api_calls.dart';

class DiamondHelp extends StatefulWidget {
  const DiamondHelp({super.key});
  static const String route = '/diamondHelp';

  @override
  State<DiamondHelp> createState() => _DiamondHelpState();
}

class _DiamondHelpState extends State<DiamondHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Help Center'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      children: [
        Text(
          '1. The purchased Diamonds/Coins/Items didn\'t arrive?',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFFD34E4D),
          ),
        ),
        verticalGap(10),
        Text(
          '• The transaction may take 10-30 minutes to proceed.\n• Please try to refresh the page.\n• If you did not get the Diamonds/Coins/Item after refreshing and no refund was sent, please share feedback ID, Time, details of issues we will check and feedback to you. Our services email is hello@wows.co.in',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        verticalGap(20),
        Text(
          '2. What\'s Diamonds?',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFFD34E4D),
          ),
        ),
        verticalGap(10),
        Text(
          '• The number of Diamonds in your account increases when you receive gifts.\n• Diamonds can be used to redeem Coins .\n• The corresponding platform rules stipulate the means to obtain and calculate Diamonds, and Wow\'s has the right of final interpretation and execution.\n• If your behavior violates any laws, regulations or wows platform rules. or if the Diamonds in your account are earned as a result of malicious refunds, card frauds, cyber hacking and other illegal operations, no matter whether adverse consequences have been caused.\n• Wow\'s reserves the right to take appropriate action and right to deduct from the Diamonds balance in your account at its sole discretion. Other issues',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        verticalGap(20),
        Text(
          '3. Other issues',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFFD34E4D),
          ),
        ),
        verticalGap(10),
        Text(
          '• If you meet any other issues, like: if the item can\'t be purchased, please contact on hello@wows.co.in and state the issues you have met, we will sort it out as soon as possible.',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        verticalGap(20),
      ],
    );
  }
}
