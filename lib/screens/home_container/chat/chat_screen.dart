import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/chat_window_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/chat/chat_window.dart';
import 'package:worldsocialintegrationapp/screens/home_container/chat/friend_request.dart';
import 'package:worldsocialintegrationapp/services/firebase_db_service.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../main.dart';
import '../../../models/user_profile_detail.dart';
import '../../../models/visitor_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/colors.dart';
import '../../../utils/firebase_db_node.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../utils/prefs_key.dart';
import '../../../widgets/default_page_loader.dart';

class ChatScreen extends StatefulWidget {
  static const String route = '/chatScreen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<VisitorModel> list = [];
  late ApiCallProvider apiCallProvider;
  UserProfileDetail? user;
  Map<String, bool> onlineMap = {};
  Map<dynamic, dynamic> readReceiptMap = {};

  @override
  void initState() {
    super.initState();
    firebaseListners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
      loadSelfUserData();
      readReciptListner();
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

  loadUserData() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    apiCallProvider.postRequest(API.getFriendsDetails, reqBody).then((value) {
      list.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(VisitorModel.fromJson(item));
          onlineMap[VisitorModel.fromJson(item).id ?? ''] = false;
        }
        setState(() {});
        getOnlineStatus();
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
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(FriendRequest.route);
            },
            icon: Badge(
              isLabelVisible: requestCount > 0,
              label: Text('${requestCount}'),
              offset: const Offset(0, -10),
              backgroundColor: Colors.red,
              child: const Icon(Icons.person_add_alt_1_outlined),
            ),
          )
        ],
      ),
      body: apiCallProvider.status == ApiStatus.loading
          ? const DefaultPageLoader()
          : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return list.isEmpty
        ? const Center(
            child: Text('No Request Found'),
          )
        : ListView.separated(
            itemBuilder: (context, index) => ListTile(
                leading: CircularImage(
                    imagePath: list.elementAt(index).image ?? '', diameter: 40),
                title: Text(
                  list.elementAt(index).name ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (readReceiptMap.containsKey(getChatRoomId(
                            list.elementAt(index).id ?? '0',
                            prefs.getString(PrefsKey.userId)!)) &&
                        readReceiptMap[(getChatRoomId(
                                list.elementAt(index).id ?? '0',
                                prefs.getString(PrefsKey.userId)!))] !=
                            0) ...{
                      CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 10,
                          child: Text(
                            '${readReceiptMap[(getChatRoomId(list.elementAt(index).id ?? '0', prefs.getString(PrefsKey.userId)!))]}',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )),
                      horizontalGap(10),
                    },
                    if (onlineMap[list.elementAt(index).id] ?? false)
                      const Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 10,
                      ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
                onTap: () {
                  ChatWindowModel chatWindowModel = ChatWindowModel(
                      chatWindowId: getChatRoomId(
                          list.elementAt(index).id ?? '0',
                          prefs.getString(PrefsKey.userId)!),
                      currentUser: user,
                      friendUser: list.elementAt(index));
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(ChatWindow.route, arguments: chatWindowModel)
                      .then(
                    (value) {
                      triggerReadReciptListnerManually();
                    },
                  );
                }),
            separatorBuilder: (context, index) => const Divider(
                  color: hintColor,
                  indent: 60,
                  endIndent: 20,
                ),
            itemCount: list.length);
  }

  late StreamSubscription<DatabaseEvent> friendRequestListner;
  late StreamSubscription<DatabaseEvent> unreadMsgListner;
  int requestCount = 0;
  static FirebaseDatabase database = FirebaseDatabase.instance;

  void firebaseListners() {
    friendRequestListner = database
        .ref(
            '${FirebaseDbNode.friendRequestList}/${prefs.getString(PrefsKey.userId)}')
        .onValue
        .listen((event) async {
      final dataSnapshot = event.snapshot;

      if (dataSnapshot.exists) {
        requestCount = dataSnapshot.children.length;
        if (mounted) setState(() {});
      } else {
        requestCount = 0;
        if (mounted) setState(() {});
      }
    });
  }

  void readReciptListner() {
    unreadMsgListner = database
        .ref(
            '${FirebaseDbNode.chatReadReceipt}/${prefs.getString(PrefsKey.userId)}')
        .onValue
        .listen((event) async {
      final dataSnapshot = event.snapshot;

      if (dataSnapshot.exists) {
        readReceiptMap = dataSnapshot.value as Map;
        log('readReceiptMap : $readReceiptMap');
        if (mounted) setState(() {});
      } else {
        readReceiptMap.clear();
        if (mounted) setState(() {});
      }
    });
  }

  Future<void> triggerReadReciptListnerManually() async {
    log('clearing read recipt manually');
    DatabaseReference chatReadReceiptRef = database.ref(
        '${FirebaseDbNode.chatReadReceipt}/${prefs.getString(PrefsKey.userId)}');
    DataSnapshot dataSnapshot = await chatReadReceiptRef.get();
    if (dataSnapshot.exists) {
      readReceiptMap = dataSnapshot.value as Map<dynamic, dynamic>;
      log('readReceiptMap : $readReceiptMap');
      if (mounted) setState(() {});
    } else {
      readReceiptMap.clear();
      if (mounted) setState(() {});
    }
  }

  Future<void> getOnlineStatus() async {
    for (String key in onlineMap.keys) {
      bool status = await FirebaseDbService.getOnlineStatus(key);
      onlineMap[key] = status;
    }
    log('onlineMap : $onlineMap');
    setState(() {});
  }
}
