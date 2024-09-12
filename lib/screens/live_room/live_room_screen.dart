import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/agora_live_model.dart';
import 'package:worldsocialintegrationapp/screens/live_room/admin_bottomsheet.dart';
import 'package:worldsocialintegrationapp/screens/live_room/clean_chat_alert.dart';
import 'package:worldsocialintegrationapp/screens/live_room/hide_liveroom_alert.dart';
import 'package:worldsocialintegrationapp/screens/live_room/lock_room.dart';
import 'package:worldsocialintegrationapp/screens/live_room/music_bottomsheet.dart';
import 'package:worldsocialintegrationapp/screens/live_room/scoreboard_bottomsheet.dart';
import 'package:worldsocialintegrationapp/screens/live_room/theme_bottomsheet.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/country_continent.dart';
import '../../models/live_room_detail_model.dart';
import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../services/location_service.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import 'cover_info_bottomsheet.dart';
import 'edit_announcement.dart';

class LiveRoomScreen extends StatefulWidget {
  const LiveRoomScreen({super.key, required this.agoraToken});
  static const String route = '/liveRoomScreen';
  final LiveRoomDetailModel agoraToken;
  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  late ApiCallProvider apiCallProvider;
  UserProfileDetail? user;
  bool _isClicked = false;

  late RtcEngine agoraEngine;
  final String appId = '86f31e0182524c3ebc7af02c9a35e0ca';
  String token = 'your-temporary-token';
  String channelName = 'testChannel';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();

