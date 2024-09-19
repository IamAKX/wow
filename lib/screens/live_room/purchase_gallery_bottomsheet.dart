import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/gallery_price_model.dart';
import 'package:worldsocialintegrationapp/screens/live_room/get_friend_bottonsheet.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/joinable_live_room_model.dart';
import '../../providers/api_call_provider.dart';
import '../../services/live_room_firebase.dart';
import '../../utils/api.dart';
import '../../utils/prefs_key.dart';
import '../../widgets/enum.dart';

class PurchaseGalleryBottomsheet extends StatefulWidget {
  const PurchaseGalleryBottomsheet({super.key, required this.roomDetail});
  final JoinableLiveRoomModel roomDetail;

  @override
  State<PurchaseGalleryBottomsheet> createState() =>
      _PurchaseGalleryBottomsheetState();
}

class _PurchaseGalleryBottomsheetState
    extends State<PurchaseGalleryBottomsheet> {
  late ApiCallProvider apiCallProvider;

  final ImagePicker _picker = ImagePicker();
  File? _image;
  CroppedFile? croppedFile;

  List<GalleryPriceModel> priceModelList = [];

  pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
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
        _image = File(croppedFile!.path);
      } else {
        _image = null;
      }
      setState(() {});
    } else {
      _image = null;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPriceList();
    });
  }

  loadPriceList() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    await apiCallProvider.postRequest(API.getGallery, reqBody).then((value) {
      priceModelList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          priceModelList.add(GalleryPriceModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  Future<bool> buyGalleyTheme(String permissionId) async {
    bool res = false;
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'permissionId': permissionId,
    };

    if (_image != null) {
      MultipartFile profileImage = await MultipartFile.fromFile(_image!.path,
          filename: basename(_image!.path));
      reqBody['image'] = profileImage;
    }

    await apiCallProvider
        .postRequest(API.purchaseGallery, reqBody)
        .then((value) async {
      if (value['success'] == '1' && value['details'] != null) {
        for (var obj in value['details']) {
          await LiveRoomFirebase.updateLiveRoomTheme(
              widget.roomDetail.id ?? '', obj['image']);
        }
      }

      showToastMessage(value['message']);
      _image = null;
      setState(() {});
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: ClipRRect(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {},
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Purchase Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        pickImage(context);
                      },
                      icon: const Icon(
                        Icons.photo_library_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/image/coins_img.png',
                                      width: 20,
                                    ),
                                    horizontalGap(20),
                                    Text(
                                      priceModelList.elementAt(index).coins ??
                                          '0',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Valid ${priceModelList.elementAt(index).validity ?? '0'} days',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: apiCallProvider.status ==
                                    ApiStatus.loading
                                ? null
                                : () {
                                    if (_image == null) {
                                      showToastMessageWithLogo(
                                          'Please select image', context);
                                      return;
                                    }
                                    showToastMessageWithLogo(
                                        'Uploading, please wait', context);
                                    buyGalleyTheme(
                                      priceModelList.elementAt(index).id ?? '',
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Buy'),
                          ),
                          horizontalGap(10),
                          ElevatedButton(
                            onPressed:
                                apiCallProvider.status == ApiStatus.loading
                                    ? null
                                    : () {
                                        if (_image == null) {
                                          showToastMessageWithLogo(
                                              'Please select image', context);
                                          return;
                                        }
                                        showToastMessageWithLogo(
                                            'Uploading, please wait', context);

                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled:
                                              true, // To enable custom height
                                          builder: (context) =>
                                              GetFriendBottomsheet(
                                                  roomDetail: widget.roomDetail,
                                                  permissionId: priceModelList
                                                          .elementAt(index)
                                                          .id ??
                                                      '',
                                                  themeId: '',
                                                  image: _image!,
                                                  giftType: GiftType.GALLERY),
                                        ).then(
                                          (value) {
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Send'),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                      );
                    },
                    itemCount: priceModelList.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
