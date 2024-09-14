import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/search_user_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/generic_api_calls.dart';

class InviteFamilyMember extends StatefulWidget {
  const InviteFamilyMember({super.key, required this.userProfileDetail});
  static const String route = '/inviteFamilyMember';
  final UserProfileDetail userProfileDetail;

  @override
  State<InviteFamilyMember> createState() => _InviteFamilyMemberState();
}

class _InviteFamilyMemberState extends State<InviteFamilyMember> {
  final TextEditingController searchCtrl = TextEditingController();
  late ApiCallProvider apiCallProvider;
  UserProfileDetail? user;
  List<SearchUserModel> searchList = [];

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

  void searchUsers(String searchString) {
    Map<String, dynamic> reqBody = {'search': searchString};
    apiCallProvider.postRequest(API.searchUsers, reqBody).then((value) {
      searchList.clear();
      showToastMessage(value['message']);
      if (value['details'] != null) {
        for (var item in value['details']) {
          searchList.add(SearchUserModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  void inviteUser(String userId, String familyId) {
    Map<String, dynamic> reqBody = {'userId': userId, 'familyId': familyId};
    apiCallProvider.postRequest(API.sendInvitation, reqBody).then((value) {
      showToastMessage(value['message']);
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Friend'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                  child: const Text('Search'),
                  onPressed: () {
                    if (searchCtrl.text.isNotEmpty) {
                      searchUsers(searchCtrl.text);
                    }
                  },
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0), // Rounded corners
                borderSide: const BorderSide(
                  color: Color(
                      0xFFCECECE), // Border color when the field is not focused
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: Color(
                      0xFFCECECE), // Border color when the field is enabled
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: Color(
                      0xFFCECECE), // Border color when the field is focused
                  width:
                      2.0, // Optional: increase the border width when focused
                ),
              ),
              filled: true,
              fillColor: const Color(0xFFCECECE),
            ),
          ),
        ),
        Expanded(
          child: apiCallProvider.status == ApiStatus.loading
              ? const DefaultPageLoader()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircularImage(
                          imagePath: searchList.elementAt(index).image ?? '',
                          diameter: 50),
                      title: Text(searchList.elementAt(index).name ?? ''),
                      trailing: InkWell(
                        onTap: () {
                          inviteUser(searchList.elementAt(index).id ?? '',
                              user?.familyId ?? '');
                        },
                        child: Container(
                          width: 90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff2F89D8),
                                Color(0xffEB0F93),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Text(
                            'Invite',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }
}
