import 'dart:developer';

import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/providers/api_call_provider.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';

import '../models/user_profile_detail.dart';

Future<UserProfileDetail?> getCurrentUser() async {
  UserProfileDetail? user;
  Map<String, dynamic> reqBody = {
    'userId': prefs.getString(PrefsKey.userId) ?? '0',
    'otherUserId': prefs.getString(PrefsKey.userId) ?? '0',
    'kickTo': prefs.getString(PrefsKey.userId) ?? '0'
  };
  await ApiCallProvider.instance
      .postRequest(API.getUserDataById, reqBody)
      .then((value) {
    if (value['details'] != null) {
      user = UserProfileDetail.fromMap(value['details']);
    }
  });
  return user;
}

Future<String> loadFrame() async {
  Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
  String frame = '';
  await ApiCallProvider.instance
      .postRequest(API.getAppliedFrame, reqBody)
      .then((value) {
    if (value['details'] != null) {
      frame = value['details']['frame_img'];
    }
  });

  return frame;
}
