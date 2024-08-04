import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});
  static const String route = '/phoneVerificationScreen';

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
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
        verticalGap(60),
        SvgPicture.asset(
          'assets/svg/smartphone_1_.svg',
          color: const Color(0xFF3CB371),
          width: 100,
        ),
        verticalGap(20),
        const Text(
          '+919999999992',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        verticalGap(20),
        ListTile(
          leading: SvgPicture.asset(
            'assets/svg/smartphone_call.svg',
            width: 22,
          ),
          title: const Text('Change Phone Number'),
          trailing: const Icon(Icons.chevron_right),
          tileColor: Colors.white,
          onTap: () {},
        ),
        const Divider(
          height: 1,
          color: Color(0xFFF9F9F9),
        ),
        ListTile(
          leading: SvgPicture.asset(
            'assets/svg/open_lock.svg',
            width: 22,
          ),
          title: const Text('Change Password'),
          trailing: const Icon(Icons.chevron_right),
          tileColor: Colors.white,
          onTap: () {},
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
          'Phone Verification',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
