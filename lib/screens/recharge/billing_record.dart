import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/screens/home_container/mall/cars.dart';
import 'package:worldsocialintegrationapp/screens/home_container/mall/frames.dart';
import 'package:worldsocialintegrationapp/screens/recharge/coins_billing.dart';
import 'package:worldsocialintegrationapp/screens/recharge/silver_coins_billing.dart';

class BillingRecord extends StatefulWidget {
  const BillingRecord({super.key});
  static const String route = '/billingRecord';

  @override
  State<BillingRecord> createState() => _BillingRecordState();
}

class _BillingRecordState extends State<BillingRecord>
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
        title: const Text('Billing Records'),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: Color(0xFFF73400),
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            insets: EdgeInsets.symmetric(horizontal: 50.0),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          indicatorColor: Colors.grey,
          indicatorPadding: const EdgeInsets.only(bottom: 10),
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF73400),
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
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
          CoinBilling(),
          SilverCoinBilling(),
        ],
      ),
    );
  }
}
