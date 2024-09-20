import 'package:flutter/material.dart';

import '../../models/joinable_live_room_model.dart';
import '../../models/live_room_user_model.dart';
import '../../services/live_room_firebase.dart';
import '../../widgets/circular_image.dart';
import '../../widgets/gaps.dart';

class InviteAudienceBottomSheet extends StatefulWidget {
  const InviteAudienceBottomSheet(
      {super.key,
      required this.roomDetail,
      required this.position,
      required this.participants,
      required this.hotSeatMap});
  final JoinableLiveRoomModel roomDetail;
  final int position;
  final List<LiveRoomUserModel> participants;
  final Map<int, LiveRoomUserModel> hotSeatMap;

  @override
  State<InviteAudienceBottomSheet> createState() =>
      _InviteAudienceBottomSheetState();
}

class _InviteAudienceBottomSheetState extends State<InviteAudienceBottomSheet> {
  @override
  Widget build(BuildContext context) {
    LiveRoomUserModel owner = widget.participants.firstWhere((element) {
      return element.id == widget.roomDetail.userId;
    });
    widget.participants.remove(owner);
    return FractionallySizedBox(
      heightFactor: 0.7, // Set height to 60% of screen height
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xFFC39955),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.participants.length} people online',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            verticalGap(5),
            Text('Homeowner'),
            getMemberList(owner, context),
            Divider(
              color: Colors.grey,
            ),
            verticalGap(5),
            Text('Member'),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    LiveRoomUserModel visitorModel =
                        widget.participants.elementAt(index);
                    return getMemberList(visitorModel, context);
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.grey,
                      ),
                  itemCount: widget.participants.length),
            )
          ],
        ),
      ),
    );
  }

  ListTile getMemberList(LiveRoomUserModel visitorModel, BuildContext context) {
    return ListTile(
      leading: CircularImage(imagePath: visitorModel.image ?? '', diameter: 40),
      title: Text(
        visitorModel.username ?? '',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        if (visitorModel.id == widget.roomDetail.userId) {
          return;
        }
        // widget.hotSeatMap.entries.forEach(
        //   (element) {
        //     if (element.value.id == visitorModel.id) {
        //       LiveRoomFirebase.removeLiveRoomHotSeat(
        //         widget.roomDetail.id ?? '',
        //         element.key,
        //       );
        //     }
        //   },
        // );
        // LiveRoomFirebase.addLiveRoomHotSeat(
        //     widget.roomDetail.id ?? '', widget.position + 1, visitorModel);
        LiveRoomFirebase.updateLiveRoomAdminSettings(widget.roomDetail.id ?? '',
            visitorModel.id ?? '', 'position', widget.position);
        LiveRoomFirebase.updateLiveRoomAdminSettings(widget.roomDetail.id ?? '',
            visitorModel.id ?? '', 'invite', true);
        Navigator.pop(context);
      },
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: const BoxDecoration(
                color: Color(0xFF0FDEA5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.male,
                  color: Colors.white,
                  size: 12,
                ),
                horizontalGap(5),
                const Text(
                  '27',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
          horizontalGap(5),
          if ((visitorModel.sendLevel ?? '0') != '0')
            Container(
              width: 60,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(
                      visitorModel.sandBgImage ?? '',
                    ),
                    fit: BoxFit.fill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/image/starlevel.png',
                    width: 12,
                  ),
                  horizontalGap(5),
                  Text(
                    '${visitorModel.sendLevel}',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
          horizontalGap(5),
          if ((visitorModel.reciveLevel ?? '0') != '0')
            Container(
              width: 60,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(
                      visitorModel.reciveBgImage ?? '',
                    ),
                    fit: BoxFit.fill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/image/coins_img.png',
                    width: 12,
                  ),
                  horizontalGap(5),
                  Text(
                    '${visitorModel.reciveLevel}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
