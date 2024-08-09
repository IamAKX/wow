import 'dart:developer';

import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/providers/api_call_provider.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';

import '../models/user_profile_detail.dart';

Future<UserProfileDetail?> getCurrentUser() async {
  UserProfileDetail? user;
  Map<String, dynamic> reqBody = {
    'userId': prefs.getString(PrefsKey.userId) ?? '41'
  };
  await ApiCallProvider.instance
      .postRequest(API.getUserDataById, reqBody)
      .then((value) {
    log('type : ${value.runtimeType}');
    if (value['data'] != null) {
      user = UserProfileDetail.fromMap(value['data']);
    }
  });
  return user;
}