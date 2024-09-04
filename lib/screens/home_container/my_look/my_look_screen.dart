import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/screens/home_container/my_look/my_bubble.dart';
import 'package:worldsocialintegrationapp/screens/home_container/my_look/my_frame.dart';

import 'my_car.dart';

class MyLookScreen extends StatefulWidget {
  const MyLookScreen({super.key});
  static const String route = '/myLookScreen';

  @override
  State<MyLookScreen> createState() => _MyLookScreenState();
}

class _MyLookScreenState extends State<MyLookScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: const Text('My Look'),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: Color(0xFFF73400),
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            insets: EdgeInsets.symmetric(horizontal: 10.0),
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
              text: 'MY CARS',
            ),
            Tab(
              text: 'MY FRAMES',
            ),
            Tab(
              text: 'BUBBLE',
            ),
            Tab(
              text: 'THEMES',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyCars(),
          MyFrame(),
          MyBubble(),
          Container(),
        ],
      ),
    );
  }
}
