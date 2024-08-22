// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/family_details.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/edit_family.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_member.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/prompt_create_family.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/generic_api_calls.dart';
import 'package:worldsocialintegrationapp/widgets/categorized_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../widgets/default_page_loader.dart';
import '../../../widgets/framed_circular_image.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});
  static const String route = '/familyScreen';

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  late ApiCallProvider apiCallProvider;
  FamilyDetails? familyDetails;
  UserProfileDetail? user;

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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body:
          familyDetails == null ? const DefaultPageLoader() : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/66869/green-leaf-natural-wallpaper-royalty-free-66869.jpeg'),
                  fit: BoxFit.cover,
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
            Container(
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
                      .pushNamed(PromptCreateFamily.route, arguments: user);
                },
                child: const Text('Invite'),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: 100,
            child: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditFamily.route).then(
                      (value) {
                        loadFamilyDeatilsData(
                            user?.id ?? '', user?.familyId ?? '');
                      },
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/svg/edit__2___1_.svg',
                    width: 25,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/svg/question.svg',
                    width: 20,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/image/invitation.png',
                    width: 20,
                    color: Colors.white,
                  ),
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
            child: Image.asset(
              'assets/image/monster.png',
              fit: BoxFit.cover,
              width: 60,
            ),
          ),
        )
      ],
    );
  }

  getHeader(BuildContext context) {
    return Column(
      children: [
        verticalGap(90),
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
            const Text(
              '2',
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
                value: 0.4,
                color: const Color(0xFFF9BF02),
                minHeight: 5,
                backgroundColor: const Color(0xFFF9BF02).withOpacity(0.4),
              ),
            ),
            horizontalGap(10),
            const Text(
              '3',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
        verticalGap(5),
        const Text(
          '1352773/9999999',
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
      if (members.isFamilyLeader == '1' || joinerId.contains(members.userId)) {
        familyMember.add(
          CategorizedCircularImage(
              imagePath: members.userProfileImage ?? '',
              imageSize: 50,
              categoryPath: members.isFamilyLeader == '1'
                  ? 'assets/image/lion.png'
                  : 'assets/image/joinericon.png'),
        );
      } else {
        familyMember.add(
          CircularImage(
            imagePath: members.userProfileImage ?? '',
            diameter: 50,
          ),
        );
      }
      familyMember.add(horizontalGap(pagePadding));
    }
    return familyMember;
  }
}
