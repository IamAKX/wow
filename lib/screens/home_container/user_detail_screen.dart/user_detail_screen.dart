// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../utils/colors.dart';

class UserDeatilScreen extends StatefulWidget {
  const UserDeatilScreen({super.key});
  static const String route = '/userDeatilScreen';

  @override
  State<UserDeatilScreen> createState() => _UserDeatilScreenState();
}

class _UserDeatilScreenState extends State<UserDeatilScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0;
    _tabController.addListener(
      () {
        setState(() {});
      },
    );
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          horizontalGap(10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              label: Text('Chat'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Color(0xFFFBC100),
              ),
              icon: Icon(
                Icons.person_add_alt_1,
                color: Colors.white,
              ),
            ),
          ),
          horizontalGap(20),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              label: Text('Following'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Color(0xFF01ACFE),
              ),
              icon: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
          horizontalGap(10),
        ],
      ),
    );
  }

  getBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: profileTopWidget(),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                indicatorColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.only(bottom: 10),
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                tabs: const [
                  Tab(
                    text: 'MOMENTS',
                  ),
                  Tab(
                    text: 'DETAILED PROFILE',
                  ),
                ],
              ),
              if (_tabController.index == 0) ...{
                for (int i = 0; i < 10; i++) ...{
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            horizontalGap(pagePadding / 2),
                            CircularImage(
                                imagePath: 'assets/dummy/girl.jpeg',
                                diameter: 35),
                            horizontalGap(pagePadding / 2),
                            Text(
                              'Deepika',
                              style: TextStyle(fontSize: 18),
                            ),
                            Spacer(),
                            PopupMenuButton<String>(
                              onSelected: (value) => {},
                              position: PopupMenuPosition.under,
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem<String>(
                                    value: 'report',
                                    child: Text('Report'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'remove',
                                    child: Text('Remove'),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                        Image.asset('assets/dummy/banner1.jpeg'),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 5,
                            top: 5,
                          ),
                          child: Text('52 likes'),
                        ),
                        Row(
                          children: [
                            horizontalGap(10),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                'assets/svg/chat.svg',
                                width: 20,
                              ),
                            ),
                            horizontalGap(10),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.favorite,
                                color: Color(0xFFC22B1A),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 10, top: 5),
                          child: Text(
                            '24 days ago',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                }
              } else ...{
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF3CAFEE),
                    child: SvgPicture.asset(
                      'assets/svg/trophy_1_.svg',
                      color: Colors.white,
                      width: 20,
                    ),
                  ),
                  title: Text('Gift Wall'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  onTap: () {},
                )
              },
              verticalGap(70)
            ],
          ),
        )
      ],
    );
  }

  Container profileTopWidget() {
    return Container(
      height: 350,
      child: Stack(
        children: [
          Image.asset(
            'assets/dummy/girl.jpeg',
            height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Test User',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  PopupMenuButton<String>(
                    onSelected: (value) => {},
                    icon: Icon(Icons.more_horiz),
                    iconColor: Colors.white,
                    iconSize: 40,
                    position: PopupMenuPosition.under,
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'report',
                          child: Text('Report'),
                        ),
                        PopupMenuItem<String>(
                          value: 'addToBlockList',
                          child: Text('Add to blocklist'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Unfriend',
                          child: Text('Unfriend'),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: const BorderedCircularImage(
                  borderColor: Colors.white,
                  borderThickness: 3,
                  diameter: 80,
                  imagePath: 'assets/dummy/girl.jpeg',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pagePadding),
                child: Text(
                  'Test User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: pagePadding, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: const BoxDecoration(
                          color: Color(0xFF0FDEA5),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.male,
                            color: Colors.white,
                            size: 12,
                          ),
                          horizontalGap(5),
                          const Text(
                            '27',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    horizontalGap(5),
                    Container(
                      width: 60,
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/image/level_1.png',
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/image/coins_img.png',
                            width: 12,
                          ),
                          horizontalGap(5),
                          const Text(
                            '22',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    horizontalGap(10),
                    Container(
                      width: 60,
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/image/level_9.png',
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/image/coins_img.png',
                            width: 12,
                          ),
                          horizontalGap(5),
                          const Text(
                            '22',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      width: 90,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/image/family_badge_23.webp',
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Testersss',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pagePadding),
                child: Row(
                  children: [
                    Text(
                      'ID:126357',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 1,
                      height: 10,
                      color: Colors.white,
                    ),
                    Text(
                      'India',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 1,
                      height: 10,
                      color: Colors.white,
                    ),
                    Text(
                      'Fans:150',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 1,
                      height: 10,
                      color: Colors.white,
                    ),
                    Text(
                      '3w ago',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 300,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text('Some random bio'),
            ),
          ),
        ],
      ),
    );
  }

  Widget getProfileMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalGap(5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
