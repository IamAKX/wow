import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/live_room_user_model.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'package:worldsocialintegrationapp/screens/live_room/prime_gift_bottom.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/joinable_live_room_model.dart';
import '../../models/liveroom_chat.dart';
import '../../models/theme_free_image_model.dart';
import '../../models/theme_paid_image_model.dart';
import '../../providers/api_call_provider.dart';
import '../../services/live_room_firebase.dart';
import '../../utils/api.dart';
import '../../utils/helpers.dart';
import '../../utils/prefs_key.dart';
import '../../widgets/animated_framed_circular_image.dart';
import '../../widgets/circular_image.dart';

class ProfileBottomsheet extends StatefulWidget {
  const ProfileBottomsheet({
    Key? key,
    required this.roomDetail,
    required this.liveRoomUserModel,
    required this.myCoins,
    required this.user,
    required this.position,
  }) : super(key: key);
  final JoinableLiveRoomModel roomDetail;
  final LiveRoomUserModel liveRoomUserModel;
  final String myCoins;
  final UserProfileDetail? user;
  final String position;

  @override
  State<ProfileBottomsheet> createState() => _ProfileBottomsheetState();
}

class _ProfileBottomsheetState extends State<ProfileBottomsheet> {
  late ApiCallProvider apiCallProvider;
  String frame = '';
  UserProfileDetail? otherUser;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFrame();
      loadUserData();
    });
  }

  Future<void> loadFrame() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};

    await ApiCallProvider.instance
        .postRequest(API.getAppliedFrame, reqBody)
        .then((value) {
      if (value['details'] != null) {
        frame = value['details']['frame_img'];
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return FractionallySizedBox(
      heightFactor: 0.5, // Set height to 60% of screen height
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              frame.isEmpty
                  ? CircularImage(
                      imagePath: widget.liveRoomUserModel.image ?? '',
                      diameter: 80,
                    )
                  : AnimatedFramedCircularImage(
                      imagePath: widget.liveRoomUserModel.image ?? '',
                      imageSize: 80,
                      framePath: frame),
              verticalGap(20),
              Text(
                '${widget.liveRoomUserModel.username}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              verticalGap(10),
              Text(
                'ID: ${widget.liveRoomUserModel.usernameID} | ${widget.liveRoomUserModel.country}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey),
              ),
              verticalGap(10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
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
                  if ((widget.liveRoomUserModel.sendLevel ?? '0') != '0')
                    Container(
                      width: 60,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.liveRoomUserModel.sandBgImage ?? '',
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/image/starlevel.png',
                            width: 12,
                          ),
                          horizontalGap(5),
                          Text(
                            '${widget.liveRoomUserModel.sendLevel}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  horizontalGap(5),
                  if ((widget.liveRoomUserModel.reciveLevel ?? '0') != '0')
                    Container(
                      width: 60,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.liveRoomUserModel.reciveBgImage ?? '',
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
                          Text(
                            '${widget.liveRoomUserModel.reciveLevel}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
              verticalGap(10),
              Visibility(
                visible: widget.roomDetail.userId ==
                        prefs.getString(PrefsKey.userId) &&
                    widget.liveRoomUserModel.id !=
                        prefs.getString(PrefsKey.userId),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        LiveRoomFirebase.addRemoveAdmin(
                            widget.roomDetail.id ?? '',
                            widget.liveRoomUserModel.id ?? '');
                        Navigator.pop(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.admin_panel_settings),
                          Text('Admin')
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [Icon(Icons.message), Text('Message')],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        kickoutUser();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [Icon(Icons.logout), Text('Kick out')],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Icon(Icons.admin_panel_settings_rounded),
                    //       Text('Invite')
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              verticalGap(20),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          sendLiveRoomMessage(context);
                        },
                        child: const Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '@',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Reminder',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // To enable custom height
                            builder: (context) => PrimeGiftBottom(
                                roomDetail: widget.roomDetail,
                                myCoins: widget.myCoins),
                          ).then(
                            (value) {
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/image/gift_wall_image.png',
                              width: 30,
                            ),
                            const Text(
                              'Send Gift',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          String type = 'follow';
                          followUnfollow(type);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 35,
                            ),
                            Text(
                              (otherUser?.followStatus ?? false)
                                  ? 'Following'
                                  : 'Follow',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> followUnfollow(String type) async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'followingUserId': widget.liveRoomUserModel.id,
      'type': type
    };
    await apiCallProvider.postRequest(API.followUnfollow, reqBody).then(
      (value) {
        if (value['message'] != null) {
          showToastMessage(value['message']);
          loadUserData();
        }
      },
    );
  }

  loadUserData() async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId) ?? '0',
      'otherUserId': widget.liveRoomUserModel.id,
      'kickTo': prefs.getString(PrefsKey.userId) ?? '0'
    };
    apiCallProvider.postRequest(API.getUserDataById, reqBody).then((value) {
      if (value['details'] != null) {
        otherUser = UserProfileDetail.fromMap(value['details']);
        setState(() {});
      }
    });
  }

  Future<dynamic> sendLiveRoomMessage(BuildContext context) {
    final TextEditingController messageCtrl =
        TextEditingController(text: '@${widget.liveRoomUserModel.username} ');
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
                              userId: widget.user?.id,
                              userImage: widget.user?.image,
                              userName: widget.user?.name);
                          LiveRoomFirebase.sendChat(
                                  widget.roomDetail.id ?? '', liveroomChat)
                              .then(
                            (value) {
                              Navigator.of(context, rootNavigator: true).pop();
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

  kickoutUser() async {
    if (widget.position == '-1') return;
    Map<String, dynamic> reqBody = {
      'kickToId': widget.liveRoomUserModel.id,
      'liveId': widget.roomDetail.id,
      'kickById': prefs.getString(PrefsKey.userId)
    };
    apiCallProvider
        .postRequest(API.kickOutLiveUser, reqBody)
        .then((value) async {
      if (value['success'] == '1') {
        LiveroomChat liveroomChat = LiveroomChat(
            message:
                '${widget.user?.name} kicked out ${widget.liveRoomUserModel.username}',
            timeStamp: DateTime.now().millisecondsSinceEpoch,
            userId: widget.user?.id,
            userImage: widget.user?.image,
            userName: widget.user?.name);
        LiveRoomFirebase.sendChat(widget.roomDetail.id ?? '', liveroomChat);

        LiveRoomFirebase.updateLiveRoomAdminSettings(
            widget.roomDetail.id ?? '',
            widget.liveRoomUserModel.id ?? '',
            'position',
            int.parse(widget.position) - 1);
        LiveRoomFirebase.updateLiveRoomAdminSettings(widget.roomDetail.id ?? '',
            widget.liveRoomUserModel.id ?? '', 'kickout', true);
        Navigator.pop(context);
      }
    });
  }
}
