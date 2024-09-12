// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/event_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_leaderboard.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../main.dart';
import '../../../models/joinable_live_room_model.dart';
import '../../../models/live_room_detail_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/prefs_key.dart';
import '../../live_room/live_room_screen.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  late ApiCallProvider apiCallProvider;

  List<JoinableLiveRoomModel> roomList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadLiveRoom();
    });
  }

  loadLiveRoom() async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'otherId': prefs.getString(PrefsKey.userId),
    };
    apiCallProvider.postRequest(API.getPopularUserLive, reqBody).then((value) {
      roomList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          roomList.add(JoinableLiveRoomModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => {},
        child: Image.asset(
          'assets/image/spinnwheell.png',
          width: 60,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          getCarousel(),
          getFamilyEventButton(),
          roomList.isEmpty
              ? Container(
                  width: double.infinity,
                  height: 200,
                  alignment: Alignment.center,
                  child: Text(
                    'Live Not Found',
                    style: TextStyle(
                      color: Color(0xff575252),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    primary: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1),
                    itemCount: roomList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          LiveRoomDetailModel liveRoomDetailModel =
                              LiveRoomDetailModel(
                            channelName: roomList.elementAt(index).channelName,
                            mainId: roomList.elementAt(index).id,
                            token: roomList.elementAt(index).rtmToken,
                          );
                          Navigator.of(context)
                              .pushNamed(LiveRoomScreen.route,
                                  arguments: liveRoomDetailModel)
                              .then(
                            (value) {
                              loadLiveRoom();
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl: roomList.elementAt(index).liveimage ??
                                    'https://images.pexels.com/photos/129733/pexels-photo-129733.jpeg',
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/image/wooden_bg.jpeg',
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: const [
                                      Color(0xFFEC0DDC),
                                      Color(0xFF8E18FE),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  roomList.elementAt(index).imageTitle ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              left: 5,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: LinearGradient(
                                    colors: const [
                                      Color(0xFFEB5716),
                                      Color(0xFFECBC1E),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  roomList.elementAt(index).imageText ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  roomList.elementAt(index).totaltimePerLive ??
                                      '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Image.asset(
                                'assets/image/audio-8777_128.gif',
                                width: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Padding getFamilyEventButton() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, FamilyLeaderboard.route);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: pagePadding,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xff4f007a),
                      Color(0xff8e3dc2),
                      Color(0xff4f007a),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Family',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 1.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          horizontalGap(10),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, EventScreen.route);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: pagePadding,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xfff83302),
                      Color(0xfffbc100),
                      Color(0xfff83302),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Events',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 1.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlutterCarousel getCarousel() {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 180.0,
        showIndicator: true,
        autoPlay: true,
        pageSnapping: true,
        floatingIndicator: true,
        viewportFraction: 1,
        slideIndicator: const CircularSlideIndicator(
          slideIndicatorOptions: SlideIndicatorOptions(
              currentIndicatorColor: Color(0xffFA03E6),
              indicatorBackgroundColor: Colors.white),
        ),
      ),
      items: [
        'assets/dummy/banner1.jpeg',
        'assets/dummy/banner2.jpeg',
        'assets/dummy/banner3.jpeg',
        'assets/dummy/banner4.jpeg',
        'assets/dummy/banner5.jpeg'
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Image.asset(
              i,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            );
          },
        );
      }).toList(),
    );
  }
}
