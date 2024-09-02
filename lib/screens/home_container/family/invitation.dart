import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/family_details.dart';
import 'package:worldsocialintegrationapp/models/family_invite_request.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/helpers.dart';
import '../../../widgets/circular_image.dart';
import '../../../widgets/default_page_loader.dart';
import '../../../widgets/gaps.dart';

class Invitation extends StatefulWidget {
  const Invitation({super.key, required this.familyDetails});
  final FamilyDetails familyDetails;

  @override
  State<Invitation> createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {
  late ApiCallProvider apiCallProvider;

  List<FamilyInviteRequest> list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadRequests();
    });
  }

  loadRequests() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};

    apiCallProvider.postRequest(API.getInvitations, reqBody).then((value) {
      if (value['details'] != null) {
        list.clear();
        for (var item in value['details']) {
          list.add(FamilyInviteRequest.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return apiCallProvider.status == ApiStatus.loading
        ? const DefaultPageLoader()
        : list.isEmpty
            ? const Center(
                child: Text(
                  'No Request Found',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircularImage(
                      imagePath: list.elementAt(index).image ?? '',
                      diameter: 50,
                    ),
                    title: Text(
                      '${list.elementAt(index).familyName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () async {
                            await respondToInviteRequest(
                                list.elementAt(index).id, '2');
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
                            await respondToInviteRequest(
                                list.elementAt(index).id, '3');
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
                  );
                },
              );
  }

  respondToInviteRequest(String? id, String status) async {
    Map<String, dynamic> reqBody = {
      'requestId': id,
      'userId': prefs.getString(PrefsKey.userId),
      'status': status
    };
    await apiCallProvider
        .postRequest(API.responseInvitation, reqBody)
        .then((value) async {
      if (value['message'] != null) {
        showToastMessage(value['message']);
        await loadRequests();
      }
    });
  }
}
