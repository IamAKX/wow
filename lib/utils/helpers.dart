import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:worldsocialintegrationapp/models/new_live_user_model.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'dart:io';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import '../models/live_room_user_model.dart';

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

String getTimesAgo(String date) {
  try {
    DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);

    return timeago.format(parseDate, locale: 'en');
  } catch (e) {
    return '';
  }
}

String getTodaysDate() {
  try {
    return DateFormat('dd-MMM-yyyy').format(DateTime.now());
  } catch (e) {
    return '';
  }
}

String formatDate(DateTime dateTime) {
  try {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  } catch (e) {
    return '';
  }
}

String formatDBDate(DateTime dateTime) {
  try {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  } catch (e) {
    return '';
  }
}

Future<File> getFileFromAssets(String path) async {
  final byteData = await rootBundle.load(path);

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

String getChatRoomId(String userID1, String userID2) {
  // Convert userID1 and userID2 to integers
  int id1 = int.parse(userID1);
  int id2 = int.parse(userID2);

  // Sort the user IDs and join them with a colon
  if (id1 < id2) {
    return '$id1:$id2';
  } else {
    return '$id2:$id1';
  }
}

String getChatTimesAgo(int epochTime) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochTime);
  return timeago.format(dateTime, locale: 'en');
}

LiveRoomUserModel convertUserToLiveUser(UserProfileDetail? user) {
  return LiveRoomUserModel(
    id: user?.id,
    username: user?.name,
    usernameID: user?.username,
    familyId: user?.familyId,
    phone: user?.phone,
    image: user?.image,
    country: user?.country,
    age: user?.age,
    gender: user?.gender,
    sandColor: user?.lavelInfomation?.sandColor,
    sandBgImage: user?.lavelInfomation?.sandBgImage,
    sendLevel: user?.lavelInfomation?.sendLevel,
    sendExp: user?.lavelInfomation?.sendExp,
    sendStart: user?.lavelInfomation?.sendStart,
    sendEnd: user?.lavelInfomation?.sendEnd,
    reciveColor: user?.lavelInfomation?.reciveColor,
    reciveBgImage: user?.lavelInfomation?.reciveBgImage,
    reciveLevel: user?.lavelInfomation?.reciveLevel,
    reciveExp: user?.lavelInfomation?.reciveExp,
    reciveStart: user?.lavelInfomation?.reciveStart,
    reciveEnd: user?.lavelInfomation?.reciveEnd,
  );
}

Map<int, Object?> convertToObjectMap(Map<int, LiveRoomUserModel?> inputMap) {
  return inputMap.map((key, value) {
    return MapEntry(key, value?.toMap());
  });
}

Map<int, LiveRoomUserModel?> convertToHotSeat(Map<String, Object?> inputMap) {
  return inputMap.map((key, value) {
    return MapEntry(int.parse(key), value as LiveRoomUserModel?);
  });
}

String formatDiamondNumber(double number) {
  if (number >= 1000000) {
    // Format numbers in millions
    return (number / 1000000).toStringAsFixed(1) + 'M';
  } else if (number >= 1000) {
    // Format numbers in thousands
    return (number / 1000).toStringAsFixed(1) + 'k';
  } else {
    // Return numbers as is if they are less than 1000
    return number.toString();
  }
}

Future<String?> showPasswordDialog(
    BuildContext context, String roomPassword) async {
  TextEditingController passwordController = TextEditingController();

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Room Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Room is locked, enter password to enter'),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              controller: passwordController,
              obscureText: true, // To hide the text for password input
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(); // Close dialog without returning a value
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (roomPassword == passwordController.text) {
                Navigator.pop(context, 'true');
              } else {
                showToastMessage('Incorrect password');
                Navigator.pop(context, 'false');
              } // Return the password
            },
            child: const Text('Enter'),
          ),
        ],
      );
    },
  );
}

Future<File?> getCroppedImage(File pickedFile, BuildContext context) async {
  File image = File(pickedFile.path);
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: image.path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Edit Photo',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5
        ],
      ),
      IOSUiSettings(
        title: 'Edit Photo',
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio7x5
        ],
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );
  if (croppedFile != null) {
    return File(croppedFile!.path);
  } else {
    return null;
  }
}

String formatDuration(int seconds) {
  Duration duration = Duration(seconds: seconds);

  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String hours = twoDigits(duration.inHours);
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String secs = twoDigits(duration.inSeconds.remainder(60));

  return '$hours:$minutes:$secs';
}

List<TextSpan> getMentionTextSpans(String text) {
  List<TextSpan> spans = [];
  RegExp mentionRegExp = RegExp(r'@\w+');
  final matches = mentionRegExp.allMatches(text);

  int lastMatchEnd = 0;
  for (var match in matches) {
    // Add non-mentioned text
    if (match.start > lastMatchEnd) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd, match.start),
        style: TextStyle(color: Colors.white),
      ));
    }

    // Add the mentioned text
    spans.add(
      TextSpan(
        text: match.group(0), // the @username
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );

    lastMatchEnd = match.end;
  }

  // Add any remaining text after the last match
  if (lastMatchEnd < text.length) {
    spans.add(TextSpan(
      text: text.substring(lastMatchEnd),
      style: TextStyle(color: Colors.white),
    ));
  }

  return spans;
}

// Function to find and style digits in purple
List<TextSpan> getPurpleDigitsTextSpans(String text) {
  List<TextSpan> spans = [];
  RegExp digitRegExp = RegExp(r'\d'); // Regular expression to match digits
  final matches = digitRegExp.allMatches(text);

  int lastMatchEnd = 0;
  for (var match in matches) {
    // Add non-digit text before the digit
    if (match.start > lastMatchEnd) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd, match.start),
        style: TextStyle(color: Colors.black, fontSize: 14),
      ));
    }

    // Add the digit with purple color
    spans.add(TextSpan(
      text: match.group(0), // the digit

      style: TextStyle(
          color: Colors.purple, fontSize: 14, fontWeight: FontWeight.bold),
    ));

    lastMatchEnd = match.end;
  }

  // Add remaining non-digit text after the last match
  if (lastMatchEnd < text.length) {
    spans.add(TextSpan(
      text: text.substring(lastMatchEnd),
      style: TextStyle(color: Colors.black, fontSize: 14),
    ));
  }

  return spans;
}
