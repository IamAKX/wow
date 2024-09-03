import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/create_event_one.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/subscription_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/whats_on_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/create_family.dart';

import '../../../providers/api_call_provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});
  static const String route = '/eventScreen';

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.redAccent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text(
          'Events',
        ),
        bottom: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: Colors.red,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            insets: EdgeInsets.symmetric(horizontal: 50.0),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          indicatorColor: Colors.red,
          indicatorPadding: const EdgeInsets.only(bottom: 10),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          tabs: const [
            Tab(
              text: 'WHAT\'S ON',
            ),
            Tab(
              text: 'SUBSCRIPTION',
            ),
          ],
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              WhatsOnScreen(),
              SubscriptionScreen(),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green, // Text color
              shadowColor: Colors.green, // No shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                CreateEventOne.route,
              );
            },
            child: const Text('I wanna party!'),
          ),
        )
      ],
    );
  }
}
