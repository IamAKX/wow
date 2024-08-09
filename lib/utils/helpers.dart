import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

Future<void> openInBrowser(String url) async {
  if (await launchUrl(Uri.parse(url))) {
  } else {
    throw 'Could not launch $url';
  }
}

void showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xFFF8F9FC),
      textColor: Colors.black,
      fontSize: 16.0);
}

void showToastMessageWithLogo(String message, BuildContext context) {
  FToast fToast;
  fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    toastDuration: const Duration(seconds: 3),
    child: Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFFF8F9FC),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/image/wow_logo_192.png',
                width: 20,
              ),
            ),
            horizontalGap(10),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    ),
    gravity: ToastGravity.BOTTOM,
  );
}

Future<String?> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String? deviceId;

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.id; // Equivalent to ANDROID_ID
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceId = iosInfo.identifierForVendor; // Unique ID on iOS devices
  }
  return deviceId;
}
