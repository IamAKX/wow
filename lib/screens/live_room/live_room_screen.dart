import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/admin_live_room_controls.dart';
import 'package:worldsocialintegrationapp/models/emoji_model.dart';
import 'package:worldsocialintegrationapp/models/joinable_live_room_model.dart';
import 'package:worldsocialintegrationapp/models/live_room_user_model.dart';
import 'package:worldsocialintegrationapp/models/liveroom_chat.dart';
import 'package:worldsocialintegrationapp/screens/home_container/chat/chat_screen.dart';
import 'package:worldsocialintegrationapp/screens/live_room/admin_bottomsheet.dart';
import 'package:worldsocialintegrationapp/screens/live_room/clean_chat_alert.dart';
import 'package:worldsocialintegrationapp/screens/live_room/gift_stats_bottomsheet.dart';
import 'package:worldsocialintegrationapp/screens/live_room/hide_liveroom_alert.dart';
import 'package:worldsocialintegrationapp/screens/live_room/invite_audience_bottom_sheet.dart';
import 'package:worldsocialintegrationapp/screens/live_room/lock_room.dart';
import 'package:worldsocialintegrationapp/screens/live_room/music_bottomsheet.dart';
import 'package:worldsocialintegrationapp/screens/live_room/scoreboard_bottomsheet.dart';
import 'package:worldsocialintegrationapp/screens/live_room/theme_bottomsheet.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/firebase_db_node.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/animated_framed_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/country_continent.dart';
import '../../models/live_room_detail_model.dart';
import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../services/live_room_firebase.dart';
import '../../services/location_service.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import 'cover_info_bottomsheet.dart';
import 'edit_announcement.dart';
import 'prime_gift_bottom.dart';
import 'profile_bottomsheet.dart';

