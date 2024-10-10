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

class SendVipToFriendScreen extends StatefulWidget {
  const SendVipToFriendScreen({super.key, required this.vipType});
  static const String route = '/sendVipToFriendScreen';
  final String vipType;

  @override
  State<SendVipToFriendScreen> createState() => _SendVipToFriendScreenState();
}

class _SendVipToFriendScreenState extends State<SendVipToFriendScreen> {
  late ApiCallProvider apiCallProvider;
  List<FriendModel> friendList = [];
  UserProfileDetail? user;
  List<String> sentList = [];

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
            onTap: sentList.contains(friendList.elementAt(index).id)
                ? null
                : () {
                    sendVip(friendList.elementAt(index).id ?? '');
                  },
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: sentList.contains(friendList.elementAt(index).id)
                    ? const LinearGradient(
                        colors: [
                          Colors.grey,
                          Colors.grey,
                        ],
                      )
                    : const LinearGradient(
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
                decoration: BoxDecoration(
                    color: friendList.elementAt(index).gender == 'Male'
                        ? Color(0xFF0FDEA5)
                        : Color.fromARGB(255, 245, 97, 250),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      friendList.elementAt(index).gender == 'Male'
                          ? Icons.male
                          : Icons.female,
                      color: Colors.white,
                      size: 12,
                    ),
                    Text(
                      friendList.elementAt(index).age ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(10),
              if ((friendList.elementAt(index).lavelInformation?.sendLevel ??
                      '0') !=
                  '0')
                Container(
                  width: 60,
                  padding: const EdgeInsets.all(3),
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
                      Text(
                        (friendList
                                .elementAt(index)
                                .lavelInformation
                                ?.sendLevel ??
                            '0'),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  ),
                ),
              horizontalGap(5),
              if ((friendList.elementAt(index).lavelInformation?.reciveLevel ??
                      '0') !=
                  '0')
                Container(
                  width: 60,
                  padding: const EdgeInsets.all(3),
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
                      Text(
                        (friendList
                                .elementAt(index)
                                .lavelInformation
                                ?.reciveLevel ??
                            '0'),
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
        );
      },
    );
  }

  void sendVip(String otherUserId) async {
    Map<String, dynamic> reqBody = {
      'senderId': prefs.getString(PrefsKey.userId),
      'receiverId': otherUserId,
      'vipType': widget.vipType
    };
    await apiCallProvider.postRequest(API.sendVip, reqBody).then((value) async {
      showToastMessage(value['message'] ?? '');
      if (value['success'] == '0') {
        sentList.add(otherUserId);
      }
      log('sentList = $sentList');
      setState(() {});
    });
  }
}
