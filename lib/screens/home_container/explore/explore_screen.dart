import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worldsocialintegrationapp/screens/home_container/explore/game.dart';
import 'package:worldsocialintegrationapp/screens/home_container/explore/meet.dart';
import 'package:worldsocialintegrationapp/screens/home_container/explore/more.dart';
import 'package:worldsocialintegrationapp/screens/home_container/explore/wow_leaderboard.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../utils/dimensions.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 1;
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
              GameScreen(),
              MeetScreen(),
              MoreScreen(),
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
                insets: EdgeInsets.symmetric(horizontal: 30.0),
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
                  text: 'GAMES  ',
                ),
                Tab(
                  text: 'MEET',
                ),
                Tab(text: '  MORE'),
              ],
            ),
          ),
          horizontalGap(120),
          IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(WowLeaderboard.route);
            },
            icon: SvgPicture.asset('assets/svg/trophy.svg'),
          ),
        ],
      ),
    );
  }
}
