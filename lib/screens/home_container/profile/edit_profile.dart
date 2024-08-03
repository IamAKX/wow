import 'dart:ffi';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

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

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Save'),
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
            child: Image.asset('assets/dummy/demo_user_profile.png'),
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
                  // Issue: https://github.com/flutter/flutter/issues/28894
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
          title: Text('Select Gender'),
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
                  Text('Male'),
                  Spacer(),
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
                  Text('Female'),
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
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
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
}