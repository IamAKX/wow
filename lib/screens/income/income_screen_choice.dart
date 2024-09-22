import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/income/diamond_help.dart';
import 'package:worldsocialintegrationapp/screens/income/income_Screen.dart';
import 'package:worldsocialintegrationapp/screens/income/live_record.dart';
import 'package:worldsocialintegrationapp/screens/income/withdrawl.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/generic_api_calls.dart';

class IncomeChoiceScreen extends StatefulWidget {
  const IncomeChoiceScreen({super.key});
  static const String route = '/incomeChoiceScreen';

  @override
  State<IncomeChoiceScreen> createState() => _IncomeChoiceScreenState();
}

class _IncomeChoiceScreenState extends State<IncomeChoiceScreen> {
  UserProfileDetail? user;

  late ApiCallProvider apiCallProvider;

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
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF5F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Income'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(LiveRecord.route);
            },
            child: const Text('Live Record'),
          )
        ],
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Diamonds available',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(25),
          alignment: Alignment.center,
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/image/new_diamond.png',
                width: 25,
                height: 25,
                fit: BoxFit.fill,
              ),
              horizontalGap(10),
              Text(
                user?.myDiamond ?? '0',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: const Text(
            'If you receive a gift, you will receive diamonds by rate.',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
        const Spacer(),
        Container(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(WithdrawlScreen.route);
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xFF059AE6),
              ),
              child: const Text(
                'Withdrawl',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        Container(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(IncomeScreen.route);
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xFF0CA52B),
              ),
              child: const Text(
                'Exchange to Coins',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        verticalGap(20),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(DiamondHelp.route);
            },
            child: const Column(
              children: [
                Icon(
                  Icons.help_outline,
                  color: Colors.grey,
                ),
                const Text(
                  'What\'s the use of diamonds?',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