      // initializeAgora();
    });
  }

  void initializeAgora() async {
    channelName = widget.agoraToken.channelName ?? '';
    token = widget.agoraToken.token ?? '';

    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(RtcEngineContext(appId: appId));

    // Enable audio
    await agoraEngine.enableAudio();
    await agoraEngine.setDefaultAudioRouteToSpeakerphone(true);
    await agoraEngine.enableAudio();
    await agoraEngine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await agoraEngine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );

    // Set event handlers
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          log('Local user ${connection.localUid} joined the channel $elapsed');
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          log('Remote user $remoteUid joined the channel $elapsed');
        },
        onUserOffline: (connection, remoteUid, reason) {
          log('Remote user $remoteUid left the channel');
        },
      ),
    );

    log('token : ${token}');
    log('channelName : ${channelName}');
    // Join channel
    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      uid: int.parse(user?.id ?? '0'),
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    agoraEngine.leaveChannel();
    agoraEngine.release();
  }

  void loadUserData() async {
    await getCurrentUser().then(
      (value) async {
        user = value;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            getBody(context),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: _isClicked
                  ? MediaQuery.of(context).size.height / 2 - 150
                  : -100, // Animate from top to center
              left: MediaQuery.of(context).size.width / 2 -
                  35, // Center horizontally
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isClicked = !_isClicked;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFC00E8),
                            Color(0xFF881FF4),
                          ],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/image/minimiz.png',
                        color: Colors.white,
                        width: 40,
                      ),
                    ),
                    verticalGap(10),
                    const Text(
                      'Minimize',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              bottom: _isClicked
                  ? MediaQuery.of(context).size.height / 2 - 150
                  : -100, // Animate from bottom to center
              left: MediaQuery.of(context).size.width / 2 -
                  35, // Center horizontally
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isClicked = !_isClicked;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFC00E8),
                            Color(0xFF881FF4),
                          ],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/image/exit.png',
                        color: Colors.white,
                        width: 40,
                      ),
                    ),
                    verticalGap(10),
                    const Text(
                      'Exit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
              'https://images.pexels.com/photos/66869/green-leaf-natural-wallpaper-royalty-free-66869.jpeg'),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(pagePadding / 2),
          child: Column(
            children: [
              topBar(),
              verticalGap(10),
              getProfileRow(context),
              verticalGap(20),
              GridView.builder(
                primary: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.7),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      showPositionPopup();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        verticalGap(20),
                        Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 30),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BorderedCircularImage(
                              imagePath: user?.image ?? '',
                              diameter: 20,
                              borderColor: Colors.white,
                              borderThickness: 1,
                            ),
                            horizontalGap(5),
                            Text(
                              user?.name ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                            horizontalGap(5),
                            const Flexible(
                              child: Text(
                                ': Welcome to WOW\s Live Stream',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.green,
                                Colors.yellow,
                                Colors.deepOrange
                              ],
                            ),
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: const TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Send message',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          actions: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(50),
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.green,
                                    Colors.yellow,
                                    Colors.deepOrange
                                  ],
                                ),
                              ),
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: Icon(
                        Icons.chat_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: Icon(
                        Icons.mic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/image/giftlive.png',
                      width: 50,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: Icon(
                        Icons.volume_up,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: Icon(
                        Icons.mail_outline_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: Icon(
                        Icons.sort_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row getProfileRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getTodaysDate(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.black.withOpacity(0.2),
                ),
                child: Chip(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: Colors.transparent,
                  label: const Text(
                    '3.5k',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  labelPadding: const EdgeInsets.only(right: 5),
                  visualDensity: VisualDensity.compact,
                  avatar: Image.asset(
                    'assets/image/diamond.png',
                    width: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalGap(20),
              CircularImage(
                imagePath: user?.image ?? '',
                diameter: 80,
              ),
              verticalGap(10),
              Text(
                user?.name ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.black.withOpacity(0.2),
                ),
                child: const Chip(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  backgroundColor: Colors.transparent,
                  label: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  labelPadding: EdgeInsets.only(right: 5),
                  visualDensity: VisualDensity.compact,
                  avatar: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                height: 30,
                width: 90,
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
                    Text(
                      user?.familyName ?? '',
                      style: const TextStyle(
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
      ],
    );
  }

  Row topBar() {
    return Row(
      children: [
        Container(
          width: 160,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.green, Colors.yellow, Colors.orange],
            ),
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              const CircularImage(imagePath: '', diameter: 40),
              horizontalGap(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Games',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ID : ${user?.username ?? ''}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            showAllMenu();
          },
          child: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 15,
            child: Icon(
              Icons.menu,
              size: 20,
            ),
          ),
        ),
        horizontalGap(10),
        InkWell(
          onTap: () {
            setState(() {
              _isClicked = !_isClicked;
            });
          },
          child: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 15,
            child: Icon(
              Icons.power_settings_new_sharp,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  void showPositionPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Close'),
              ),
              ListTile(
                title: Text('Invite Audience'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showAllMenu() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // To enable custom height
                            builder: (context) => CoverInfoBottomsheet(
                              agoraToken: AgoraToken(),
                              userId: prefs.getString(PrefsKey.userId) ?? '',
                            ),
                          );
                        },
                        child: getMenuItem(
                            'assets/image/cover_info_img.png', 'Cover Info'),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) => const EditAnnouncement(),
                          );
                        },
                        child: getMenuItem(
                            'assets/image/bulletin_call.png', 'Bulletin'),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // To enable custom height
                            builder: (context) => const AdminBottomsheet(),
                          );
                        },
                        child:
                            getMenuItem('assets/image/admin_icon.png', 'Admin'),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) => const LockRoom(),
                          );
                        },
                        child:
                            getMenuItem('assets/image/lock_icon65.png', 'Lock'),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) => const CleanChatRoom(),
                          );
                        },
                        child:
                            getMenuItem('assets/image/brush.png', 'Clean Chat'),
                      ),
                    ),
                  ],
                ),
                verticalGap(50),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // To enable custom height
                            builder: (context) => const ThemeBottomsheet(),
                          );
                        },
                        child: getMenuItem(
                            'assets/image/color_theme.png', 'Theme'),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) => const HideLiveRoom(),
                          );
                        },
                        child: getMenuItem('assets/image/eye_h.png', 'Hidden'),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // To enable custom height
                            builder: (context) => const ScoreboardBottomsheet(),
                          );
                        },
                        child: getMenuItem(
                            'assets/image/increasing_bar.png', 'Scoreboard'),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // To enable custom height
                            builder: (context) => const MusicBottomsheet(),
                          );
                        },
                        child:
                            getMenuItem('assets/image/music_icon.png', 'Music'),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getMenuItem(String image, String label) {
    return Column(
      children: [
        Image.asset(
          image,
          width: 30,
        ),
        verticalGap(10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