class LiveRoomScreen extends StatefulWidget {
  const LiveRoomScreen({super.key, required this.agoraToken});
  static const String route = '/liveRoomScreen';
  final LiveRoomDetailModel agoraToken;
  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen>
    with TickerProviderStateMixin {
  late ApiCallProvider apiCallProvider;
  UserProfileDetail? user;
  UserProfileDetail? roomOwner;
  bool _isClicked = false;
  JoinableLiveRoomModel? roomDetail;
  static FirebaseDatabase database = FirebaseDatabase.instance;
  List<LiveRoomUserModel> participants = [];
  int participantCount = -1;
  String announcementMessage = '';
  String liveRoomTheme = '';
  String frame = '';
  List<EmojiModel> emojiList = [];
  String selectedEmoji = '';

  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  bool _isPlaying = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  late RtcEngine agoraEngine;
  final String appId = '86f31e0182524c3ebc7af02c9a35e0ca';
  String token = 'your-temporary-token';
  String channelName = 'testChannel';

  final ScrollController _scrollController = ScrollController();
  late AnimationController _musicplayerAnimationController;
  late Animation<Offset> _musicplayerOffsetAnimation;

  late AnimationController _emojiAnimationController;
  late Animation<double> _emojiAnimation;
  bool _isImageVisible = false;

  final ReceivePort _receivePort = ReceivePort();
  Map<int, LiveRoomUserModel> hotSeatMap = {};

  AdminLiveRoomControls liveRoomControls = AdminLiveRoomControls();
  Map<String, AdminLiveRoomControls> hotSeatAdminControlMap = {};

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  @override
  void initState() {
    super.initState();
    // Isolate.spawn(getPeriodicReward, _receivePort.sendPort);
    _timer = Timer.periodic(const Duration(minutes: 10), (timer) async {
      if (widget.agoraToken.isSelfCreated ?? false) {
        getSelfRoomReward();
      } else {
        getOtherRoomReward();
      }
    });
    initAudioPlayer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
      loadRoomOwnerData();
      initEmojiAnimation();
      loadEmojiList();

      // initializeAgora();
    });
  }

  Timer? _timer;
  // Future<void> getPeriodicReward(SendPort sendPort) async {
  //   _timer = Timer.periodic(const Duration(minutes: 10), (timer) async {
  //     if (widget.agoraToken.isSelfCreated ?? false) {
  //       getSelfRoomReward();
  //     } else {
  //       getOtherRoomReward();
  //     }
  //   });
  // }

  void initAudioPlayer() async {
    _musicplayerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Animation duration
    );

    _musicplayerOffsetAnimation = Tween<Offset>(
      begin: const Offset(
          5.0, 0.0), // Start just outside the right side of the screen
      end: const Offset(0.0, 0.0), // End at the original position
    ).animate(_musicplayerAnimationController);

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted)
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
    });
  }

  void firebaseDetailListners() async {
    database
        .ref('${FirebaseDbNode.liveRoom}/${widget.agoraToken.mainId}')
        .onValue
        .listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.exists) {
        setState(() {
          roomDetail =
              JoinableLiveRoomModel.fromJson(dataSnapshot.value as Map);
        });
      }
    });
    database
        .ref(
            '${FirebaseDbNode.liveRoomParticipants}/${widget.agoraToken.mainId}')
        .onValue
        .listen((event) {
      if (event.snapshot.exists) {
        List p = [];
        if (event.snapshot.value is List) {
          List l = (event.snapshot.value as List);
          for (int i = 0; i < l.length; i++) {
            if (l.elementAt(i) != null) {
              p.add(l.elementAt(i));
            }
          }
        } else {
          (event.snapshot.value as Map).values.forEach((item) => p.add(item));
        }
        participants.clear();
        p.forEach(
          (element) {
            participants.add(LiveRoomUserModel.fromMap(element));
          },
        );

        if (mounted) {
          setState(() {
            participantCount = participants.length;
          });
        }
      }
    });

    database
        .ref(
            '${FirebaseDbNode.liveRoomAnnouncement}/${widget.agoraToken.mainId}')
        .onValue
        .listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.exists) {
        setState(() {
          announcementMessage = dataSnapshot.value as String;
        });
      }
    });

    database
        .ref('${FirebaseDbNode.liveRoomTheme}/${widget.agoraToken.mainId}')
        .onValue
        .listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.exists) {
        setState(() {
          liveRoomTheme = dataSnapshot.value as String;
        });
      }
    });

    database
        .ref('${FirebaseDbNode.liveRoomHotSeat}/${widget.agoraToken.mainId}')
        .onValue
        .listen((event) {
      if (event.snapshot.exists) {
        Map seatMapList = {};
        if (event.snapshot.value is List) {
          List l = (event.snapshot.value as List);
          for (int i = 0; i < l.length; i++) {
            if (l.elementAt(i) != null) {
              seatMapList['$i'] = l.elementAt(i);
            }
          }
        } else {
          seatMapList = event.snapshot.value as Map;
        }
        hotSeatMap = {};
        seatMapList.entries.forEach(
          (element) {
            hotSeatMap[int.parse(element.key)] =
                LiveRoomUserModel.fromMap(element.value);
          },
        );
        if (mounted) {
          setState(() {});
        }
      }
    });

    database
        .ref(
            '${FirebaseDbNode.liveRoomAdminControl}/${widget.agoraToken.mainId}/${user?.id}')
        .onValue
        .listen((event) async {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.exists) {
        liveRoomControls =
            AdminLiveRoomControls.fromMap(dataSnapshot.value as Map);
        if (liveRoomControls.invite ?? false) {
          showInvitePopup(liveRoomControls.position ?? 0);
        }

        if (liveRoomControls.kickout ?? false) {
          Navigator.pop(currentContex);
        }
      } else {
        liveRoomControls = AdminLiveRoomControls(
            giftSound: false,
            giftVisiualEffect: false,
            isMicMute: false,
            isSpeakerMute: false,
            kickout: false,
            rewardEffects: false,
            invite: false,
            position: 0,
            vehicalVisiualEffect: false);
        LiveRoomFirebase.addLiveRoomAdminSettings(
            widget.agoraToken.mainId ?? '', user?.id ?? '', liveRoomControls);
      }
    });

    database
        .ref(
            '${FirebaseDbNode.liveRoomAdminControl}/${widget.agoraToken.mainId}')
        .onValue
        .listen((event) {
      if (event.snapshot.exists) {
        Map seatControlMapList = {};
        if (event.snapshot.value is List) {
          List l = (event.snapshot.value as List);
          for (int i = 0; i < l.length; i++) {
            if (l.elementAt(i) != null) {
              seatControlMapList['$i'] = l.elementAt(i);
            }
          }
        } else {
          seatControlMapList = event.snapshot.value as Map;
        }
        hotSeatAdminControlMap = {};
        seatControlMapList.entries.forEach(
          (element) {
            hotSeatAdminControlMap[element.key] =
                AdminLiveRoomControls.fromMap(element.value);
          },
        );
        if (mounted) {
          setState(() {});
        }
      }
    });

    LiveRoomFirebase.toggleUserInRoomArray(
        widget.agoraToken.mainId ?? '', user, true);
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
    // _receivePort.close();
    _timer?.cancel();
    _musicplayerAnimationController.dispose();
    // agoraEngine.leaveChannel();
    // agoraEngine.release();
    cleanFirebaseListener();
    _audioPlayer.dispose();
    _emojiAnimationController.dispose();
    super.dispose();
  }

  void cleanFirebaseListener() async {
    hotSeatMap.entries.forEach(
      (element) {
        if (element.value.id == user?.id) {
          LiveRoomFirebase.removeLiveRoomHotSeat(
            widget.agoraToken.mainId ?? '',
            element.key,
          );
        }
      },
    );

    await LiveRoomFirebase.removeLiveRoomHotSeat(
        widget.agoraToken.mainId ?? '', liveRoomControls.position ?? 0);
    await LiveRoomFirebase.updateLiveRoomAdminSettings(
        widget.agoraToken.mainId ?? '', user?.id ?? '', 'position', 0);
    await LiveRoomFirebase.updateLiveRoomAdminSettings(
        widget.agoraToken.mainId ?? '', user?.id ?? '', 'kickout', false);
    await database
        .ref('${FirebaseDbNode.liveRoom}/${widget.agoraToken.mainId}')
        .onValue
        .drain();
    await database
        .ref(
            '${FirebaseDbNode.liveRoomParticipants}/${widget.agoraToken.mainId}')
        .onValue
        .drain();
    await database
        .ref(
            '${FirebaseDbNode.liveRoomAnnouncement}/${widget.agoraToken.mainId}')
        .onValue
        .drain();
  }

  void loadRoomOwnerData() async {
    await getUserById(widget.agoraToken.roomCreatedBy ?? '').then(
      (value) async {
        roomOwner = value;
        setState(() {});
      },
    );

    frame = await loadFrame();
    setState(() {});
  }

  void loadUserData() async {
    var status = await Permission.manageExternalStorage.request();
    await getCurrentUser().then(
      (value) async {
        user = value;
        firebaseDetailListners();

        LiveroomChat liveroomChat = LiveroomChat(
            message: 'joined Stream',
            timeStamp: DateTime.now().millisecondsSinceEpoch,
            userId: user?.id,
            userImage: user?.image,
            userName: user?.name);
        LiveRoomFirebase.sendChat(widget.agoraToken.mainId ?? '', liveroomChat)
            .then(
          (value) {},
        );
        setState(() {
          _scrollToBottom();
        });
      },
    );

    frame = await loadFrame();
    setState(() {});
  }

  late BuildContext currentContex;
  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    currentContex = context;
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _isClicked = !_isClicked;
        });
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              getBody(context),
              buildExistSwitchTop(context),
              buildExistSwitchBottom(context),
              musicControllerLayout(context),
              musicPlayerButton(context),
              if (_isImageVisible)
                AnimatedBuilder(
                  animation: _emojiAnimation,
                  builder: (context, child) {
                    return Positioned(
                      top: _emojiAnimation
                          .value, // Smoothly animate the top position
                      left: MediaQuery.of(context).size.width / 2 - 50,
                      child: CachedNetworkImage(
                        imageUrl: selectedEmoji,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Text('Error ${error.toString()}'),
                        ),
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Visibility musicPlayerButton(BuildContext context) {
    return Visibility(
      visible: _isPlaying,
      child: Positioned(
        right: 20,
        bottom: MediaQuery.of(context).size.height * 0.3,
        child: InkWell(
          onTap: () {
            _startGlideAnimation();
          },
          child: Image.asset(
            'assets/image/frkst-records.gif',
            width: 50,
          ),
        ),
      ),
    );
  }

  Positioned musicControllerLayout(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.27,
      left: 20,
      child: SlideTransition(
        position: _musicplayerOffsetAnimation,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause_circle : Icons.play_circle,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  if (_isPlaying) {
                    _pauseAudio();
                    _startGlideAnimation();
                  } else {
                    _resumeAudio();
                  }
                },
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        basename(prefs.getString(PrefsKey.musicPlaying) ?? ''),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Slider(
                      value: _currentPosition.inSeconds.toDouble(),
                      min: 0,
                      thumbColor: Colors.teal,
                      activeColor: Colors.teal,
                      inactiveColor: Colors.teal.shade100,
                      max: _totalDuration.inSeconds.toDouble(),
                      onChanged: (value) {
                        final newPosition = Duration(seconds: value.toInt());
                        _seekAudio(newPosition);
                      },
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            _formatDuration(_currentPosition),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            ' ${_formatDuration(_totalDuration)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedPositioned buildExistSwitchBottom(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      bottom: _isClicked
          ? MediaQuery.of(context).size.height / 2 - 150
          : -150, // Animate from bottom to center
      left: MediaQuery.of(context).size.width / 2 - 35, // Center horizontally
      child: InkWell(
        onTap: () async {
          _isClicked = !_isClicked;
          await LiveRoomFirebase.toggleUserInRoomArray(
                  widget.agoraToken.mainId ?? '', user, false)
              .then(
            (value) {
              Navigator.pop(context);
            },
          );

          LiveroomChat liveroomChat = LiveroomChat(
              message: 'left Stream',
              timeStamp: DateTime.now().millisecondsSinceEpoch,
              userId: user?.id,
              userImage: user?.image,
              userName: user?.name);
          LiveRoomFirebase.sendChat(
                  widget.agoraToken.mainId ?? '', liveroomChat)
              .then(
            (value) {
              _scrollToBottom();
            },
          );
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
    );
  }

  AnimatedPositioned buildExistSwitchTop(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: _isClicked
          ? MediaQuery.of(context).size.height / 2 - 150
          : -150, // Animate from top to center
      left: MediaQuery.of(context).size.width / 2 - 35, // Center horizontally
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
    );
  }

  getBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(liveRoomTheme.isNotEmpty
              ? liveRoomTheme
              : 'https://images.pexels.com/photos/66869/green-leaf-natural-wallpaper-royalty-free-66869.jpeg'),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(pagePadding / 2),
          child: Column(
            children: [
              topBar(context),
              verticalGap(10),
              getProfileRow(context),
              verticalGap(20),
              getSeatLayout(),
              if (announcementMessage.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Room announcement: $announcementMessage',
                      style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
              getLiveChatList(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      sendLiveRoomMessage(context);
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
                    onTap: () {
                      LiveRoomFirebase.updateLiveRoomAdminSettings(
                          widget.agoraToken.mainId ?? '',
                          user?.id ?? '',
                          'isMicMute',
                          !(liveRoomControls.isMicMute ?? false));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: Icon(
                        (liveRoomControls.isMicMute ?? false)
                            ? Icons.mic_off
                            : Icons.mic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //  _showBottomSheet(context);
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true, // To enable custom height
                          builder: (context) => loadEmojiBottomSheet());
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // To enable custom height
                        builder: (context) => PrimeGiftBottom(
                          roomDetail: roomDetail ??
                              JoinableLiveRoomModel(
                                id: widget.agoraToken.mainId,
                              ),
                          myCoins: user?.myCoin ?? '',
                        ),
                      ).then(
                        (value) {
                          _scrollToBottom();
                        },
                      );
                    },
                    child: Image.asset(
                      'assets/image/giftlive.png',
                      width: 50,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      LiveRoomFirebase.updateLiveRoomAdminSettings(
                          widget.agoraToken.mainId ?? '',
                          user?.id ?? '',
                          'isSpeakerMute',
                          !(liveRoomControls.isSpeakerMute ?? false));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: Icon(
                        (liveRoomControls.isSpeakerMute ?? false)
                            ? Icons.volume_up
                            : Icons.volume_off_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ChatScreen.route);
                    },
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

  Expanded getLiveChatList(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref('${FirebaseDbNode.liveRoomChat}/${widget.agoraToken.mainId}')
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.snapshot.value == null) {
            return const SizedBox.shrink();
          }
          Map<dynamic, dynamic>? chatData =
              snapshot.data!.snapshot.value as Map;

          List<LiveroomChat> messageList = [];

          chatData.values
              .forEach((value) => messageList.add(LiveroomChat.fromMap(value)));

          messageList.sort(
            (a, b) {
              return (a.timeStamp ?? 0).compareTo(b.timeStamp ?? 0);
            },
          );
          _scrollToBottom();
          return ListView.builder(
            controller: _scrollController,
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              return getChatItem(context, messageList.elementAt(index));
            },
          );
        },
      ),
    );
  }

  Container getChatItem(BuildContext context, LiveroomChat chatContent) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.green, Colors.yellow, Colors.deepOrange],
          ),
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BorderedCircularImage(
            imagePath: chatContent.userImage ?? '',
            diameter: 20,
            borderColor: Colors.white,
            borderThickness: 1,
          ),
          horizontalGap(5),
          Text(
            chatContent.userName ?? '',
            style: const TextStyle(color: Colors.white),
          ),
          const Text(
            ': ',
            style: TextStyle(color: Colors.white),
          ),
          Flexible(
            child: Text(
              chatContent.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  GridView getSeatLayout() {
    return GridView.builder(
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
        return Column(
          children: [
            if (hotSeatMap[index + 1] == null)
              InkWell(
                onTap: () {
                  if (widget.agoraToken.isSelfCreated ?? false) {
                    showPositionForHostPopup(context, index, false);
                  } else {
                    bool isSeatEmpty = hotSeatMap[index + 1] == null;
                    bool isSeatLocked = hotSeatMap[index + 1] != null &&
                        hotSeatMap[index + 1]?.id == 'Locked';
                    if (!isSeatEmpty || isSeatLocked) {
                      return;
                    }
                    hotSeatMap.entries.forEach(
                      (element) {
                        if (element.value.id == user?.id) {
                          LiveRoomFirebase.removeLiveRoomHotSeat(
                            widget.agoraToken.mainId ?? '',
                            element.key,
                          );
                        }
                      },
                    );

                    LiveRoomFirebase.addLiveRoomHotSeat(
                        widget.agoraToken.mainId ?? '',
                        index + 1,
                        convertUserToLiveUser(user));
                  }
                },
                child: Container(
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
              ),
            if (hotSeatMap[index + 1] != null &&
                hotSeatMap[index + 1]?.id == 'Locked')
              InkWell(
                onTap: () {
                  if (widget.agoraToken.isSelfCreated ?? true) {
                    showPositionForHostPopup(context, index, true);
                  } else {}
                },
                child: Container(
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
                    Icons.lock_outline,
                    color: Colors.white,
                  ),
                ),
              ),
            if (hotSeatMap[index + 1] != null &&
                hotSeatMap[index + 1]?.id != 'Locked')
              InkWell(
                onTap: () {
                  if (widget.agoraToken.isSelfCreated ?? true) {
                    showPositionForHostKickoutPopup(context, index, false);
                  } else {
                    if (hotSeatMap[index + 1]?.id == user?.id) {
                      showPositionForMemberPopup(context, index);
                    }
                  }
                },
                child: Stack(
                  children: [
                    CircularImage(
                        imagePath: hotSeatMap[index + 1]?.image ?? '',
                        diameter: 60),
                    if (hotSeatAdminControlMap[
                                hotSeatMap[index + 1]?.id ?? ''] !=
                            null &&
                        (hotSeatAdminControlMap[hotSeatMap[index + 1]?.id ?? '']
                                ?.isMicMute ??
                            false))
                      const Positioned(
                        right: 1,
                        bottom: 1,
                        child: CircleAvatar(
                          backgroundColor: Colors.white54,
                          radius: 15,
                          child: Icon(
                            Icons.mic_off,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            verticalGap(20),
            Text(
              '${hotSeatMap[index + 1] == null ? (index + 1) : (hotSeatMap[index + 1]?.username == null) ? (index + 1) : hotSeatMap[index + 1]?.username}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        );
      },
    );
  }

  Future<dynamic> sendLiveRoomMessage(BuildContext context) {
    final TextEditingController messageCtrl = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) => Stack(
        children: [
          Positioned(
            bottom: 1, // Ensures dialog stays on top of keyboard
            left: 0,
            right: 0,
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageCtrl,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Send message',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    horizontalGap(10),
                    InkWell(
                      onTap: () async {
                        if (messageCtrl.text.isNotEmpty) {
                          LiveroomChat liveroomChat = LiveroomChat(
                              message: messageCtrl.text,
                              timeStamp: DateTime.now().millisecondsSinceEpoch,
                              userId: user?.id,
                              userImage: user?.image,
                              userName: user?.name);
                          LiveRoomFirebase.sendChat(
                                  widget.agoraToken.mainId ?? '', liveroomChat)
                              .then(
                            (value) {
                              Navigator.of(context).pop();
                              _scrollToBottom();
                            },
                          );
                        }
                      },
                      child: Container(
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
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
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // To enable custom height
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16.0)),
                      ),
                      builder: (context) => GiftStatsBottomsheet(
                        roomDetail: roomDetail ??
                            JoinableLiveRoomModel(
                              id: widget.agoraToken.mainId,
                            ),
                      ),
                    );
                  },
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
              ),
            ],
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => ProfileBottomsheet(
                  roomDetail: roomDetail ??
                      JoinableLiveRoomModel(
                        id: widget.agoraToken.mainId,
                      ),
                  liveRoomUserModel: convertUserToLiveUser(roomOwner),
                  myCoins: user?.myCoin ?? '',
                  user: user,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalGap(20),
                frame.isEmpty || true
                    ? CircularImage(
                        imagePath: roomOwner?.image ?? '',
                        diameter: 80,
                      )
                    : AnimatedFramedCircularImage(
                        imagePath: user?.image ?? '',
                        imageSize: 80,
                        framePath: frame),
                verticalGap(10),
                Text(
                  roomOwner?.name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            ),
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
                child: Chip(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  backgroundColor: Colors.transparent,
                  label: Text(
                    '$participantCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  labelPadding: const EdgeInsets.only(right: 5),
                  visualDensity: VisualDensity.compact,
                  avatar: const Icon(
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

  Row topBar(BuildContext context) {
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
              CircularImage(
                  imagePath: roomDetail?.liveimage ?? '', diameter: 40),
              horizontalGap(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomDetail?.imageTitle ?? '',
                    style: const TextStyle(
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
        Visibility(
          visible: widget.agoraToken.isSelfCreated ?? false,
          child: InkWell(
            onTap: () {
              showAllMenu(context);
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

  void showPositionForHostPopup(
      BuildContext context, int position, bool isLocked) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(isLocked ? 'Open' : 'Close'),
                onTap: () {
                  if (isLocked) {
                    LiveRoomFirebase.removeLiveRoomHotSeat(
                            widget.agoraToken.mainId ?? '', position + 1)
                        .then(
                      (value) {
                        Navigator.pop(context);
                      },
                    );
                  } else {
                    LiveRoomFirebase.addLiveRoomHotSeat(
                            widget.agoraToken.mainId ?? '',
                            position + 1,
                            LiveRoomUserModel(id: 'Locked'))
                        .then(
                      (value) {
                        Navigator.pop(context);
                      },
                    );
                  }
                },
              ),
              if (!isLocked)
                ListTile(
                  title: const Text('Invite Audience'),
                  onTap: () {
                    Navigator.of(context).pop();

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => InviteAudienceBottomSheet(
                        roomDetail: roomDetail ??
                            JoinableLiveRoomModel(
                              id: widget.agoraToken.mainId,
                            ),
                        position: position,
                        participants: List.from(participants),
                        hotSeatMap: hotSeatMap,
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void showPositionForHostKickoutPopup(
      BuildContext context, int position, bool isLocked) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Stand'),
                onTap: () {
                  LiveRoomFirebase.removeLiveRoomHotSeat(
                          widget.agoraToken.mainId ?? '', position + 1)
                      .then(
                    (value) {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              ListTile(
                title: const Text('Toggle Mic Mute'),
                onTap: () async {
                  AdminLiveRoomControls? settings =
                      await LiveRoomFirebase.getLiveRoomAdminSettings(
                          widget.agoraToken.mainId ?? '',
                          hotSeatMap[position + 1]?.id ?? '');
                  log('settings : ${settings}');
                  LiveRoomFirebase.updateLiveRoomAdminSettings(
                      widget.agoraToken.mainId ?? '',
                      hotSeatMap[position + 1]?.id ?? '',
                      'isMicMute',
                      !(settings?.isMicMute ?? false));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Kick out'),
                onTap: () async {
                  Map<String, dynamic> reqBody = {
                    'kickToId': hotSeatMap[position + 1]?.id,
                    'liveId': widget.agoraToken.mainId,
                    'kickById': user?.id
                  };
                  apiCallProvider
                      .postRequest(API.kickOutLiveUser, reqBody)
                      .then((value) async {
                    if (value['success'] == '1') {
                      LiveroomChat liveroomChat = LiveroomChat(
                          message:
                              '${user?.name} kicked out ${hotSeatMap[position + 1]?.username}',
                          timeStamp: DateTime.now().millisecondsSinceEpoch,
                          userId: user?.id,
                          userImage: user?.image,
                          userName: user?.name);
                      LiveRoomFirebase.sendChat(
                          widget.agoraToken.mainId ?? '', liveroomChat);

                      LiveRoomFirebase.updateLiveRoomAdminSettings(
                          widget.agoraToken.mainId ?? '',
                          hotSeatMap[position + 1]?.id ?? '',
                          'position',
                          position);
                      LiveRoomFirebase.updateLiveRoomAdminSettings(
                          widget.agoraToken.mainId ?? '',
                          hotSeatMap[position + 1]?.id ?? '',
                          'kickout',
                          true);
                      Navigator.pop(context);
                    }
                  });
                },
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => ProfileBottomsheet(
                      roomDetail: roomDetail ??
                          JoinableLiveRoomModel(
                            id: widget.agoraToken.mainId,
                          ),
                      liveRoomUserModel: hotSeatMap[position + 1]!,
                      myCoins: user?.myCoin ?? '',
                      user: user,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showPositionForMemberPopup(BuildContext context, int position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Stand'),
                onTap: () {
                  LiveRoomFirebase.removeLiveRoomHotSeat(
                          widget.agoraToken.mainId ?? '', position + 1)
                      .then(
                    (value) {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => ProfileBottomsheet(
                      roomDetail: roomDetail ??
                          JoinableLiveRoomModel(
                            id: widget.agoraToken.mainId,
                          ),
                      liveRoomUserModel: hotSeatMap[position + 1]!,
                      myCoins: user?.myCoin ?? '',
                      user: user,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showAllMenu(BuildContext context) {
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
                              roomDetail: roomDetail ??
                                  JoinableLiveRoomModel(
                                    id: widget.agoraToken.mainId,
                                  ),
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
                            builder: (context) => EditAnnouncement(
                              roomDetail: roomDetail ??
                                  JoinableLiveRoomModel(
                                      id: widget.agoraToken.mainId),
                            ),
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
                          if ((roomDetail?.password?.isEmpty ?? true)) {
                            showDialog(
                              context: context,
                              builder: (context) => LockRoom(
                                userId: user?.id ?? '',
                                roomDetail: roomDetail ??
                                    JoinableLiveRoomModel(
                                        id: widget.agoraToken.mainId),
                              ),
                            );
                          } else {
                            unlockRoom();
                          }
                        },
                        child: getMenuItem(
                            'assets/image/lock_icon65.png',
                            (roomDetail?.password?.isEmpty ?? true)
                                ? 'Lock'
                                : 'Unlock'),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) => CleanChatRoom(
                              chatRoomId: widget.agoraToken.mainId ?? '',
                              chat: LiveroomChat(
                                  message: 'Chat cleaned',
                                  timeStamp:
                                      DateTime.now().millisecondsSinceEpoch,
                                  userId: user?.id,
                                  userImage: user?.image,
                                  userName: user?.name),
                            ),
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
                            builder: (context) => ThemeBottomsheet(
                              roomDetail: roomDetail ??
                                  JoinableLiveRoomModel(
                                    id: widget.agoraToken.mainId,
                                  ),
                            ),
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
                          ).then(
                            (value) async {
                              if (prefs.containsKey(PrefsKey.musicPlaying)) {
                                String musicPath = await prefs
                                        .getString(PrefsKey.musicPlaying) ??
                                    '';
                                if (musicPath.isNotEmpty) {
                                  _playAudio(musicPath);
                                }
                              }
                            },
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

  void unlockRoom() {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'liveId': widget.agoraToken.mainId,
      'password': ''
    };
    apiCallProvider.postRequest(API.lockUserLive, reqBody).then((value) async {
      if (value['success'] == '1') {
        roomDetail?.password = '';
        await LiveRoomFirebase.updateLiveRoomInfo(roomDetail!);
        showToastMessage('Live room unlocked');
        setState(() {});
      }
    });
  }

  Future<void> _playAudio(String filePath) async {
    await _audioPlayer.play(DeviceFileSource(filePath));
    prefs.setString(PrefsKey.musicPlaying, filePath);
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    prefs.remove(PrefsKey.musicPlaying);
  }

  Future<void> _resumeAudio() async {
    await _audioPlayer.resume();
    prefs.remove(PrefsKey.musicPlaying);
  }

  Future<void> _seekAudio(Duration position) async {
    await _audioPlayer.seek(position);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  void _startGlideAnimation() {
    if (_musicplayerAnimationController.isCompleted) {
      _musicplayerAnimationController.reverse();
    } else {
      _musicplayerAnimationController.forward();
    }
  }

  initEmojiAnimation() {
    // Initialize the AnimationController
    _emojiAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Tween to move from bottom of the screen to 90% height
    _emojiAnimation = Tween<double>(
      begin: 1000,
      end: 100,
    ).animate(CurvedAnimation(
      parent: _emojiAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  void _onImageTap(BuildContext context) {
    setState(() {
      _isImageVisible = true; // Make the image visible
    });

    // Start the animation
    _emojiAnimationController.forward(from: 0.0);

    // Wait for 1 second and then hide the image
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isImageVisible = false;
      });
      _emojiAnimationController.reset(); // Reset animation for future use
    });
  }

  loadEmojiBottomSheet() {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text(
                'Emoji',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: emojiList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedEmoji = emojiList.elementAt(index).frameImg ?? '';
                      Navigator.pop(context);
                      _onImageTap(context);
                    },
                    child: CachedNetworkImage(
                      imageUrl: emojiList.elementAt(index).frameImg ?? '',
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Text('Error ${error.toString()}'),
                      ),
                      fit: BoxFit.fill,
                      height: 250,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadEmojiList() {
    apiCallProvider.getRequest(API.getEmoji).then((value) {
      emojiList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          emojiList.add(EmojiModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  void showInvitePopup(int position) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invite'),
          content:
              Text('Home Owner has invited you to join seat ${position + 1}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () async {
                hotSeatMap.entries.forEach(
                  (element) {
                    if (element.value.id == user?.id) {
                      LiveRoomFirebase.removeLiveRoomHotSeat(
                        widget.agoraToken.mainId ?? '',
                        element.key,
                      );
                    }
                  },
                );
                LiveRoomFirebase.addLiveRoomHotSeat(
                    widget.agoraToken.mainId ?? '',
                    position + 1,
                    convertUserToLiveUser(user));
                LiveRoomFirebase.updateLiveRoomAdminSettings(
                    widget.agoraToken.mainId ?? '',
                    user?.id ?? '',
                    'invite',
                    false);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Join',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }
}
