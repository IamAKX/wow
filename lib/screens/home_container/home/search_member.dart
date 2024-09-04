import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../user_detail_screen.dart/other_user_detail_screen.dart';

class SearchMember extends StatefulWidget {
  const SearchMember({
    super.key,
  });
  static const String route = '/searchMember';

  @override
  State<SearchMember> createState() => _SearchMemberState();
}

class _SearchMemberState extends State<SearchMember> {
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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.redAccent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
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
                      onTap: () => Navigator.of(context).pushNamed(
                          OtherUserDeatilScreen.route,
                          arguments: searchList.elementAt(index).id),
                      leading: CircularImage(
                          imagePath: searchList.elementAt(index).image ?? '',
                          diameter: 50),
                      title: Text(searchList.elementAt(index).name ?? ''),
                    );
                  },
                ),
        )
      ],
    );
  }
}
