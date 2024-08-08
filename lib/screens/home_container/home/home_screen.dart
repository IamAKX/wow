import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home/popular.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home/related.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';

import '../../../main.dart';
import '../../../utils/prefs_key.dart';
import '../profile/edit_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (prefs.getBool(PrefsKey.showProfileUpdatePopup) ?? false) {
        showUpdateProfilePopup();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        getTopBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              RelatedScreen(),
              PopularScreen(),
              Center(
                  child: Text(
                'Result Not Found',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Container getTopBar() {
    return Container(
      padding: const EdgeInsets.only(
        top: pagePadding * 2,
        bottom: pagePadding,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xffF30CDF),
            Color(0xff871AFD),
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              controller: _tabController,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.white,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
                insets: EdgeInsets.symmetric(horizontal: 40.0),
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 5),
              indicatorColor: Colors.white,
              indicatorPadding: const EdgeInsets.only(bottom: 10),
              labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 1.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 1.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              tabs: const [
                Tab(
                  text: 'RELATED',
                ),
                Tab(
                  text: 'POPULAR',
                ),
                Tab(text: 'NEAR BY'),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/svg/go_live.svg',
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  void showUpdateProfilePopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile'),
          content: const Text('Please Edit Your Profile First!'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(EditProfile.route);
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
