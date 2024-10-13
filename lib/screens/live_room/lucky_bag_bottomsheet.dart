import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/live_room_user_model.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/joinable_live_room_model.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';

class LuckyBagBottomsheet extends StatefulWidget {
  const LuckyBagBottomsheet({
    Key? key,
    required this.roomDetail,
    required this.user,
    required this.participants,
  }) : super(key: key);
  final JoinableLiveRoomModel roomDetail;

  final UserProfileDetail? user;
  final List<LiveRoomUserModel> participants;

  @override
  State<LuckyBagBottomsheet> createState() => _LuckyBagBottomsheetState();
}

class _LuckyBagBottomsheetState extends State<LuckyBagBottomsheet> {
  late ApiCallProvider apiCallProvider;
  String frame = '';
  UserProfileDetail? otherUser;

  List<int> amountList = [90, 990, 2990];
  List<int> quantityList = [10, 15, 5];

  int selectedBagType = 0;
  int selectedCoin = 1;
  int selectedQuantity = 1;

  Map<int, Widget> bagTypeChildren = {
    0: const Text('Lucky Bag'),
    1: const Text('SuperLucky Bag'),
  };
  Map<int, Widget> coinChildren = {
    0: const Text('290'),
    1: const Text('990'),
    2: const Text('2990'),
  };
  Map<int, Widget> quantityChildren = {
    0: const Text('10'),
    1: const Text('15'),
    2: const Text('5'),
  };
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return FractionallySizedBox(
      heightFactor: 0.6, // Set height to 60% of screen height
      child: ClipRRect(
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(20),
        //   topRight: Radius.circular(20),
        // ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF9402FD),
                Color(0xFF9901F8),
                Color(0xFFA30FE9),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/image/gold_coins_im.png',
                width: 50,
              ),
              const Text(
                'Send a lucky bag',
                style: TextStyle(color: Colors.white),
              ),
              verticalGap(10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MaterialSegmentedControl(
                  children: bagTypeChildren,
                  selectionIndex: selectedBagType,
                  borderColor: Colors.grey,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.transparent,
                  selectedTextStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  unselectedTextStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  borderWidth: 0.7,
                  borderRadius: 10.0,
                  disabledChildren: [],
                  onSegmentTapped: (index) {
                    log('index = $index');
                    setState(() {
                      selectedBagType = index;
                    });
                  },
                ),
              ),
              verticalGap(20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * .1,
                      vertical: 10),
                  child: Text(
                    'Coins',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MaterialSegmentedControl(
                  children: coinChildren,
                  selectionIndex: selectedCoin,
                  borderColor: Colors.grey,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.transparent,
                  selectedTextStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  unselectedTextStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  borderWidth: 0.7,
                  borderRadius: 10.0,
                  disabledChildren: [],
                  onSegmentTapped: (index) {
                    log('index = $index');
                    setState(() {
                      selectedCoin = index;
                    });
                  },
                ),
              ),
              verticalGap(20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * .1,
                      vertical: 10),
                  child: Text(
                    'Quantity',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MaterialSegmentedControl(
                  children: quantityChildren,
                  selectionIndex: selectedQuantity,
                  borderColor: Colors.grey,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.transparent,
                  selectedTextStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  unselectedTextStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  borderWidth: 0.7,
                  borderRadius: 10.0,
                  disabledChildren: [],
                  onSegmentTapped: (index) {
                    log('index = $index');
                    setState(() {
                      selectedQuantity = index;
                    });
                  },
                ),
              ),
              verticalGap(20),
              InkWell(
                onTap: () {
                  createLuckyBag();
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Send',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * .1,
                      vertical: 10),
                  child: Text(
                    'Anyone who opens the lucky bag may get coins. Learn more.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createLuckyBag() async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'amount': amountList[selectedCoin],
      'liveId': widget.roomDetail.id,
    };
    await apiCallProvider
        .postRequest(API.createUserSuperLuckyBag, reqBody)
        .then((value) async {
      showToastMessage(value['message']);
    });
  }
}
