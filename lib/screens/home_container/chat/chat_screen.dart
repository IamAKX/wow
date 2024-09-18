import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/chat_window_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/chat/chat_window.dart';
import 'package:worldsocialintegrationapp/screens/home_container/chat/friend_request.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';

import '../../../main.dart';
import '../../../models/user_profile_detail.dart';
import '../../../models/visitor_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/colors.dart';
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
      loadSelfUserData();
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
        }
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
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(FriendRequest.route);
            },
            icon: const Icon(Icons.person_add_alt_1_outlined),
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
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ChatWindowModel chatWindowModel = ChatWindowModel(
                      chatWindowId: getChatRoomId(
                          list.elementAt(index).id ?? '0',
                          prefs.getString(PrefsKey.userId)!),
                      currentUser: user,
                      friendUser: list.elementAt(index));
                  Navigator.of(context)
                      .pushNamed(ChatWindow.route, arguments: chatWindowModel);
                }),
            separatorBuilder: (context, index) => const Divider(
                  color: hintColor,
                  indent: 60,
                  endIndent: 20,
                ),
            itemCount: list.length);
  }
}
