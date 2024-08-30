// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/family_details.dart';
import 'package:worldsocialintegrationapp/models/family_id_model.dart';
import 'package:worldsocialintegrationapp/models/single_family_detail_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/edit_family.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_medal.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_member.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_rule.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/invitation_request.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/invite_family_member.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/generic_api_calls.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/categorized_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../widgets/default_page_loader.dart';
import '../../../widgets/framed_circular_image.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key, required this.familyIdModel});
  static const String route = '/familyScreen';
  final FamilyIdModel familyIdModel;

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  late ApiCallProvider apiCallProvider;
  FamilyDetails? familyDetails;
  UserProfileDetail? user;
  SingleFamilyDetailModel? singleFamilyDetailModel;
  int familyLevel = 0;

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
        await loadFamilyDeatilsData();
      },
    );
  }

  Future<void> loadFamilyDeatilsData() async {
    Map<String, dynamic> reqBody = {
      'userId': widget.familyIdModel.userId,
      'familyId': widget.familyIdModel.familyId
    };
    apiCallProvider.postRequest(API.getFamiliesDetails, reqBody).then((value) {
      if (value['details'] != null) {
        familyDetails = FamilyDetails.fromJson(value['details']);
        familyLevel = familyDetails?.familyLevel ?? 1;
        if (familyLevel == 0) familyLevel = 1;
        setState(() {});
        loadSingleFamilyDeatilsData('${familyLevel}');
      }
    });
  }

  Future<void> loadSingleFamilyDeatilsData(String type) async {
    Map<String, dynamic> reqBody = {'type': type};
    apiCallProvider
        .postRequest(API.getSingleFamilyDetails, reqBody)
        .then((value) {
      if (value['details'] != null && null != value['details'][0]) {
        singleFamilyDetailModel =
            SingleFamilyDetailModel.fromJson(value['details'][0]);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: apiCallProvider.status == ApiStatus.loading
          ? const DefaultPageLoader()
          // : familyDetails == null
          //     ? Center(
          //         child: Text('details not found!'),
          //       )
          : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(singleFamilyDetailModel
                          ?.exclusiveBackground ??
                      'https://images.pexels.com/photos/66869/green-leaf-natural-wallpaper-royalty-free-66869.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: getHeader(context),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: getCenterWidget(context),
              ),
            ),
            Visibility(
              visible: widget.familyIdModel.userId == user?.id &&
                  user?.id == familyDetails?.leaderId,
              child: Container(
                margin: const EdgeInsets.all(pagePadding),
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
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(InviteFamilyMember.route, arguments: user);
                  },
                  child: const Text('Invite'),
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: 100,
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xFF5E2694),
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                Visibility(
                  visible: widget.familyIdModel.userId == user?.id &&
                      familyDetails?.family?.leaderId != user?.id,
                  child: IconButton(
                    onPressed: () {
                      showLeaveFamilyPopup(context);
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.familyIdModel.userId == user?.id &&
                      familyDetails?.family?.leaderId == user?.id,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(EditFamily.route).then(
                        (value) {
                          loadFamilyDeatilsData();
                        },
                      );
                    },
                    icon: SvgPicture.asset(
                      'assets/svg/edit__2___1_.svg',
                      width: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(FamilyRule.route);
                  },
                  icon: SvgPicture.asset(
                    'assets/svg/question.svg',
                    width: 20,
                    color: Colors.white,
                  ),
                ),
                Visibility(
                  visible: widget.familyIdModel.userId == user?.id &&
                      familyDetails?.family?.leaderId == user?.id,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(InvitationRequestScreen.route,
                                arguments: familyDetails)
                            .then(
                          (value) {
                            loadFamilyDeatilsData();
                          },
                        );
                      },
                      icon: Badge(
                        isLabelVisible: (familyDetails?.requestCount ?? 0) > 0,
                        label: Text('${familyDetails?.requestCount ?? 0}'),
                        offset: const Offset(0, -10),
                        backgroundColor: Colors.red,
                        child: Image.asset(
                          'assets/image/invitation.png',
                          width: 20,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 270,
          right: 20,
          child: SizedBox(
            width: 60,
            height: 60,
            child: singleFamilyDetailModel == null
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(FamilyMedalScreen.route);
                    },
                    child: CachedNetworkImage(
                      imageUrl: singleFamilyDetailModel?.rankMedal ?? '',
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Text('Error ${error.toString()}'),
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
          ),
        )
      ],
    );
  }

  getHeader(BuildContext context) {
    return Column(
      children: [
        verticalGap(30),
        Align(
          alignment: Alignment.center,
          child: FramedCircularImage(
              imagePath: familyDetails?.image ?? '',
              imageSize: 55,
              framePath: 'assets/image/badge.png',
              frameSize: 100),
        ),
        verticalGap(5),
        Text(
          '${familyDetails?.familyName}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'ID: ${familyDetails?.uniqueId}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalGap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$familyLevel',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            horizontalGap(10),
            Container(
              width: 200,
              child: LinearProgressIndicator(
                value: (familyDetails?.totalContribution ?? 1) /
                    (familyDetails?.totalExp ?? 1),
                color: const Color(0xFFF9BF02),
                minHeight: 5,
                backgroundColor: const Color(0xFFF9BF02).withOpacity(0.4),
              ),
            ),
            horizontalGap(10),
            Text(
              '${familyLevel + 1}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
        verticalGap(5),
        Text(
          '${familyDetails?.totalContribution}/${familyDetails?.totalExp}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        )
      ],
    );
  }

  getCenterWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(pagePadding),
      children: [
        const Text(
          'Family Notice',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalGap(5),
        Text(
          familyDetails?.description ?? '',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB73E25)),
        ),
        verticalGap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Family Members ${familyDetails?.family?.members}/300',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FamilyMemberScreen.route);
              },
              icon: const Icon(
                Icons.chevron_right,
                color: hintColor,
              ),
            )
          ],
        ),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: getFamilyMembers(),
          ),
        ),
        verticalGap(20),
        const Text(
          'Family Rooms',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalGap(10),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage('${familyDetails?.family?.image}'),
                  fit: BoxFit.cover),
            ),
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  margin: const EdgeInsets.all(pagePadding / 2),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffFE3400),
                        Color(0xffFBC108),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: const Text(
                    'Any',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                const Spacer(),
                Image.asset(
                  'assets/image/increasing_bar.png',
                  width: 20,
                ),
                horizontalGap(5),
                SvgPicture.asset(
                  'assets/svg/user.svg',
                  width: 18,
                ),
                horizontalGap(5),
                Text(
                  '${familyDetails?.family?.members}',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                horizontalGap(10),
              ],
            ),
          ),
        )
      ],
    );
  }

  getFamilyMembers() {
    List<Widget> familyMember = [];
    List<String> joinerId = familyDetails?.joiner
            ?.map(
              (item) => item.userId ?? '',
            )
            .toList() ??
        [];

    for (AllMembers members in familyDetails?.allMembers ?? []) {
      if (members.isFamilyLeader == '1' || members.isAdmin == '1') {
        familyMember.add(
          InkWell(
            onTap: () => null,
            child: CategorizedCircularImage(
                imagePath: members.userProfileImage ?? '',
                imageSize: 50,
                categoryPath: members.isFamilyLeader == '1'
                    ? 'assets/image/leaderimage.png'
                    : 'assets/image/joinericon.png'),
          ),
        );
      } else {
        familyMember.add(
          InkWell(
            onTap: () => showBottomSheet(
                context, members.userId ?? '', members.isAdmin ?? ''),
            child: CircularImage(
              imagePath: members.userProfileImage ?? '',
              diameter: 50,
            ),
          ),
        );
      }
      familyMember.add(horizontalGap(pagePadding));
    }
    return familyMember;
  }

  void showBottomSheet(
      BuildContext context, String secondaryUserId, String isAdmin) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap:
                    apiCallProvider.status == ApiStatus.loading ? null : () {},
              ),
              if (widget.familyIdModel.userId == user?.id)
                ListTile(
                  leading: Icon(Icons.admin_panel_settings),
                  title: Text(isAdmin == '0' ? 'Set Admin' : 'Remove Admin'),
                  onTap: apiCallProvider.status == ApiStatus.loading
                      ? null
                      : () async {
                          await familyRemoveAdmin(
                              '2', secondaryUserId, isAdmin);
                        },
                ),
              if (widget.familyIdModel.userId == user?.id)
                ListTile(
                  leading: Icon(Icons.remove_circle),
                  title: Text('Kick Out of Family'),
                  onTap: apiCallProvider.status == ApiStatus.loading
                      ? null
                      : () async {
                          await familyRemoveAdmin(
                              '1', secondaryUserId, isAdmin);
                        },
                ),
            ],
          ),
        );
      },
    );
  }

  void showLeaveFamilyPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert!'),
          content: const Text('Are you sure you want to leave this family?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                Map<String, dynamic> reqBody = {
                  'userId': '${user?.id}',
                  'familyId': '${familyDetails?.id}'
                };
                await apiCallProvider
                    .postRequest(API.leavefamilyGroup, reqBody)
                    .then((value) {
                  if (value['message'] != null) {
                    showToastMessage(value['message']);
                    Navigator.pop(context);
                  }
                });
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> familyRemoveAdmin(
      String type, String secondaryUserId, String isAdmin) async {
    Map<String, dynamic> reqBody = {
      'type': type,
      'familyId': familyDetails?.id,
      'otherUserId': secondaryUserId,
      'userId': user?.id,
      'is_admin': isAdmin
    };
    await apiCallProvider
        .postRequest(API.familyAdminRemove, reqBody)
        .then((value) async {
      if (value['message'] != null) {
        showToastMessage(value['message']);
        Navigator.pop(context);
        await loadFamilyDeatilsData();
      }
    });
  }
}
