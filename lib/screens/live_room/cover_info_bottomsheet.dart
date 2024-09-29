import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/joinable_live_room_model.dart';
import 'package:worldsocialintegrationapp/services/live_room_firebase.dart';
import 'package:worldsocialintegrationapp/widgets/button_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/helpers.dart';

class CoverInfoBottomsheet extends StatefulWidget {
  const CoverInfoBottomsheet(
      {super.key, required this.userId, required this.roomDetail});
  final String userId;
  final JoinableLiveRoomModel roomDetail;
  @override
  State<CoverInfoBottomsheet> createState() => _CoverInfoBottomsheetState();
}

class _CoverInfoBottomsheetState extends State<CoverInfoBottomsheet> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
    CroppedFile? croppedFile;
  final TextEditingController _titleCtrl = TextEditingController();
  late ApiCallProvider apiCallProvider;

  final List<String> _chipLabels = [
    'Any',
    'Live',
    'Chat',
    'Party',
    'Sing',
    'Radio',
    'Game',
    'Scoor',
    'Birthday',
    'Emotions',
    'Dj'
  ];

  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _chipLabels.indexOf(widget.roomDetail.imageText ?? '');
    _titleCtrl.text = widget.roomDetail.imageTitle ?? '';
    setState(() {});
    _titleCtrl.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return FractionallySizedBox(
      heightFactor: 0.7, // Set height to 60% of screen height
      child: ClipRRect(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _image!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: widget.roomDetail.liveimage ?? '',
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey,
                                    width: 80,
                                    height: 80,
                                  ),
                                  fit: BoxFit.fill,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: InkWell(
                          onTap: () async {
                            final pickedFile = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              if (pickedFile != null) {
                                _image = File(pickedFile.path);
                              } else {
                                log('No image selected.');
                              }
                            });
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 12,
                            child: Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              verticalGap(20),
              TextField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  hintText: 'Your Live\'s Title',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                ),
              ),
              verticalGap(20),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4, // 4 chips per row
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2,
                children: List.generate(_chipLabels.length, (index) {
                  return LayoutBuilder(builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth,
                      child: ChoiceChip(
                        label: Text(_chipLabels[index]),
                        selected: _selectedIndex == index,

                        onSelected: (bool isSelected) {
                          setState(() {
                            _selectedIndex = isSelected ? index : -1;
                          });
                        },
                        selectedColor: Colors.red, // Color when selected
                        side: const BorderSide(
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  });
                }),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_image == null &&
                              (widget.roomDetail.liveimage?.isEmpty ?? true)) ||
                          _selectedIndex == -1 ||
                          _titleCtrl.text.isEmpty ||
                          apiCallProvider.status == ApiStatus.loading
                      ? null
                      : () async {
                          Map<String, dynamic> reqBody = {
                            'userId': widget.userId,
                            'liveId': widget.roomDetail.id,
                            'imageText': _chipLabels[_selectedIndex],
                            'imageTitle': _titleCtrl.text,
                          };
                          if (_image != null) {
                            MultipartFile profileImage =
                                await MultipartFile.fromFile(_image!.path,
                                    filename: basename(_image!.path));
                            reqBody['Liveimage'] = profileImage;
                          }
                          apiCallProvider
                              .postRequest(API.setLiveImage, reqBody)
                              .then((value) async {
                            if (apiCallProvider.status == ApiStatus.success) {
                              showToastMessageWithLogo(
                                  '${value['message']}', context);
                              JoinableLiveRoomModel joinableLiveRoomModel =
                                  JoinableLiveRoomModel.fromJson(
                                      value['details']);
                              await LiveRoomFirebase.updateLiveRoomInfo(
                                  joinableLiveRoomModel);
                            } else {
                              showToastMessageWithLogo(
                                  'Request failed', context);
                            }
                            Navigator.pop(context);
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: apiCallProvider.status == ApiStatus.loading
                      ? const ButtonLoader()
                      : const Text('Confirm'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
