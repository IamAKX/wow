import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/live_room_exit_model.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../main.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/helpers.dart';
import '../../../utils/prefs_key.dart';

class LiveEndPopup extends StatefulWidget {
  const LiveEndPopup(
      {super.key,
      required this.roomId,
      required this.userId,
      required this.startTime,
      required this.liveRoomExitModel});
  final String roomId;
  final String userId;
  final DateTime startTime;
  final LiveRoomExitModel liveRoomExitModel;

  @override
  State<LiveEndPopup> createState() => _LiveEndPopupState();
}

class _LiveEndPopupState extends State<LiveEndPopup> {
  late ApiCallProvider apiCallProvider;
  int total = 0;
  int participants = 0;
  final endTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadGiftingRecord();
    });
  }

  loadGiftingRecord() async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'startTime': formatDBDate(widget.startTime),
      'endTime': formatDBDate(endTime)
    };
    apiCallProvider
        .postRequest(API.getLiveGiftingRecord, reqBody)
        .then((value) async {
      if (value['success'] == '1') {
        total = value['totalDiamond'];
        participants = value['totalAudience'];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    int differenceInSeconds = endTime.difference(widget.startTime).inSeconds;
    print('Time difference: $differenceInSeconds seconds');

    return Padding(
      padding: EdgeInsets.all(40),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalGap(70),
            Text(
              'Live End',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalGap(40),
            GridView(
              padding: const EdgeInsets.all(10),
              primary: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 50,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              children: [
                getGridItems(
                    formatDuration(differenceInSeconds), 'Live Duration'),
                getGridIconItems('$total', 'Diamond'),
                getGridItems('$participants', 'Total Audience'),
                getGridItems('0', 'Minimum Audience'),
                getGridItems('0', 'New Follows'),
                getGridItems('0', 'Share Number'),
              ],
            ),
            verticalGap(20),
            Text(
              'This live is over. Share your live\nwith others.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            verticalGap(20),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purpleAccent,
                      Colors.deepPurpleAccent,
                    ],
                  ),
                ),
                child: Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getGridItems(String heading, String subheading) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          heading,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        verticalGap(10),
        Text(
          subheading,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
        )
      ],
    );
  }

  getGridIconItems(String heading, String subheading) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          heading,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        verticalGap(10),
        Image.asset(
          'assets/image/new_diamond.png',
          width: 20,
          height: 20,
        ),
      ],
    );
  }
}
