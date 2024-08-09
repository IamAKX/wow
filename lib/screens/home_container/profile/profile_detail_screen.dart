// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/add_moments.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/edit_profile.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/user_profile_detail.dart';
import '../../../utils/colors.dart';
import '../../../utils/generic_api_calls.dart';

class ProfileDeatilScreen extends StatefulWidget {
  const ProfileDeatilScreen({super.key});
  static const String route = '/profileDeatilScreen';

  @override
  State<ProfileDeatilScreen> createState() => _ProfileDeatilScreenState();
}

class _ProfileDeatilScreenState extends State<ProfileDeatilScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserProfileDetail? user;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddMoments.route);
        },
        backgroundColor: themePinkDark,
        child: Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
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
              verticalGap(20),
              Row(
                children: [
                  horizontalGap(20),
                  Text('Bio:'),
                  horizontalGap(10),
                  Text('Some random bio'),
                ],
              ),
              verticalGap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getProfileMetric('Fans', '1'),
                  getProfileMetric('Following', '1'),
                ],
              ),
              Divider(
                height: 30,
                thickness: 5,
                color: Colors.grey.withOpacity(0.1),
              ),
              TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                indicatorColor: themePinkDark,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.only(bottom: 10),
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: themePinkDark,
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
              }
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
          (user?.image ?? '').isEmpty
              ? Container(
                  color: Colors.grey,
                  height: 300,
                  width: double.infinity,
                )
              : CachedNetworkImage(
                  imageUrl: user?.image ?? '',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey,
                    height: 300,
                    width: double.infinity,
                  ),
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProfile.route).then(
                    (value) {
                      loadUserData();
                    },
                  );
                },
                icon: SvgPicture.asset(
                  'assets/svg/edit__2___1_.svg',
                  width: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Positioned(
            top: 250,
            left: 10,
            child: Row(
              children: [
                BorderedCircularImage(
                  borderColor: Colors.white,
                  borderThickness: 1,
                  diameter: 100,
                  imagePath: user?.image ?? '',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Chip(
                            backgroundColor:
                                Colors.transparent.withOpacity(0.5),
                            label: Text(
                              user?.name ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          horizontalGap(10),
                          Container(
                            padding: const EdgeInsets.all(5),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          horizontalGap(10),
                          Container(
                            padding: const EdgeInsets.all(5),
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
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          horizontalGap(5),
                          const Text('10188\nindia'),
                          horizontalGap(10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: const BoxDecoration(
                                color: Color(0xFF0FDEA5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.male,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                horizontalGap(5),
                                const Text(
                                  '22',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )
                              ],
                            ),
                          ),
                          horizontalGap(5),
                          Image.asset(
                            'assets/image/vip1img.png',
                            width: 40,
                          ),
                          horizontalGap(5),
                          Image.asset(
                            'assets/image/microphoneicon.png',
                            width: 40,
                          ),
                          horizontalGap(10),
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
                    )
                  ],
                )
              ],
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

  void loadUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
        });
      },
    );
  }
}
