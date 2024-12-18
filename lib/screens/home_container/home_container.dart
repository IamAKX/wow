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
    readReciptListner();
    appLinks.uriLinkStream.listen((uri) {
      log('uri deeplink = $uri');
    });
  }

  @override
  void dispose() {
    FirebaseDbService.updateOnlineStatus(
        prefs.getString(PrefsKey.userId) ?? '', 'Offline');
    friendRequestListner.cancel();
    unreadMsgListner.cancel();
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
              isLabelVisible: (requestCount + unreadCount) > 0,
              label: Text('${requestCount + unreadCount}'),
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
  late StreamSubscription<DatabaseEvent> unreadMsgListner;
  int requestCount = 0;
  int unreadCount = 0;
  void firebaseListners() {
    friendRequestListner = database
        .ref(
            '${FirebaseDbNode.friendRequestList}/${prefs.getString(PrefsKey.userId)}')
        .onValue
        .listen((event) async {
      final friendRequestDataSnapshot = event.snapshot;
      requestCount = 0;
      if (friendRequestDataSnapshot.exists) {
        log('dataSnapshot.children = ${friendRequestDataSnapshot.children.length}');
        requestCount = friendRequestDataSnapshot.children.length;
        if (mounted) setState(() {});
      } else {
        requestCount = 0;
        if (mounted) setState(() {});
      }
    });
  }

  void readReciptListner() {
    unreadMsgListner = database
        .ref(
            '${FirebaseDbNode.chatReadReceipt}/${prefs.getString(PrefsKey.userId)}')
        .onValue
        .listen((event) async {
      final readReceiptDataSnapshot = event.snapshot;

      Map<dynamic, dynamic> readReceiptMap = {};
      unreadCount = 0;
      if (readReceiptDataSnapshot.exists) {
        readReceiptMap = readReceiptDataSnapshot.value as Map;
        log('readReceiptMap : $readReceiptMap');
        readReceiptMap.forEach((key, value) {
          if (value is int) {
            // Ensure the value is an integer or numeric
            unreadCount += value;
          }
        });
        log('unreadCount : $unreadCount');

        if (mounted) setState(() {});
      } else {
        readReceiptMap.clear();
        log('unreadCount : $unreadCount');
        unreadCount = 0;
        if (mounted) setState(() {});
      }
    });
  }
}
