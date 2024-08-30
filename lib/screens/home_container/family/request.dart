import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/family_join_request.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/family_details.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/helpers.dart';
import '../../../widgets/circular_image.dart';

class Request extends StatefulWidget {
  const Request({super.key, required this.familyDetails});
  final FamilyDetails familyDetails;

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  late ApiCallProvider apiCallProvider;
  List<FamilyJoinRequest> list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadRequests();
    });
  }

  loadRequests() async {
    Map<String, dynamic> reqBody = {'leaderId': widget.familyDetails.leaderId};

    apiCallProvider.postRequest(API.getJoinRequest, reqBody).then((value) {
      if (value['details'] != null) {
        list.clear();
        for (var item in value['details']) {
          list.add(FamilyJoinRequest.fromJson(item));
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
                      imagePath: list.elementAt(index).imageDp ?? '',
                      diameter: 50,
                    ),
                    title: Text(
                      '${list.elementAt(index).name}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () async {
                            await respondToJoinRequest(
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
                            await respondToJoinRequest(
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

  respondToJoinRequest(String? id, String status) async {
    Map<String, dynamic> reqBody = {
      'requestId': id,
      'userId': prefs.getString(PrefsKey.userId),
      'status': status
    };
    await apiCallProvider
        .postRequest(API.responseJoinRequest, reqBody)
        .then((value) async {
      if (value['message'] != null) {
        showToastMessage(value['message']);
        await loadRequests();
      }
    });
  }
}
