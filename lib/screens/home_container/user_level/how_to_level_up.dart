import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';

class HowToLevelUp extends StatefulWidget {
  static const String route = '/howToLevelUp';

  const HowToLevelUp({super.key});

  @override
  State<HowToLevelUp> createState() => _HowToLevelUpState();
}

class _HowToLevelUpState extends State<HowToLevelUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to level up?'),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.orange,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close), // Replace with your custom icon
          onPressed: () {
            Navigator.of(context, rootNavigator: true)
                .pop(); // Default back navigation
          },
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFF6F0FF),
            child: Image.asset(
              'assets/image/gifts_3.png',
              width: 20,
              color: const Color(0xFF9E50FF),
            ),
          ),
          title: const Text(
            'Send Gifts',
            style: TextStyle(
              color: Color(0xFF787878),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            '1 coin = 1 Exp',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Text(
            '+1',
            style: TextStyle(
              color: Color(0xFFC39955),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(
          color: hintColor,
          indent: 20,
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFFFEEF6),
            child: Image.asset(
              'assets/image/car_2.png',
              width: 20,
              color: const Color(0xFFFF3F96),
            ),
          ),
          title: const Text(
            'Buy Cars',
            style: TextStyle(
              color: Color(0xFF787878),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            '1 coin = 1 Exp',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Text(
            '+1',
            style: TextStyle(
              color: Color(0xFFC39955),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(
          color: hintColor,
          indent: 20,
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFDDFAFF),
            child: Image.asset(
              'assets/image/account_1.png',
              width: 20,
              color: const Color(0xFF00ABF8),
            ),
          ),
          title: const Text(
            'Buy Frames',
            style: TextStyle(
              color: Color(0xFF787878),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            '1 coin = 1 Exp',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Text(
            '+1',
            style: TextStyle(
              color: Color(0xFFC39955),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(
          color: hintColor,
          indent: 20,
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFFFEDEF),
            child: Image.asset(
              'assets/image/love_mesage.png',
              width: 20,
            ),
          ),
          title: const Text(
            'Buy a bubble',
            style: TextStyle(
              color: Color(0xFF787878),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            '1 coin = 1 Exp',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Text(
            '+1',
            style: TextStyle(
              color: Color(0xFFC39955),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(
          color: hintColor,
          indent: 20,
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFFFEDEF),
            child: Image.asset(
              'assets/image/vip.png',
              width: 20,
              color: const Color(0xFFC09855),
            ),
          ),
          title: const Text(
            'Buy VIP',
            style: TextStyle(
              color: Color(0xFF787878),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            '1 coin = 1 Exp',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Text(
            '+1',
            style: TextStyle(
              color: Color(0xFFC39955),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
