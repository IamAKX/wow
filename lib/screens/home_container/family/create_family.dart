import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/button_loader.dart';

import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../widgets/gaps.dart';

class CreateFamily extends StatefulWidget {
  const CreateFamily({super.key});
  static const String route = '/createFamily';

  @override
  State<CreateFamily> createState() => _CreateFamilyState();
}

class _CreateFamilyState extends State<CreateFamily> {
  late ApiCallProvider apiCallProvider;
  final TextEditingController familyNameCtrl = TextEditingController();
  final TextEditingController familyDescCtrl = TextEditingController();
  UserProfileDetail? user;

  File? _image;
  final ImagePicker _picker = ImagePicker();

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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text('Create Family'),
          actions: [],
        ),
        body: getBody(context));
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
            setState(() {
              if (pickedFile != null) {
                _image = File(pickedFile.path);
              } else {
                log('No image selected.');
              }
            });
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
                : ClipOval(
                    child: Image.asset(
                      'assets/dummy/demo_user_profile.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
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
                        familyDescCtrl.text.isEmpty ||
                        _image == null) {
                      showToastMessageWithLogo(
                          'All fields are mandatory', context);
                      return;
                    }
                    Map<String, dynamic> reqBody = {
                      'userId': user?.id,
                      'familyName': familyNameCtrl.text,
                      'description': familyDescCtrl.text
                    };
                    MultipartFile profileImage = await MultipartFile.fromFile(
                        _image!.path,
                        filename: basename(_image!.path));
                    reqBody['image'] = profileImage;
                    apiCallProvider
                        .postRequest(API.createFamily, reqBody)
                        .then((value) {
                      if (value['message'] != null) {
                        showToastMessageWithLogo(value['message'], context);
                        Navigator.pop(context);
                      }
                    });
                  },
            child: apiCallProvider.status == ApiStatus.loading
                ? const ButtonLoader()
                : const Text('Save'),
          ),
        )
      ],
    );
  }
}
