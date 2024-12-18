import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/button_loader.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/family_details.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../utils/helpers.dart';

class EditFamily extends StatefulWidget {
  const EditFamily({super.key});
  static const String route = '/editFamily';

  @override
  State<EditFamily> createState() => _EditFamilyState();
}

class _EditFamilyState extends State<EditFamily> {
  late ApiCallProvider apiCallProvider;
  final TextEditingController familyNameCtrl = TextEditingController();
  final TextEditingController familyDescCtrl = TextEditingController();
  FamilyDetails? familyDetails;
  UserProfileDetail? user;

  File? _image;
  final ImagePicker _picker = ImagePicker();
  CroppedFile? croppedFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  void loadUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
        });
        loadFamilyDeatilsData(value?.id ?? '', value?.familyId ?? '');
      },
    );
  }

  void loadFamilyDeatilsData(String userId, String familyId) async {
    Map<String, dynamic> reqBody = {'userId': userId, 'familyId': familyId};
    apiCallProvider.postRequest(API.getFamiliesDetails, reqBody).then((value) {
      if (value['details'] != null) {
        familyDetails = FamilyDetails.fromJson(value['details']);
        setState(() {});
        familyDescCtrl.text = familyDetails?.family?.description ?? '';
        familyNameCtrl.text = familyDetails?.family?.familyName ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text('Edit Family Profile'),
          actions: [],
        ),
        body: apiCallProvider.status == ApiStatus.loading
            ? const DefaultPageLoader()
            : getBody(context));
  }

  getBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(pagePadding),
      children: [
        verticalGap(pagePadding),
        InkWell(
          onTap: () async {
            final pickedFile =
                await _picker.pickImage(source: ImageSource.gallery);

            if (pickedFile != null) {
              _image = await getCroppedImage(File(pickedFile.path), context);
            } else {
              _image = null;
            }
            setState(() {});
          },
          child: Align(
            alignment: Alignment.center,
            child: _image != null
                ? ClipOval(
                    child: Image.file(
                      _image!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  )
                : CircularImage(
                    imagePath: familyDetails?.image ?? '',
                    diameter: 80,
                  ),
          ),
        ),
        verticalGap(pagePadding),
        TextField(
          controller: familyNameCtrl,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: pagePadding, vertical: 0),
            hintText: 'Enter family name',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFB76C52),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFB76C52),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        verticalGap(pagePadding),
        TextField(
          controller: familyDescCtrl,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: pagePadding, vertical: 0),
            hintText: 'Description',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFB76C52),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFB76C52),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        verticalGap(pagePadding),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xffFE3400),
                Color(0xffFBC108),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent, // Text color
              shadowColor: Colors.transparent, // No shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: apiCallProvider.status == ApiStatus.loading
                ? null
                : () async {
                    if (familyNameCtrl.text.isEmpty ||
                        familyDescCtrl.text.isEmpty) {
                      showToastMessageWithLogo(
                          'All fields are mandatory', context);
                      return;
                    }
                    Map<String, dynamic> reqBody = {
                      'leaderId': familyDetails?.leaderId,
                      'id': familyDetails?.id,
                      'familyName': familyNameCtrl.text,
                      'description': familyDescCtrl.text
                    };
                    if (_image != null) {
                      MultipartFile profileImage = await MultipartFile.fromFile(
                          _image!.path,
                          filename: basename(_image!.path));
                      reqBody['image'] = profileImage;
                    }
                    apiCallProvider
                        .postRequest(API.editFamily, reqBody)
                        .then((value) {
                      if (value['message'] != null) {
                        showToastMessageWithLogo(value['message'], context);
                        Navigator.pop(context);
                      }
                    });
                  },
            child: apiCallProvider.status == ApiStatus.loading
                ? const ButtonLoader()
                : const Text('Submit'),
          ),
        )
      ],
    );
  }
}
