import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/prompt_create_family.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';
import 'package:worldsocialintegrationapp/widgets/framed_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/family_details.dart';
import '../../../models/family_id_model.dart';
import '../../../models/family_leaderboard_member.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/generic_api_calls.dart';
import 'family_screen.dart';
import 'invitation_request.dart';

class FamilyLeaderboard extends StatefulWidget {
  const FamilyLeaderboard({super.key});
  static const String route = '/familyLeaderboard';

  @override
  State<FamilyLeaderboard> createState() => _FamilyLeaderboardState();
}

class _FamilyLeaderboardState extends State<FamilyLeaderboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ApiCallProvider apiCallProvider;
  List<FamilyLeaderboardMember> list = [];
  UserProfileDetail? user;
  FamilyDetails? familyDetails;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(
      () {
        loadFamilyLeaderboard(_tabController.index + 1);
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
      loadFamilyLeaderboard(1);
    });
  }

  void loadUserData() async {
    await getCurrentUser().then(
      (value) async {
        user = value;
        setState(() {});
        await loadFamilyDeatilsData(value?.id ?? '', value?.familyId ?? '');
      },
    );
  }

  Future<void> loadFamilyDeatilsData(String userId, String familyId) async {
    Map<String, dynamic> reqBody = {'userId': userId, 'familyId': familyId};
    apiCallProvider.postRequest(API.getFamiliesDetails, reqBody).then((value) {
      if (value['details'] != null) {
        familyDetails = FamilyDetails.fromJson(value['details']);
        familyDetails ??= FamilyDetails();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Family',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(InvitationRequestScreen.route,
                        arguments: familyDetails)
                    .then(
                  (value) {
                    loadFamilyDeatilsData(user?.id ?? '', user?.familyId ?? '');
                  },
                );
              },
              icon: Badge(
                isLabelVisible: (familyDetails?.totalCount ?? 0) > 0,
                label: Text('${familyDetails?.totalCount ?? 0}'),
                offset: const Offset(0, -10),
                backgroundColor: Colors.red,
                child: Image.asset(
                  'assets/image/invitation.png',
                  width: 20,
                  color: Colors.white,
                ),
              )),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: Color(0xFFA9945A),
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            insets: EdgeInsets.symmetric(horizontal: 50.0),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          indicatorColor: const Color(0xFFA9945A),
          indicatorPadding: const EdgeInsets.only(bottom: 10),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA9945A),
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFFCAB69B),
          ),
          tabs: const [
            Tab(
              text: 'NEW',
            ),
            Tab(
              text: 'WEEKLY',
            ),
            Tab(
              text: 'MONTHLY',
            ),
          ],
        ),
      ),
      body: apiCallProvider.status == ApiStatus.loading
          ? const DefaultPageLoader(
              progressColor: Colors.amber,
            )
          : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(FamilyScreen.route,
                                arguments: FamilyIdModel(
                                    userId: list.elementAt(1).leaderId,
                                    familyId: list.elementAt(1).id))
                            .then(
                          (value) {
                            loadUserData();
                            loadFamilyLeaderboard(1);
                          },
                        );
                      },
                      child: getFamilyProfile(
                        list.elementAt(1).image ?? '',
                        list.elementAt(1).familyName ?? '',
                        list.elementAt(1).total ?? '',
                        '2',
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(FamilyScreen.route,
                                arguments: FamilyIdModel(
                                    userId: list.elementAt(0).leaderId,
                                    familyId: list.elementAt(0).id))
                            .then(
                          (value) {
                            loadUserData();
                            loadFamilyLeaderboard(1);
                          },
                        );
                      },
                      child: getFamilyProfile(
                        list.elementAt(0).image ?? '',
                        list.elementAt(0).familyName ?? '',
                        list.elementAt(0).total ?? '',
                        '1',
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(FamilyScreen.route,
                                arguments: FamilyIdModel(
                                    userId: list.elementAt(2).leaderId,
                                    familyId: list.elementAt(2).id))
                            .then(
                          (value) {
                            loadUserData();
                            loadFamilyLeaderboard(1);
                          },
                        );
                      },
                      child: getFamilyProfile(
                        list.elementAt(2).image ?? '',
                        list.elementAt(2).familyName ?? '',
                        list.elementAt(2).total ?? '',
                        '3',
                      ),
                    ),
                  )
                ],
              ),
              for (int i = 3; i < list.length; i++) ...{
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Color(0xFFB7945C),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      horizontalGap(20),
                      BorderedCircularImage(
                          imagePath: list.elementAt(i).image ?? '',
                          diameter: 50,
                          borderColor: const Color(0xFFB7945C),
                          borderThickness: 2)
                    ],
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          list.elementAt(i).familyName ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      horizontalGap(10),
                      Image.asset(
                        'assets/image/levelbadge.jpeg',
                        width: 18,
                      )
                    ],
                  ),
                  subtitle: Text(
                    list.elementAt(i).description ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(FamilyScreen.route,
                            arguments: FamilyIdModel(
                                userId: list.elementAt(i).leaderId,
                                familyId: list.elementAt(i).id))
                        .then(
                      (value) {
                        loadUserData();
                        loadFamilyLeaderboard(1);
                      },
                    );
                  },
                  trailing: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/image/family_points_border.png'),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          list.elementAt(i).total ?? '',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                        horizontalGap(2),
                        Image.asset(
                          'assets/image/fire.png',
                          width: 9,
                        )
                      ],
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
        user == null
            ? Container(
                margin: const EdgeInsets.all(pagePadding / 2),
                child: const DefaultPageLoader(
                  progressColor: Color(0xFFB7945C),
                ),
              )
            : (user?.familyJoinStatus ?? false)
                ? Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(pagePadding / 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFB7945C),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      leading: BorderedCircularImage(
                          imagePath: user?.familyImage ?? '',
                          diameter: 50,
                          borderColor: const Color(0xFFB7945C),
                          borderThickness: 2),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(FamilyScreen.route,
                                arguments: FamilyIdModel(
                                    userId: user?.id, familyId: user?.familyId))
                            .then(
                          (value) {
                            loadUserData();
                            loadFamilyLeaderboard(1);
                          },
                        );
                      },
                      title: Row(
                        children: [
                          Text(
                            user?.familyName ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          horizontalGap(10),
                          Image.asset(
                            'assets/image/levelbadge.jpeg',
                            width: 18,
                          )
                        ],
                      ),
                      subtitle: const Text(
                        'zzzz',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Container(
                        width: 60,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/image/family_points_border.png'),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/image/fire.png',
                          width: 9,
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.all(pagePadding),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                            PromptCreateFamily.route,
                            arguments: user);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF5B4420),
                        backgroundColor: const Color(0xFFBD9A60),
                      ),
                      child: const Text(
                        'Create a Family',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
      ],
    );
  }

  getFamilyProfile(String image, String name, String count, String rank) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 250,
      child: Stack(
        children: [
          Positioned(
            top: rank == '1' ? 40 : 50,
            child: Image.asset(
              'assets/image/family_bg_1.png',
              width: (MediaQuery.of(context).size.width - 60) / 3,
              height: 200,
            ),
          ),
          FramedCircularImage(
              imagePath: image,
              imageSize: 40,
              framePath: getFrameByRank(rank),
              frameSize: 110),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 60) / 3,
            child: Column(
              children: [
                verticalGap(rank == '1' ? 110 : 120),
                Image.asset(
                  'assets/image/top$rank.png',
                  width: 50,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(getNameBorderByRank(rank)),
                        fit: BoxFit.fill),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      horizontalGap(2),
                      Image.asset(
                        'assets/image/fire.png',
                        width: 14,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  width: 80,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/image/family_points_border.png'),
                        fit: BoxFit.fill),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        count,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      horizontalGap(2),
                      Image.asset(
                        'assets/image/fire.png',
                        width: 14,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getFrameByRank(String rank) {
    switch (rank) {
      case '1':
        return 'assets/image/family_badge_top1.png';
      case '2':
        return 'assets/image/family_badge_2.png';
      case '3':
        return 'assets/image/family_badge_3.png';
      default:
        return 'assets/image/family_badge_top1.png';
    }
  }

  String getNameBorderByRank(String rank) {
    switch (rank) {
      case '1':
        return 'assets/image/family1_name_border.png';
      case '2':
        return 'assets/image/family2_name_border.png';
      case '3':
        return 'assets/image/family3_name_border.png';
      default:
        return 'assets/image/family1_name_border.png';
    }
  }

  void loadFamilyLeaderboard(int i) async {
    Map<String, dynamic> reqBody = {'type': i};
    await apiCallProvider.postRequest(API.getTopGifter, reqBody).then((value) {
      list.clear();
      if (value['details'] != null) {
        for (var element in value['details']) {
          list.add(FamilyLeaderboardMember.fromJson(element));
        }
      }
      setState(() {});
      loadUserData();
    });
  }
}
