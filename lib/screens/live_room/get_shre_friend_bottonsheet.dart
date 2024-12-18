import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/chat_model.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/friend_model.dart';
import '../../models/joinable_live_room_model.dart';
import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../services/firebase_db_service.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import '../../utils/helpers.dart';
import '../../utils/prefs_key.dart';

class GetShareFriendBottomsheet extends StatefulWidget {
  GetShareFriendBottomsheet({
    super.key,
    required this.roomDetail,
    required this.chatModel,
  });
  final JoinableLiveRoomModel roomDetail;
  final ChatModel chatModel;

  @override
  State<GetShareFriendBottomsheet> createState() =>
      _GetShareFriendBottomsheetState();
}

class _GetShareFriendBottomsheetState extends State<GetShareFriendBottomsheet> {
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
                            imagePath: friendList.elementAt(index).image ?? '',
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
                          onPressed: () async {
                            await FirebaseDbService.sendChat(
                                getChatRoomId(
                                    friendList.elementAt(index).id ?? '0',
                                    prefs.getString(PrefsKey.userId)!),
                                widget.chatModel);

                            showToastMessage(
                                'Invite sent to ${friendList.elementAt(index).name}');
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
                  itemCount: friendList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
