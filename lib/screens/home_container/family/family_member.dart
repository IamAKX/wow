import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/widgets/categorized_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';

import '../../../models/family_details.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../widgets/default_page_loader.dart';
import '../../../widgets/gaps.dart';

class FamilyMemberScreen extends StatefulWidget {
  const FamilyMemberScreen({super.key});
  static const String route = '/familyMemberScreen';

  @override
  State<FamilyMemberScreen> createState() => _FamilyMemberScreenState();
}

class _FamilyMemberScreenState extends State<FamilyMemberScreen> {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Members'),
          actions: [],
        ),
        body: familyDetails == null
            ? const DefaultPageLoader()
            : getBody(context));
  }

  getBody(BuildContext context) {
    List<String> joinerId = familyDetails?.joiner
            ?.map(
              (item) => item.userId ?? '',
            )
            .toList() ??
        [];

    return ListView.builder(
      itemCount: familyDetails?.allMembers?.length ?? 0,
      itemBuilder: (context, index) {
        AllMembers? member = familyDetails?.allMembers?.elementAt(index);
        return ListTile(
          leading: member?.isFamilyLeader == '1'
              ? CategorizedCircularImage(
                  imagePath: member?.userProfileImage ?? '',
                  imageSize: 50,
                  categoryPath: 'assets/image/lion.png')
              : CircularImage(
                  imagePath: member?.userProfileImage ?? '',
                  diameter: 50,
                ),
          title: Text(
            '${member?.name}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Container(
            width: 60,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/family_points_border.png'),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '0',
                  style: TextStyle(fontSize: 10),
                ),
                horizontalGap(2),
                Image.asset(
                  'assets/image/fire.png',
                  width: 9,
                )
              ],
            ),
          ),
          subtitle: Row(
            children: [
              if (joinerId.contains(member?.userId)) ...{
                Image.asset(
                  'assets/image/joinericon.png',
                  width: 20,
                ),
                horizontalGap(5),
              },
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: const BoxDecoration(
                    color: Color(0xFF0FDEA5),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      member?.gender?.toLowerCase() == 'male'
                          ? Icons.male
                          : Icons.female,
                      color: Colors.white,
                      size: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(10),
              Container(
                constraints: const BoxConstraints(minWidth: 50),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/image/level_1.png',
                      ),
                      fit: BoxFit.fill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/image/coins_img.png',
                      width: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(5),
              Container(
                constraints: const BoxConstraints(minWidth: 50),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/image/level_9.png',
                      ),
                      fit: BoxFit.fill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/image/coins_img.png',
                      width: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
