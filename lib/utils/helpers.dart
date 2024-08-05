import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

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
      toastLength: Toast.LENGTH_SHORT,
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
    toastDuration: const Duration(seconds: 1),
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
