import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/joinable_live_room_model.dart';
import '../../models/live_room_gift_history_model.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../widgets/default_page_loader.dart';

class ScoreboardBottomsheet extends StatefulWidget {
  const ScoreboardBottomsheet({super.key, required this.roomDetail});
  final JoinableLiveRoomModel roomDetail;

  @override
  State<ScoreboardBottomsheet> createState() => _ScoreboardBottomsheetState();
}

class _ScoreboardBottomsheetState extends State<ScoreboardBottomsheet> {
  late ApiCallProvider apiCallProvider;
  List<LiveRoomGiftHistoryModel> list = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  void loadData() async {
    list.clear();
    Map<String, dynamic> reqBody = {
      'liveId': widget.roomDetail.id,
      'receiverId': prefs.getString(PrefsKey.userId)
    };
    await apiCallProvider.postRequest(API.getReceiverGiftHistory, reqBody).then(
      (value) {
        if (value['details'] != null) {
          for (var item in value['details']) {
            list.add(LiveRoomGiftHistoryModel.fromJson(item));
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return FractionallySizedBox(
      heightFactor: 0.7, // Set height to 60% of screen height
      child: ClipRRect(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: const Color(0xFFC39955),
                child: const Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    Spacer(),
                    Text(
                      'History',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: apiCallProvider.status == ApiStatus.loading &&
                        list.isEmpty
                    ? const DefaultPageLoader()
                    : list.isEmpty
                        ? const Center(
                            child: Text('No Record'),
                          )
                        : ListView.separated(
                            itemCount: 20,
                            separatorBuilder: (context, index) => const Divider(
                              color: Colors.grey,
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  children: [
                                    CircularImage(
                                        imagePath:
                                            list.elementAt(index).senderImg ??
                                                '',
                                        diameter: 40),
                                    horizontalGap(20),
                                    Text(
                                      list.elementAt(index).senderName ?? '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Image.asset('assets/image/diamond.png'),
                                    horizontalGap(5),
                                    Text(
                                      formatDiamondNumber(int.parse(
                                          list.elementAt(index).diamond ??
                                              '0')),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    horizontalGap(10),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
