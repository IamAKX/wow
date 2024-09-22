import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/friend_model.dart';

import '../../../main.dart';
import '../../../models/chat_model.dart';
import '../../../models/send_friend_model.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../services/firebase_db_service.dart';
import '../../../utils/api.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../utils/helpers.dart';
import '../../../utils/prefs_key.dart';
import '../../../widgets/circular_image.dart';
import '../../../widgets/enum.dart';
import '../../../widgets/gaps.dart';

class SendFriendScreen extends StatefulWidget {
  const SendFriendScreen({super.key, required this.sendFriendModel});
  static const String route = '/sendFriendScreen';
  final SendFriendModel sendFriendModel;

  @override
  State<SendFriendScreen> createState() => _SendFriendScreenState();
}

class _SendFriendScreenState extends State<SendFriendScreen> {
  late ApiCallProvider apiCallProvider;
  List<FriendModel> friendList = [];
  UserProfileDetail? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSelfUserData();
      getFriends();
    });
  }

  void loadSelfUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
        });
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
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.orange,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Friends'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView.builder(
      itemCount: friendList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircularImage(
            imagePath: friendList.elementAt(index).image ?? '',
            diameter: 50,
          ),
          title: Text(
            friendList.elementAt(index).name ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: InkWell(
            onTap: apiCallProvider.status == ApiStatus.loading
                ? null
                : () {
                    showSendUp(friendList.elementAt(index));
                  },
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3488D5),
                    Color(0xFFEA0A8A),
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Send',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          subtitle: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: const BoxDecoration(
                    color: Color(0xFF0FDEA5),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      true ? Icons.male : Icons.female,
                      color: Colors.white,
                      size: 12,
                    ),
                    Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(10),
              if ((friendList.elementAt(index).lavelInformation?.reciveLevel ??
                      '0') !=
                  '0')
                Container(
                  constraints: const BoxConstraints(minWidth: 50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFEE9DA8),
                        const Color(0xFFEE9DA8).withOpacity(0.5),
                        const Color(0xFFEE9DA8).withOpacity(0.2)
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/image/starlevel.png',
                        width: 10,
                      ),
                      horizontalGap(5),
                      Text(
                        friendList
                                .elementAt(index)
                                .lavelInformation
                                ?.reciveLevel ??
                            '',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ),
              horizontalGap(5),
              if ((friendList.elementAt(index).lavelInformation?.sendLevel ??
                      0) !=
                  '0')
                Image.asset(
                  'assets/image/money.png',
                  width: 15,
                ),
            ],
          ),
        );
      },
    );
  }

  void showSendUp(FriendModel friend) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled_sharp,
                      size: 20,
                      color: Color(0xFF7A7A7A),
                    ),
                    horizontalGap(5),
                    Text(
                      '${widget.sendFriendModel.validity}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              verticalGap(20),
              CircularImage(imagePath: friend.image ?? '', diameter: 100),
              verticalGap(20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/image/coins_img.png',
                    width: 20,
                  ),
                  Text(
                    '${widget.sendFriendModel.price}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              verticalGap(20),
              const Text(
                'Are you sure you want to send this car to your friend Test 2?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              verticalGap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  horizontalGap(20),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        sendLucky(friend);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFF73201),
                      ),
                      child: const Text(
                        'Send',
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void sendLucky(FriendModel otherUser) async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      widget.sendFriendModel.isCar! ? 'luckyId' : 'frameId':
          widget.sendFriendModel.id,
      'otherUserId': otherUser.id
    };
    await apiCallProvider
        .postRequest(
            widget.sendFriendModel.isCar! ? API.sendLuckyId : API.sendFrames,
            reqBody)
        .then((value) async {
      ChatModel chat = ChatModel(
          assetId: widget.sendFriendModel.id,
          assetTypeName: widget.sendFriendModel.isCar!
              ? MessageType.CAR.name
              : MessageType.FRAME.name,
          assetTypeId: widget.sendFriendModel.isCar! ? '1' : '2',
          isClaimed: false,
          message: '',
          msgType: widget.sendFriendModel.isCar!
              ? MessageType.CAR.name
              : MessageType.FRAME.name,
          senderId: prefs.getString(PrefsKey.userId),
          url: widget.sendFriendModel.url,
          videoThumbnaiil: '');
      await FirebaseDbService.sendChat(
          getChatRoomId(otherUser.id ?? '0', prefs.getString(PrefsKey.userId)!),
          chat);
      showToastMessage(value['message'] ?? '');
    });
  }
}
