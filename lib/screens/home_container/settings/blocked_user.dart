import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../models/blocked_user_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/prefs_key.dart';
import '../../../widgets/circular_image.dart';
import '../../../widgets/default_page_loader.dart';
import '../../../widgets/gaps.dart';
import '../user_detail_screen/other_user_detail_screen.dart';

class BlockedUserScreen extends StatefulWidget {
  const BlockedUserScreen({super.key});
  static const String route = '/blockedUserScreen';

  @override
  State<BlockedUserScreen> createState() => _BlockedUserScreenState();
}

class _BlockedUserScreenState extends State<BlockedUserScreen> {
  List<BlockedUserModel> blockedUserList = [];
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  loadUserData() async {
    Map<String, dynamic> reqBody = {
      'blocker': prefs.getString(PrefsKey.userId)
    };
    apiCallProvider.postRequest(API.getBlockUsers, reqBody).then((value) {
      blockedUserList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          blockedUserList.add(BlockedUserModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Blocked User'),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: apiCallProvider.status == ApiStatus.loading
          ? const DefaultPageLoader()
          : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: blockedUserList.length,
      itemBuilder: (context, index) => blockedUserTile(
        blockedUserList.elementAt(index),
      ),
    );
  }

  blockedUserTile(BlockedUserModel blockedUser) {
    return ListTile(
      leading: CircularImage(imagePath: blockedUser.image ?? '', diameter: 40),
      title: Text(
        blockedUser.name ?? '',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () => Navigator.of(context)
          .pushNamed(OtherUserDeatilScreen.route,
              arguments: blockedUser.id ?? '')
          .then(
        (value) {
          loadUserData();
        },
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
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
                const Text(
                  '22',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ),
          horizontalGap(5),
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
                const Text(
                  '22',
                  style: TextStyle(
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
  }
}
