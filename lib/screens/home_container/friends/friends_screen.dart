import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/visitor_model.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../widgets/default_page_loader.dart';
import '../../../widgets/user_tile.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  List<VisitorModel> visitorList = [];
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  loadUserData() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    apiCallProvider.postRequest(API.getFriendsDetails, reqBody).then((value) {
      visitorList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          visitorList.add(VisitorModel.fromJson(item));
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
      body: apiCallProvider.status == ApiStatus.loading
          ? const DefaultPageLoader()
          : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: visitorList.length,
      itemBuilder: (context, index) => UserTile(
        visitorModel: visitorList.elementAt(index),
      ),
    );
  }
}
