import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';
import 'package:worldsocialintegrationapp/widgets/media_preview.dart';
import 'package:worldsocialintegrationapp/widgets/media_preview_fullscreen.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../widgets/button_loader.dart';

class AddMoments extends StatefulWidget {
  static const String route = '/addMoments';

  const AddMoments({super.key});

  @override
  State<AddMoments> createState() => _AddMomentsState();
}

class _AddMomentsState extends State<AddMoments> {
  final TextEditingController _descCtrl = TextEditingController();
  File? file;
  late ApiCallProvider apiCallProvider;

  List<String> imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
    'heic',
    'heif'
  ];
  List<String> videoExtensions = [
    'mp4',
    'mov',
    'avi',
    'webm',
    'mkv',
  ];

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add Moment'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Card(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: TextField(
                      controller: _descCtrl,
                      keyboardType: TextInputType.text,
                      maxLines: 20,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        hintText: 'Description here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 5,
                  height: double.infinity,
                  child: InkWell(
                    onLongPress: () {
                      if (file != null) {
                        Navigator.of(context).pushNamed(
                            MediaPreviewFullScreen.route,
                            arguments: file!.path);
                      }
                    },
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowedExtensions: [
                          ...imageExtensions,
                          ...videoExtensions,
                        ],
                        type: FileType.custom,
                      );

                      if (result != null) {
                        file = File(result.files.single.path!);
                        log('File : ${file!.path}');
                        setState(() {});
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: file != null
                          ? MediaPreview(
                              key: ValueKey(file!.path),
                              filePathOrUrl: file!.path)
                          : const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 70,
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        verticalGap(pagePadding),
        getCancelUploadButton(context),
      ],
    );
  }

  Padding getCancelUploadButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: const Color(0xFFFE6E49),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Cancle',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          horizontalGap(10),
          Expanded(
            child: InkWell(
              onTap: apiCallProvider.status == ApiStatus.loading
                  ? null
                  : () async {
                      if (_descCtrl.text.isEmpty || file == null) {
                        showToastMessageWithLogo(
                            'All fields are mandatory', context);
                        return;
                      }
                      String fileExtension = extension(file!.path)
                          .toLowerCase()
                          .replaceAll('.', '');
                      log(fileExtension);
                      int type = -1;
                      if (videoExtensions.contains(fileExtension)) {
                        type = 1;
                      }
                      if (imageExtensions.contains(fileExtension)) {
                        type = 0;
                      }

                      MultipartFile img = await MultipartFile.fromFile(
                          file!.path,
                          filename: basename(file!.path));
                      Map<String, dynamic> reqBody = {
                        'userId': prefs.getString(PrefsKey.userId),
                        'description': _descCtrl.text,
                        'status': type,
                        'image': img,
                      };
                      apiCallProvider
                          .postRequest(API.userPostAndVideo, reqBody)
                          .then((value) {
                        if (apiCallProvider.status == ApiStatus.success) {
                          showToastMessageWithLogo(
                              '${value['message']}', context);
                          if (value['success'] == '1') {
                            Navigator.of(context).pop();
                          }
                        } else {
                          showToastMessageWithLogo('Request failed', context);
                        }
                      });
                    },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3488D5),
                      Color(0xFFEA0A8A),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: apiCallProvider.status == ApiStatus.loading
                    ? const ButtonLoader()
                    : const Text(
                        'Upload',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
