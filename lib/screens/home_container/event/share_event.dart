import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/button_loader.dart';
import 'package:worldsocialintegrationapp/widgets/user_tile_with_action.dart';

import '../../../main.dart';
import '../../../models/visitor_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/prefs_key.dart';

class ShareEvent extends StatefulWidget {
  const ShareEvent({super.key, required this.event});
  static const String route = '/shareEvent';
  final String event;

  @override
  State<ShareEvent> createState() => _ShareEventState();
}

class _ShareEventState extends State<ShareEvent> {
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

  sendEvent(String userId) async {
    Map<String, dynamic> reqBody = {'userId': userId, 'eventId': widget.event};
    apiCallProvider.postRequest(API.sendEventInvitation, reqBody).then((value) {
      if (value['message'] != null) {
        showToastMessage(value['message']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.redAccent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text(
          'Details',
        ),
      ),
      backgroundColor: Colors.white,
      body: visitorList.isEmpty
          ? const Center(
              child: Text(
                'No Friend Found',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: visitorList.length,
      itemBuilder: (context, index) => UserTileWithAction(
        visitorModel: visitorList.elementAt(index),
        trailingWidget: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue, // Text color
            shadowColor: Colors.blue, // No shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
            sendEvent(visitorList.elementAt(index).id ?? '');
          },
          child: apiCallProvider.status == ApiStatus.loading
              ? const ButtonLoader()
              : const Text('SEND'),
        ),
      ),
    );
  }
}
