import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/framed_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../providers/api_call_provider.dart';

class FamilyLeaderboard extends StatefulWidget {
  const FamilyLeaderboard({super.key});
  static const String route = '/familyLeaderboard';

  @override
  State<FamilyLeaderboard> createState() => _FamilyLeaderboardState();
}

class _FamilyLeaderboardState extends State<FamilyLeaderboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Todo: call api after screen load
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Family',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/image/invitation.png',
                width: 20,
                color: Colors.white,
              ),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: Color(0xFFA9945A),
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
              insets: EdgeInsets.symmetric(horizontal: 50.0),
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 5),
            indicatorColor: const Color(0xFFA9945A),
            indicatorPadding: const EdgeInsets.only(bottom: 10),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFA9945A),
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFFCAB69B),
            ),
            tabs: const [
              Tab(
                text: 'NEW',
              ),
              Tab(
                text: 'WEEKLY',
              ),
              Tab(
                text: 'MONTHLY',
              ),
            ],
          ),
        ),
        body: getBody(context));
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: getFamilyProfile(
                        'https://xrdsimulators.tech/wow_project/uploads/adminImg/1720068930_IMG_20240704_102328610.jpg',
                        'Testersss',
                        '0',
                        '2'),
                  ),
                  Expanded(
                    child: getFamilyProfile(
                        'https://xrdsimulators.tech/wow_project/uploads/adminImg/1720068930_IMG_20240704_102328610.jpg',
                        'Wow',
                        '0',
                        '1'),
                  ),
                  Expanded(
                    child: getFamilyProfile(
                        'https://xrdsimulators.tech/wow_project/uploads/adminImg/1720068930_IMG_20240704_102328610.jpg',
                        'Astro',
                        '0',
                        '3'),
                  )
                ],
              ),
              for (int i = 4; i <= 6; i++) ...{
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$i',
                        style: const TextStyle(
                          color: Color(0xFFB7945C),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      horizontalGap(20),
                      const BorderedCircularImage(
                          imagePath: 'jkds',
                          diameter: 50,
                          borderColor: Color(0xFFB7945C),
                          borderThickness: 2)
                    ],
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Test user $i',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      horizontalGap(10),
                      Image.asset(
                        'assets/image/levelbadge.jpeg',
                        width: 18,
                      )
                    ],
                  ),
                  subtitle: const Text(
                    'zzzz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/image/family_points_border.png'),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '0',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                        horizontalGap(2),
                        Image.asset(
                          'assets/image/fire.png',
                          width: 9,
                        )
                      ],
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.all(pagePadding),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF5B4420),
              backgroundColor: const Color(0xFFBD9A60),
            ),
            child: Text(
              'Create a Family',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  getFamilyProfile(String image, String name, String count, String rank) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 250,
      child: Stack(
        children: [
          Positioned(
            top: rank == '1' ? 40 : 50,
            child: Image.asset(
              'assets/image/family_bg_1.png',
              width: (MediaQuery.of(context).size.width - 60) / 3,
              height: 200,
            ),
          ),
          FramedCircularImage(
              imagePath: image,
              imageSize: 40,
              framePath: getFrameByRank(rank),
              frameSize: 110),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 60) / 3,
            child: Column(
              children: [
                verticalGap(rank == '1' ? 110 : 120),
                Image.asset(
                  'assets/image/top$rank.png',
                  width: 50,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(getNameBorderByRank(rank)),
                        fit: BoxFit.fill),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      horizontalGap(2),
                      Image.asset(
                        'assets/image/fire.png',
                        width: 14,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  width: 80,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/image/family_points_border.png'),
                        fit: BoxFit.fill),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        count,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      horizontalGap(2),
                      Image.asset(
                        'assets/image/fire.png',
                        width: 14,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getFrameByRank(String rank) {
    switch (rank) {
      case '1':
        return 'assets/image/family_badge_top1.png';
      case '2':
        return 'assets/image/family_badge_2.png';
      case '3':
        return 'assets/image/family_badge_3.png';
      default:
        return 'assets/image/family_badge_top1.png';
    }
  }

  String getNameBorderByRank(String rank) {
    switch (rank) {
      case '1':
        return 'assets/image/family1_name_border.png';
      case '2':
        return 'assets/image/family2_name_border.png';
      case '3':
        return 'assets/image/family3_name_border.png';
      default:
        return 'assets/image/family1_name_border.png';
    }
  }
}
