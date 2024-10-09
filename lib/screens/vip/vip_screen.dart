import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/screens/vip/vip_options.dart';

class VipScreen extends StatefulWidget {
  static const String route = '/vipScreen';
  const VipScreen({super.key});

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
        title: Text(
          'VIP Center',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF080A20),
        iconTheme: IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: Color(0xFFC5A36C),
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            insets: EdgeInsets.symmetric(horizontal: 50.0),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          indicatorColor: Color(0xFFC5A36C),
          indicatorPadding: const EdgeInsets.only(bottom: 10),
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC5A36C),
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          tabs: const [
            Tab(
              text: 'VIP1',
            ),
            Tab(
              text: 'VIP2',
            ),
            Tab(
              text: 'VIP3',
            ),
            Tab(
              text: 'VIP4',
            ),
            Tab(
              text: 'VIP5',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          VipOptions(),
          VipOptions(),
          VipOptions(),
          VipOptions(),
          VipOptions(),
        ],
      ),
    );
  }
}
