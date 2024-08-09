import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/country_continent.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../services/location_service.dart';
import '../../../utils/generic_api_calls.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  static const String route = '/editProfile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nickNameCtrl = TextEditingController();
  final TextEditingController _birthdayCtrl = TextEditingController();
  final TextEditingController _genderCtrl = TextEditingController();
  final TextEditingController _bioCtrl = TextEditingController();
  final TextEditingController _countryCtrl =
      TextEditingController(text: 'India');
  bool isEmojiVisible = false;
  FocusNode focusNode = FocusNode();
  CountryContinent? countryContinent;
  late ApiCallProvider apiCallProvider;
  UserProfileDetail? user;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchLocationInfo();
    _nickNameCtrl.addListener(
      () {
        setState(() {});
      },
    );
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isEmojiVisible = false;
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  void loadUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
          _nickNameCtrl.text = user?.name ?? '';
          _birthdayCtrl.text = user?.dob ?? '';
          _genderCtrl.text = user?.gender ?? '';
          _bioCtrl.text = user?.bio ?? '';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () async {
              if (_nickNameCtrl.text.isEmpty ||
                  _birthdayCtrl.text.isEmpty ||
                  _genderCtrl.text.isEmpty ||
                  _bioCtrl.text.isEmpty ||
                  _countryCtrl.text.isEmpty) {
                showToastMessageWithLogo('All fields are mandatory', context);
                return;
              }

              Map<String, dynamic> reqBody = {
                'userId': user?.id,
                'name': _nickNameCtrl.text,
                'gender': _genderCtrl.text,
                'dob': _birthdayCtrl.text,
                'Country': _countryCtrl.text,
                'bio': _bioCtrl.text,
              };
              if (_image != null) {
                MultipartFile profileImage = await MultipartFile.fromFile(
                    _image!.path,
                    filename: basename(_image!.path));
                reqBody['image'] = profileImage;
              }
              apiCallProvider
                  .postRequest(API.updateUserProfile, reqBody)
                  .then((value) {
                if (apiCallProvider.status == ApiStatus.success) {
                  showToastMessageWithLogo('${value['message']}', context);
                  if (value['success'] == '1') {
                    Navigator.of(context).pop();
                  }
                } else {
                  showToastMessageWithLogo('Request failed', context);
                }
              });
            },
            child: apiCallProvider.status == ApiStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : const Text('Save'),
          ),
        ],
      ),
      body: WillPopScope(
        child: getBody(context),
        onWillPop: () {
          if (isEmojiVisible) {
            setState(() {
              isEmojiVisible = false;
            });
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
      ),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
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
            child: Container(
              margin: const EdgeInsets.all(pagePadding),
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
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
                      imagePath: user?.image ?? '',
                      diameter: 80,
                    ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            hintText('Nickname*'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: pagePadding),
              child: Text(
                '${_nickNameCtrl.text.length}/20',
                style: const TextStyle(
                  color: hintDarkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        verticalGap(10),
        TextField(
          controller: _nickNameCtrl,
          maxLength: 20,
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 20, bottom: 10, top: 15),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            counterText: '',
            suffixIcon: IconButton(
              onPressed: () {
                isEmojiVisible = !isEmojiVisible;
                focusNode.unfocus();
                focusNode.canRequestFocus = true;
                setState(() {});
              },
              icon: const Icon(
                Icons.emoji_emotions,
                color: Colors.black,
              ),
            ),
          ),
        ),
        verticalGap(10),
        hintText('Birthday'),
        verticalGap(10),
        TextField(
          controller: _birthdayCtrl,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, bottom: 10),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _selectDate(context);
          },
          readOnly: true,
        ),
        verticalGap(10),
        hintText('Gender'),
        verticalGap(10),
        TextField(
          controller: _genderCtrl,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, bottom: 10),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _selectGender(context);
          },
          readOnly: true,
        ),
        verticalGap(10),
        hintText('Bio'),
        verticalGap(10),
        TextField(
          controller: _bioCtrl,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, bottom: 10),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        verticalGap(10),
        hintText('Country'),
        verticalGap(10),
        TextField(
          controller: _countryCtrl,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, bottom: 10),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
          enabled: false,
        ),
        Offstage(
          offstage: !isEmojiVisible,
          child: SizedBox(
            height: 300,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                _nickNameCtrl.text = _nickNameCtrl.text + emoji.emoji;
              },
              onBackspacePressed: null,
              config: Config(
                height: 300,
                checkPlatformCompatibility: true,
                emojiViewConfig: EmojiViewConfig(
                  emojiSizeMax: 28 *
                      (defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.20
                          : 1.0),
                ),
                bottomActionBarConfig:
                    const BottomActionBarConfig(enabled: false),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _selectGender(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'Male',
                    groupValue: _genderCtrl.text,
                    onChanged: (String? value) {
                      setState(() {
                        _genderCtrl.text = value!;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text('Male'),
                  const Spacer(),
                  Radio<String>(
                    value: 'Female',
                    groupValue: _genderCtrl.text,
                    onChanged: (String? value) {
                      setState(() {
                        _genderCtrl.text = value!;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text('Female'),
                  horizontalGap(10)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateFormat dateFormat = DateFormat('yy/MM/dd');
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: '',
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF008577),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _birthdayCtrl.text = dateFormat.format(picked);
      });
    }
  }

  Padding hintText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: pagePadding),
      child: Text(
        text,
        style: const TextStyle(
          color: hintDarkColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void fetchLocationInfo() async {
    countryContinent = await LocationService().getCurrentLocation();
    log('Fetched user location');
    log('Country : ${countryContinent?.country}');
    log('continent : ${countryContinent?.continent}');
    log('LatLong : ${countryContinent?.position?.latitude},${countryContinent?.position?.longitude}');
  }
}
