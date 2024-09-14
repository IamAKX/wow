import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/wow_leaderboard_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';

class WowLeaderboard extends StatefulWidget {
  static const String route = '/wowLeaderboard';

  const WowLeaderboard({super.key});

  @override
  State<WowLeaderboard> createState() => _WowLeaderboardState();
}

class _WowLeaderboardState extends State<WowLeaderboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ApiCallProvider apiCallProvider;
  List<WowLeaderboardModel> list = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(
      () {
        loadWowLeaderboard(_tabController.index + 1);
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadWowLeaderboard(1);
    });
  }

  loadWowLeaderboard(int type) {
    Map<String, dynamic> reqBody = {'get': 'sender', 'type': '$type'};
    list.clear();
    setState(() {});
    apiCallProvider.postRequest(API.getLeaderBoard, reqBody).then((value) {
      if (value['data'] != null) {
        for (var item in value['data']) {
          list.add(WowLeaderboardModel.fromJson(item));
        }
        setState(() {});
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
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return Scaffold(
      body: getBody(context),
    );
  }

  getAppbar() => SizedBox(
        height: 150,
        child: AppBar(
          title: const Text(
            'Wows Board',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
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
            indicatorColor: Colors.white,
            indicatorPadding: const EdgeInsets.only(bottom: 10),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
            tabs: const [
              Tab(
                text: 'Daily',
              ),
              Tab(
                text: 'Weekly',
              ),
              Tab(
                text: 'Monthly',
              ),
            ],
          ),
        ),
      );

  getBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/image/yohotab.jpg',
            ),
            fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          getAppbar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                list.isEmpty ? SizedBox() : loadLeaderboard(),
                list.isEmpty ? SizedBox() : loadLeaderboard(),
                list.isEmpty ? SizedBox() : loadLeaderboard(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget loadLeaderboard() {
    log('list : ${list.length}');
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (list.length >= 2)
                getMajorProfile(1)
              else
                const Expanded(child: SizedBox.shrink()),
              if (list.isNotEmpty)
                getMajorProfile(0)
              else
                const Expanded(child: SizedBox.shrink()),
              if (list.length >= 3)
                getMajorProfile(2)
              else
                const Expanded(child: SizedBox.shrink()),
            ],
          ),
        ),
        verticalGap(30),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFBE89FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                for (int i = 3; i < list.length; i++) ...{
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF8316FF),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${i + 1}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        horizontalGap(10),
                        CircularImage(
                            imagePath:
                                list.elementAt(i).userDetails?.image ?? '',
                            diameter: 50),
                        horizontalGap(10),
                        Text(
                          '${list.elementAt(i).userDetails?.name ?? ''}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/image/diamond.png',
                          width: 20,
                        ),
                        Text(
                          '${list.elementAt(i).diamond ?? ''}',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                }
              ],
            ),
          ),
        )
        // Container(
        //   color: Color(0xFFBE89FF),
        //   child: ListView.builder(
        //     itemBuilder: (context, index) {
        //       return Container(
        //         decoration: BoxDecoration(
        //           color: Color(0xFF8316FF),
        //         ),
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }

  getMajorProfile(int index) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularImage(
              imagePath: list.elementAt(index).userDetails?.image ?? '',
              diameter: index == 0 ? 100 : 70),
          verticalGap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/image/crown_king.png',
                  width: 20,
                ),
                Text(
                  '${list.elementAt(index).userDetails?.name ?? ''}',
                  style: const TextStyle(color: Colors.brown),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/image/diamond.png',
                  width: 20,
                ),
                Text(
                  '${list.elementAt(index).diamond ?? ''}',
                  style: const TextStyle(color: Colors.brown),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
