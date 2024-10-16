import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/family_id_model.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_leaderboard.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/friends/friend_fans_following.dart';
import 'package:worldsocialintegrationapp/screens/home_container/friends/friend_navigator_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/friends/visitor_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/mall/mall.dart';
import 'package:worldsocialintegrationapp/screens/home_container/my_look/my_look_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/profile_detail_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/settings_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/user_level.dart';
import 'package:worldsocialintegrationapp/screens/income/income_Screen.dart';
import 'package:worldsocialintegrationapp/screens/income/income_screen_choice.dart';
import 'package:worldsocialintegrationapp/screens/recharge/recharge.dart';
import 'package:worldsocialintegrationapp/screens/vip/vip_screen.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/generic_api_calls.dart';
import 'package:worldsocialintegrationapp/widgets/animated_framed_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../main.dart';
import '../../../models/family_details.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/prefs_key.dart';
import '../../../widgets/custom_webview.dart';
import '../family/family_medal.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfileDetail? user;
  String frame = '';
  FamilyDetails? familyDetails;
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
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
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFE3400),
                Color(0xffFBC108),
              ],
            ),
          ),
        ),
        getProfileHeader(),
        Container(
          margin: const EdgeInsets.only(top: 180),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(pagePadding),
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(VisitorScreen.route)
                            .then(
                              (value) => loadUserData(),
                            );
                      },
                      child: getProfileMetric(
                          'Visitors', '${user?.visitorsCount ?? 0}'),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(
                              FriendFansFollowing.route,
                              arguments: FriendNavigatorModel(
                                  index: 0, userId: user?.id ?? ''),
                            )
                            .then(
                              (value) => loadUserData(),
                            );
                      },
                      child: getProfileMetric(
                          'Friends', '${user?.friendsCount ?? 0}'),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(
                                FriendFansFollowing.route,
                                arguments: FriendNavigatorModel(
                                    index: 1, userId: user?.id ?? ''),
                              )
                              .then(
                                (value) => loadUserData(),
                              );
                        },
                        child: getProfileMetric(
                            'Following', '${user?.followingCount ?? 0}')),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(
                              FriendFansFollowing.route,
                              arguments: FriendNavigatorModel(
                                  index: 2, userId: user?.id ?? ''),
                            )
                            .then(
                              (value) => loadUserData(),
                            );
                      },
                      child: getProfileMetric(
                          'Fan', '${user?.followersCount ?? 0}'),
                    ),
                  ),
                ],
              ),
              verticalGap(pagePadding * 2),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/rechargecoins.svg',
                  width: 20,
                ),
                title: const Text(
                  'Recharge',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${user?.myCoin ?? '0'}',
                      style: TextStyle(fontSize: 12),
                    ),
                    horizontalGap(5),
                    Image.asset(
                      'assets/image/coins_img.png',
                      width: 16,
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RechargeScreen.route)
                      .then(
                    (value) {
                      loadUserData();
                    },
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/income.svg',
                  width: 20,
                ),
                title: const Text(
                  'Income',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${user?.myDiamond ?? ''}',
                      style: TextStyle(fontSize: 12),
                    ),
                    horizontalGap(5),
                    Image.asset(
                      'assets/image/diamond.png',
                      width: 14,
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(IncomeChoiceScreen.route)
                      .then(
                    (value) {
                      loadUserData();
                    },
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/userlevel.svg',
                  width: 20,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if ((user?.lavelInfomation?.sendLevel ?? '0') != '0')
                      Container(
                        width: 50,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(
                                user?.lavelInfomation?.sandBgImage ?? '',
                              ),
                              fit: BoxFit.fill),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/image/starlevel.png',
                              width: 12,
                            ),
                            horizontalGap(5),
                            Text(
                              '${user?.lavelInfomation?.sendLevel}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    horizontalGap(5),
                    if ((user?.lavelInfomation?.reciveLevel ?? '0') != '0')
                      Container(
                        width: 50,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(
                                user?.lavelInfomation?.reciveBgImage ?? '',
                              ),
                              fit: BoxFit.fill),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/image/coins_img.png',
                              width: 12,
                            ),
                            horizontalGap(5),
                            Text(
                              '${user?.lavelInfomation?.reciveLevel}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
                title: const Text(
                  'User Level',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(UserLevelScreen.route);
                },
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                indent: 50,
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/vip_1.svg',
                  width: 20,
                ),
                title: const Text(
                  'VIP Center',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Chip(
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  backgroundColor: Color(0xFFD5C09B),
                  label: Text(
                    'Daily Reward',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF645948),
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(VipScreen.route);
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/badges.svg',
                  width: 20,
                ),
                title: const Text(
                  'Badge',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {
                  // Navigator.of(context, rootNavigator: true)
                  //     .pushNamed(FamilyMedalScreen.route);
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/mall.svg',
                  width: 20,
                ),
                title: const Text(
                  'Mall',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(MallScreen.route);
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/mylook.svg',
                  width: 20,
                ),
                title: const Text(
                  'My Look',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(
                        MyLookScreen.route,
                      )
                      .then(
                        (value) => loadUserData(),
                      );
                },
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                indent: 50,
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/family.svg',
                  width: 20,
                ),
                trailing: Visibility(
                  visible: (((familyDetails?.admin ?? false) ||
                              familyDetails?.family?.leaderId == user?.id) &&
                          (familyDetails?.totalCount ?? 0) > 0) ||
                      (!((user?.familyJoinStatus) ?? true) &&
                          ((familyDetails?.invitationCount ?? 0) > 0)),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      ((familyDetails?.admin ?? false) ||
                              familyDetails?.family?.leaderId == user?.id)
                          ? '${familyDetails?.totalCount ?? 0}'
                          : '${familyDetails?.invitationCount ?? 0}',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                title: const Text(
                  'Family',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  if (user == null) {
                    return;
                  }
                  if (user?.familyJoinStatus ?? false) {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(FamilyScreen.route,
                            arguments: FamilyIdModel(
                                userId: user?.id, familyId: user?.familyId))
                        .then(
                      (value) {
                        loadUserData();
                      },
                    );
                  } else {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(FamilyLeaderboard.route)
                        .then(
                      (value) {
                        loadUserData();
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/image/onlineServices.png',
                  color: Colors.orange,
                  width: 20,
                ),
                title: const Text(
                  'Online Services',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                // onTap: () =>
                //     Navigator.of(context, rootNavigator: true).pushNamed(
                //   CustomWebview.route,
                //   // arguments: 'https://www5.lunapic.com/editor/?action=convert'
                //   arguments:
                //       'https://xrdsimulators.tech/wow_project/index.php/UserSender?id=${user?.id}&name=${user?.name}',
                // ),
                onTap: () {
                  _openNativeWebView(
                      'https://xrdsimulators.tech/wow_project/index.php/UserSender?id=${user?.id}&name=${user?.name}');
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/image/settings.png',
                  width: 20,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(SettingsScreen.route);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getProfileMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalGap(5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  SizedBox getProfileHeader() {
    log('user name : ${user?.name}');
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Row(
        children: [
          horizontalGap(pagePadding),
          frame.isEmpty
              ? CircularImage(imagePath: user?.image ?? '', diameter: 60)
              : AnimatedFramedCircularImage(
                  imagePath: user?.image ?? '',
                  imageSize: 60,
                  framePath: frame),
          horizontalGap(pagePadding),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.name ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              verticalGap(5),
              Text(
                'ID: ${user?.username}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(ProfileDeatilScreen.route)
                  .then(
                (value) {
                  loadUserData();
                },
              );
            },
            icon: const Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadFamilyDeatilsData() async {
    Map<String, dynamic> reqBody = {
      'userId': user?.id,
      'familyId': user?.familyId
    };
    apiCallProvider.postRequest(API.getFamiliesDetails, reqBody).then((value) {
      if (value['details'] != null) {
        familyDetails = FamilyDetails.fromJson(value['details']);

        setState(() {});
      }
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
    loadFamilyDeatilsData();
    frame = await loadFrame();
    setState(() {});

    log('frame = ${frame}');
  }

  static const platform = MethodChannel('com.example.webview/native');
  Future<void> _openNativeWebView(String url) async {
    try {
      await platform.invokeMethod('openWebView', {'url': url});
    } on PlatformException catch (e) {
      print("Failed to open WebView: '${e.message}'.");
    }
  }
}
