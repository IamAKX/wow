import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/create_event.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/button_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../widgets/bordered_circular_image.dart';

class CreateEventTwo extends StatefulWidget {
  const CreateEventTwo({super.key, required this.createEvent});
  static const String route = '/createEventTwo';
  final CreateEvent createEvent;

  @override
  State<CreateEventTwo> createState() => _CreateEventTwoState();
}

class _CreateEventTwoState extends State<CreateEventTwo> {
  CreateEvent createEvent = CreateEvent(event_Type: 'Themed');
  final TextEditingController topicCtrl = TextEditingController();
  final TextEditingController ruleCtrl = TextEditingController();
  DateTime eventStartTime = DateTime.now();
  UserProfileDetail? user;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  void loadUserData() async {
    await getCurrentUser().then(
      (value) async {
        user = value;
        setState(() {});
      },
    );
  }

  Future<void> postEvent() async {
    _image ??= await getFileFromAssets(getDefaultBGPathByTopic());
    Map<String, dynamic> reqBody = {
      'event_topic': widget.createEvent.event_topic,
      'userId': prefs.getString(PrefsKey.userId),
      'description': widget.createEvent.description,
      'event_startTime': widget.createEvent.event_startTime,
      'event_Type': widget.createEvent.event_Type,
      'event_image': _image,
    };

    if (_image != null) {
      MultipartFile eventImage = await MultipartFile.fromFile(_image!.path,
          filename: basename(_image!.path));
      reqBody['event_image'] = eventImage;
    }
    await apiCallProvider.postRequest(API.createEvent, reqBody).then((value) {
      if (value['message'] != null) {
        showToastMessage(value['message']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF00EE),
                Color(0xFF9600FF),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalGap(60),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Select a poster',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
              ],
            ),
            getPosterPreview(context),
            InkWell(
              onTap: () async {
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  if (pickedFile != null) {
                    _image = File(pickedFile.path);
                  } else {
                    _image = null;
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.all(pagePadding),
                width: 150,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: _image == null
                          ? getDefaultBGImageByTopic()
                          : FileImage(_image!),
                      fit: BoxFit.fill),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Select poster',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            verticalGap(20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green, // Text color
                  shadowColor: Colors.green, // No shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: apiCallProvider.status == ApiStatus.loading
                    ? null
                    : () async {
                        await postEvent().then(
                          (value) {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: apiCallProvider.status == ApiStatus.loading
                      ? const ButtonLoader()
                      : const Text('Post Event'),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  getPosterPreview(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        image: DecorationImage(
            image: _image == null
                ? getDefaultBGImageByTopic()
                : FileImage(_image!),
            fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                BorderedCircularImage(
                  imagePath: user?.image ?? '',
                  diameter: 40,
                  borderColor: Colors.white,
                  borderThickness: 2,
                ),
                horizontalGap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user?.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Id : ${user?.username ?? ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                horizontalGap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.createEvent.description ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                horizontalGap(5),
                Text(
                  'will start on ${widget.createEvent.event_startTime ?? ''}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              widget.createEvent.event_topic ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  getDefaultBGImageByTopic() {
    switch (widget.createEvent.event_Type) {
      case 'Themed':
        return const AssetImage(
          'assets/image/yellow_light.jpeg',
        );
      case 'Birthday':
        return const AssetImage(
          'assets/image/birthday_image_11.jpeg',
        );
      case 'Anniversary':
        return const AssetImage(
          'assets/image/bdat.webp',
        );
    }
  }

  String getDefaultBGPathByTopic() {
    switch (widget.createEvent.event_Type) {
      case 'Themed':
        return 'assets/image/yellow_light.jpeg';
      case 'Birthday':
        return 'assets/image/birthday_image_11.jpeg';
      case 'Anniversary':
        return 'assets/image/bdat.webp';
      default:
        return 'assets/image/bdat.webp';
    }
  }
}
