import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worldsocialintegrationapp/screens/recharge/billing_record.dart';
import 'package:worldsocialintegrationapp/screens/recharge/coins.dart';
import 'package:worldsocialintegrationapp/screens/recharge/silver_coins.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});
  static const String route = '/RechargeScreen';

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFE3400),
                Color(0xffFBC108),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.receipt_long_rounded),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(BillingRecord.route);
            },
          ),
        ],
        title: const Text(
          'Wallet',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: Colors.white,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            insets: EdgeInsets.symmetric(horizontal: 50.0),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          indicatorColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.only(bottom: 10),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          tabs: const [
            Tab(
              text: 'COINS',
            ),
            Tab(
              text: 'SILVER COINS',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Coins(),
          SilverCoins(),
        ],
      ),
    );
  }
}
