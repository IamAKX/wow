import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/live_room_detail_model.dart';
import 'package:worldsocialintegrationapp/models/live_room_exit_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home/near_by.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home/popular.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home/related.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home/search_member.dart';
import 'package:worldsocialintegrationapp/screens/live_room/live_room_screen.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';

import '../../../main.dart';
import '../../../models/agora_live_model.dart';
import '../../../models/country_continent.dart';
import '../../../providers/api_call_provider.dart';
import '../../../services/location_service.dart';
import '../../../utils/api.dart';
import '../../../utils/prefs_key.dart';
import '../profile/edit_profile.dart';
import 'live_end_popup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ApiCallProvider apiCallProvider;
  bool isButtonActive = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('show profile update : ${prefs.getBool(PrefsKey.showProfileUpdatePopup) ?? false}');
      requestPermission();
      if (prefs.getBool(PrefsKey.showProfileUpdatePopup) ?? false) {
        showUpdateProfilePopup();
      }
    });
  }

  DateTime? startTime;
  getAgoraToken(BuildContext context) async {
    isButtonActive = false;

    CountryContinent? countryContinent =
        await LocationService().getCurrentLocation();
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'channelName': prefs.getString(PrefsKey.userId),
      'longitude': countryContinent?.position?.longitude,
      'latitude': countryContinent?.position?.latitude,
      'hostType': '3',
    };
    log('req = $reqBody');
    await apiCallProvider.postRequest(API.agoraToken, reqBody).then((value) {
      if (value['details'] != null) {
        AgoraToken agoraToken = AgoraToken.fromJson(value['details']);
        LiveRoomDetailModel liveRoomDetailModel = LiveRoomDetailModel(
            channelName: agoraToken.channelName,
            mainId: agoraToken.mainId,
            token: agoraToken.toke,
            isSelfCreated: true,
            roomCreatedBy: prefs.getString(PrefsKey.userId));
        startTime = DateTime.now();
        Navigator.of(context, rootNavigator: true)
            .pushNamed(LiveRoomScreen.route, arguments: liveRoomDetailModel)
            .then(
          (result) {
            // int differenceInSeconds = 0;
            isButtonActive = true;
            // if (result != null && result is DateTime) {
            //   final endTime = result;
            //   differenceInSeconds = endTime.difference(startTime!).inSeconds;
            //   print('Time difference: $differenceInSeconds seconds');
            // }
            LiveRoomExitModel liveRoomExitModel = result as LiveRoomExitModel;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  insetPadding: EdgeInsets.zero,
                  child: LiveEndPopup(
                    roomId: agoraToken.mainId ?? '',
                    userId: prefs.getString(PrefsKey.userId) ?? '',
                    startTime: startTime ?? DateTime.now(),
                    liveRoomExitModel: liveRoomExitModel,
                  ),
                );
              },
            );
          },
        );
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

  getBody(BuildContext context) {
    return Column(
      children: [
        getTopBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [RelatedScreen(), PopularScreen(), NearBy()],
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
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(SearchMember.route);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          apiCallProvider.status == ApiStatus.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : IconButton(
                  onPressed: apiCallProvider.status == ApiStatus.loading ||
                          !isButtonActive
                      ? null
                      : () {
                          getAgoraToken(context);
                        },
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
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(EditProfile.route);
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

  Future<void> requestPermission() async {
    await [
      Permission.location,
      Permission.microphone,
      Permission.nearbyWifiDevices
    ].request();
  }
}
