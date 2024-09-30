import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/live_room_gift_history_model.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';

import '../providers/api_call_provider.dart';
import 'default_page_loader.dart';
import 'gaps.dart';

class GiftStatsHistory extends StatefulWidget {
  const GiftStatsHistory({super.key, required this.type, required this.liveId});
  final int type;
  final String liveId;

  @override
  State<GiftStatsHistory> createState() => _GiftStatsHistoryState();
}

class _GiftStatsHistoryState extends State<GiftStatsHistory> {
  List<LiveRoomGiftHistoryModel> list = [];
  late ApiCallProvider apiCallProvider;
  String total = '0';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  void loadUserData() async {
    list.clear();
    Map<String, dynamic> reqBody = {
      'liveId': widget.liveId,
      'type': '${widget.type}'
    };
    await apiCallProvider.postRequest(API.getLiveGifting, reqBody).then(
      (value) {
        if (value['details'] != null) {
          for (var item in value['details']) {
            list.add(LiveRoomGiftHistoryModel.fromJson(item));
          }
          if (value['total'] != null) total = value['total'];
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return apiCallProvider.status == ApiStatus.loading && list.isEmpty
        ? const DefaultPageLoader()
        : list.isEmpty
            ? const Center(
                child: Text('No Record'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircularImage(
                                imagePath:
                                    list.elementAt(index).senderImg ?? '',
                                diameter: 50),
                            title: Text(
                              '${list.elementAt(index).senderName} sent to ${list.elementAt(index).receiverName}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    formatDiamondNumber(int.parse(
                                        list.elementAt(index).diamond ?? '0')),
                                    style: const TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  horizontalGap(10),
                                  Image.asset('assets/image/diamond.png')
                                ],
                              ),
                            ),
                            subtitle: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 3),
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF0FDEA5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        ((list.elementAt(index).senderGender ??
                                                    'Male') ==
                                                'Male')
                                            ? Icons.male
                                            : Icons.female,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      horizontalGap(5),
                                      Text(
                                        '${list.elementAt(index).senderAge}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(
                              color: Colors.grey,
                            ),
                        itemCount: list.length),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          (widget.type == 1)
                              ? 'In 24 hours the room got:'
                              : 'Total in the room:',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        horizontalGap(4),
                        Text(
                          formatDiamondNumber(int.parse(total)),
                          style: const TextStyle(
                            color: Colors.pink,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        horizontalGap(10),
                        Image.asset('assets/image/diamond.png')
                      ],
                    ),
                  ),
                ],
              );
  }
}
