import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/screens/home_container/chat/chat_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/explore/explore_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home/home_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/profile_screen.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';

import '../../services/firebase_db_service.dart';
import '../../utils/firebase_db_node.dart';

class HomeContainer extends StatefulWidget {
  static const String route = '/homeContainer';
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int _selectedIndex = 0;
  final appLinks = AppLinks();
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static const List<Widget> screenList = <Widget>[
    HomeScreen(),
    ExploreScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseDbService.updateOnlineStatus(
        prefs.getString(PrefsKey.userId) ?? '', 'Online');
    firebaseListners();
    appLinks.uriLinkStream.listen((uri) {
      log('uri deeplink = $uri');
    });
  }

  @override
  void dispose() {
    FirebaseDbService.updateOnlineStatus(
        prefs.getString(PrefsKey.userId) ?? '', 'Offline');
    friendRequestListner.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bottom_nav_home.svg',
              height: 24,
              width: 24,
              color: bottomNavBarUnselectedColor,
            ),
            activeIcon: SvgPicture.asset(
              'assets/svg/bottom_nav_home.svg',
              height: 24,
              width: 24,
              color: bottomNavBarSelectedColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/svg/bottom_nav_explore.svg',
              height: 24,
              width: 24,
              color: bottomNavBarSelectedColor,
            ),
            icon: SvgPicture.asset(
              'assets/svg/bottom_nav_explore.svg',
              height: 24,
              width: 24,
              color: bottomNavBarUnselectedColor,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/svg/bottom_nav_chat.svg',
              height: 24,
              width: 24,
              color: bottomNavBarSelectedColor,
            ),
            icon: Badge(
              isLabelVisible: requestCount > 0,
              label: Text('${requestCount}'),
              offset: const Offset(0, -10),
              backgroundColor: Colors.red,
              child: SvgPicture.asset(
                'assets/svg/bottom_nav_chat.svg',
                height: 24,
                width: 24,
                color: bottomNavBarUnselectedColor,
              ),
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/svg/bottom_nav_profile.svg',
              height: 24,
              width: 24,
              color: bottomNavBarSelectedColor,
            ),
            icon: SvgPicture.asset(
              'assets/svg/bottom_nav_profile.svg',
              height: 24,
              width: 24,
              color: bottomNavBarUnselectedColor,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  late StreamSubscription<DatabaseEvent> friendRequestListner;
  int requestCount = 0;
  void firebaseListners() {
    friendRequestListner = database
        .ref(
            '${FirebaseDbNode.friendRequestList}/${prefs.getString(PrefsKey.userId)}')
        .onValue
        .listen((event) async {
      final dataSnapshot = event.snapshot;

      if (dataSnapshot.exists) {
        log('dataSnapshot.children = ${dataSnapshot.children.length}');
        requestCount = dataSnapshot.children.length;
        if (mounted) setState(() {});
      } else {
        requestCount = 0;
        if (mounted) setState(() {});
      }
    });
  }
}
