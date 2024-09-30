import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:svgaplayer_flutter_rhr/svgaplayer_flutter.dart';
import 'package:worldsocialintegrationapp/models/live_gift_model.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/friend_model.dart';
import '../../models/joinable_live_room_model.dart';
import '../../models/live_room_user_model.dart';
import '../../models/liveroom_chat.dart';
import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../services/live_room_firebase.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import '../../utils/prefs_key.dart';
import '../../widgets/enum.dart';

class GetFriendBottomsheet extends StatefulWidget {
  GetFriendBottomsheet(
      {super.key,
      required this.roomDetail,
      required this.permissionId,
      required this.themeId,
      required this.image,
      required this.giftType,
      this.isSvga,
      this.imageLink,
      required this.friendList});
  final JoinableLiveRoomModel roomDetail;
  final String permissionId;
  final String themeId;
  final File image;
  final List<LiveRoomUserModel> friendList;
  final GiftType giftType;
  bool? isSvga;
  String? imageLink;

  @override
  State<GetFriendBottomsheet> createState() => _GetFriendBottomsheetState();
}

class _GetFriendBottomsheetState extends State<GetFriendBottomsheet> {
  late ApiCallProvider apiCallProvider;
  // List<FriendModel> friendList = [];
  // List<LiveRoomUserModel> friendList = [];
  UserProfileDetail? user;

  void loadUserData() async {
    await getCurrentUser().then(
      (value) async {
        user = value;
      },
    );
  }

  // getFriends() async {
  //   friendList = await LiveRoomFirebase.getLiveRoomParticipants(
  //       widget.roomDetail.id ?? '');
  //   friendList.removeWhere(
  //     (element) => element.sendLevel == '0' || element.reciveLevel == '0',
  //   );
  //   setState(() {});
  //   //   Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
  //   //   await apiCallProvider
  //   //       .postRequest(API.getFriendsDetails, reqBody)
  //   //       .then((value) {
  //   //     if (value['details'] != null) {
  //   //       for (var item in value['details']) {
  //   //         friendList.add(FriendModel.fromJson(item));
  //   //       }
  //   //       log(friendList.length.toString());
  //   //       setState(() {});
  //   //     }
  //   //   });
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
      // getFriends();
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: ClipRRect(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {},
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                      ),
                    ),
                    horizontalGap(20),
                    const Text(
                      'Friends',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          CircularImage(
                              imagePath:
                                  widget.friendList.elementAt(index).image ??
                                      '',
                              diameter: 50),
                          horizontalGap(10),
                          Expanded(
                            child: Text(
                              widget.friendList.elementAt(index).username ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (widget.giftType == GiftType.STORE) {
                                await sendStoreTheme(
                                    widget.friendList.elementAt(index).id ?? '',
                                    widget.friendList.elementAt(index));
                              }
                              if (widget.giftType == GiftType.GALLERY) {
                                await sendGalleryTheme(
                                    widget.friendList.elementAt(index).id ?? '',
                                    widget.friendList.elementAt(index));
                              }
                              if (widget.giftType == GiftType.PRIME) {
                                await sendPrimeGift(
                                    widget.friendList.elementAt(index).id ?? '',
                                    widget.friendList.elementAt(index));
                              }
                              // Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Send'),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                      );
                    },
                    itemCount: widget.friendList.length),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendPrimeGift(
    String otherId,
    LiveRoomUserModel friend,
  ) async {
    Map<String, dynamic> reqBody = {
      'senderId': prefs.getString(PrefsKey.userId),
      'receiverId': otherId,
      'giftId': widget.themeId,
      'diamond': widget.permissionId,
      'liveId': widget.roomDetail.id
    };
    LiveGiftModel liveGiftModel = LiveGiftModel(
        senderId: prefs.getString(PrefsKey.userId),
        receiverId: otherId,
        url: widget.imageLink,
        position: -1);
    await apiCallProvider
        .postRequest(API.sendGift, reqBody)
        .then((value) async {
      showToastMessage(value['message']);
      if (value['success'] == '1') {
        LiveroomChat liveroomChat = LiveroomChat(
            message:
                '${user?.name ?? ''} sent gift to ${friend.username ?? ''}',
            timeStamp: DateTime.now().millisecondsSinceEpoch,
            userId: user?.id,
            userImage: user?.image,
            userName: user?.name);
        LiveRoomFirebase.sendChat(widget.roomDetail.id ?? '', liveroomChat)
            .then(
          (value) {},
        );

        LiveRoomFirebase.addGift(widget.roomDetail.id ?? '', liveGiftModel);

        if (widget.isSvga ?? false) {
          // _showSnackbarWithImage();
        }
      }
    });
  }

  Future<void> sendStoreTheme(String otherId, LiveRoomUserModel friend) async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'otherUserId': otherId,
      'themeId': widget.themeId
    };
    await apiCallProvider
        .postRequest(API.sendThemes, reqBody)
        .then((value) async {
      showToastMessage(value['message']);
      if (value['success'] == '1') {
        await apiCallProvider
            .postRequest(API.sendGallery, reqBody)
            .then((value) {
          showToastMessage(value['message']);
          if (value['success'] == '1') {
            LiveroomChat liveroomChat = LiveroomChat(
                message:
                    '${user?.name ?? ''} sent theme to ${friend.username ?? ''}',
                timeStamp: DateTime.now().millisecondsSinceEpoch,
                userId: user?.id,
                userImage: user?.image,
                userName: user?.name);
            LiveRoomFirebase.sendChat(widget.roomDetail.id ?? '', liveroomChat)
                .then(
              (value) {},
            );
          }
        });
      }
    });
  }

  Future<void> sendGalleryTheme(
    String otherId,
    LiveRoomUserModel friend,
  ) async {
    showToastMessage('Uploading, please wait');
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'otherUserId': otherId,
      'permissionId': widget.permissionId
    };

    if (widget.image != null) {
      MultipartFile profileImage = await MultipartFile.fromFile(
          widget.image.path,
          filename: basename(widget.image.path));
      reqBody['image'] = profileImage;
    }

    await apiCallProvider.postRequest(API.sendGallery, reqBody).then((value) {
      showToastMessage(value['message']);
      if (value['success'] == '1') {
        LiveroomChat liveroomChat = LiveroomChat(
            message:
                '${user?.name ?? ''} sent theme to ${friend.username ?? ''}',
            timeStamp: DateTime.now().millisecondsSinceEpoch,
            userId: user?.id,
            userImage: user?.image,
            userName: user?.name);
        LiveRoomFirebase.sendChat(widget.roomDetail.id ?? '', liveroomChat)
            .then(
          (value) {},
        );
      }
    });
  }
}
