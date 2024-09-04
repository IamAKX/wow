import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polar_tab_bar/models/polar_tab_item.dart';
import 'package:polar_tab_bar/polar_tab_bar.dart';
import 'package:polar_tab_bar/widgets/polar_tab_page.dart';
import 'package:worldsocialintegrationapp/screens/home_container/related/square_screen.dart';

class MomentsScreen extends StatefulWidget {
  const MomentsScreen({super.key});
  static const String route = '/momentsScreen';

  @override
  State<MomentsScreen> createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen> {
  final List<PolarTabItem> tabs = [
    PolarTabItem(
      index: 0,
      title: 'Sqaure',
      page: PolarTabPage(
        child: SquareScreen(),
      ),
    ),
    PolarTabItem(
      index: 1,
      title: 'Friends & Following',
      page: PolarTabPage(child: Container()),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.redAccent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Moments'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PolarTabBar(
            tabs: tabs,
            background: const Color(0xFFD6D6D6),
          ),
        ),
      ),
    );
  }
}
