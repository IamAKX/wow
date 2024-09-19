import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/friend_model.dart';
import '../../models/joinable_live_room_model.dart';
import '../../models/liveroom_chat.dart';
import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../services/live_room_firebase.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import '../../utils/prefs_key.dart';
import '../../widgets/enum.dart';

class GetFriendBottomsheet extends StatefulWidget {
  const GetFriendBottomsheet(
      {super.key,
      required this.roomDetail,
      required this.permissionId,
      required this.themeId,
      required this.image,
      required this.giftType});
  final JoinableLiveRoomModel roomDetail;
  final String permissionId;
  final String themeId;
  final File image;
  final GiftType giftType;

  @override
  State<GetFriendBottomsheet> createState() => _GetFriendBottomsheetState();
}

class _GetFriendBottomsheetState extends State<GetFriendBottomsheet> {
  late ApiCallProvider apiCallProvider;
  List<FriendModel> friendList = [];
  UserProfileDetail? user;

  void loadUserData() async {
    await getCurrentUser().then(
      (value) async {
        user = value;
      },
    );
  }

  getFriends() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    await apiCallProvider
        .postRequest(API.getFriendsDetails, reqBody)
        .then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          friendList.add(FriendModel.fromJson(item));
        }
        log(friendList.length.toString());
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
      getFriends();
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
                                  friendList.elementAt(index).image ?? '',
                              diameter: 50),
                          horizontalGap(10),
                          Expanded(
                            child: Text(
                              friendList.elementAt(index).name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: apiCallProvider.status ==
                                    ApiStatus.loading
                                ? null
                                : () async {
                                    if (widget.giftType == GiftType.STORE) {
                                      await sendStoreTheme(
                                          friendList.elementAt(index).id ?? '',
                                          friendList.elementAt(index));
                                    }
                                    if (widget.giftType == GiftType.GALLERY) {
                                      await sendGalleryTheme(
                                          friendList.elementAt(index).id ?? '',
                                          friendList.elementAt(index));
                                    }
                                    if (widget.giftType == GiftType.PRIME) {
                                      await sendPrimeGift(
                                          friendList.elementAt(index).id ?? '',
                                          friendList.elementAt(index));
                                    }
                                    Navigator.pop(context);
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
                    itemCount: friendList.length),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendPrimeGift(String otherId, FriendModel friend) async {
    Map<String, dynamic> reqBody = {
      'senderId': prefs.getString(PrefsKey.userId),
      'receiverId': otherId,
      'giftId': widget.themeId,
      'diamond': widget.permissionId,
      'liveId': widget.roomDetail.id
    };
    await apiCallProvider
        .postRequest(API.sendGift, reqBody)
        .then((value) async {
      showToastMessage(value['message']);
      if (value['success'] == '1') {
        LiveroomChat liveroomChat = LiveroomChat(
            message: '${user?.name ?? ''} sent gift to ${friend.name ?? ''}',
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

  Future<void> sendStoreTheme(String otherId, FriendModel friend) async {
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
                    '${user?.name ?? ''} sent theme to ${friend.name ?? ''}',
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

  Future<void> sendGalleryTheme(String otherId, FriendModel friend) async {
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
            message: '${user?.name ?? ''} sent theme to ${friend.name ?? ''}',
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
