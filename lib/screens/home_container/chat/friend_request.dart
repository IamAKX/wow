import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/services/firebase_db_service.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';

import '../../../main.dart';
import '../../../models/firebase_user.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../widgets/circular_image.dart';
import '../../../widgets/gaps.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({super.key});
  static const String route = '/friendRequest';

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  List<FirebaseUserModel> list = [];
  late ApiCallProvider apiCallProvider;
  UserProfileDetail? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadRequests();
      loadSelfUserData();
    });
  }

  loadRequests() async {
    await FirebaseDbService.getFriendRequestList(
            prefs.getString(PrefsKey.userId) ?? '')
        .then((value) {
      setState(() {
        list = value;
      });
    });
  }

  void loadSelfUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Request'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return list.isEmpty
        ? const Center(
            child: Text('No Request Found'),
          )
        : ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  leading: CircularImage(
                      imagePath: list.elementAt(index).image ?? '',
                      diameter: 40),
                  title: Text(
                    list.elementAt(index).name ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () async {
                          FirebaseUserModel firebaseUserModel =
                              FirebaseUserModel(
                                  image: user?.image,
                                  name: user?.name,
                                  userId: user?.id,
                                  userName: user?.name);
                          FirebaseDbService.acceptFriendRequest(
                                  firebaseUserModel, list.elementAt(index))
                              .then(
                            (value) {
                              loadRequests();
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            'Accept',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      horizontalGap(10),
                      InkWell(
                        onTap: () async {
                          FirebaseUserModel firebaseUserModel =
                              FirebaseUserModel(
                                  image: user?.image,
                                  name: user?.name,
                                  userId: user?.id,
                                  userName: user?.name);
                          FirebaseDbService.rejectFriendRequest(
                                  firebaseUserModel, list.elementAt(index))
                              .then(
                            (value) {
                              loadRequests();
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            'Reject',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => const Divider(
                  color: hintColor,
                ),
            itemCount: list.length);
  }
}
