import 'package:flutter/material.dart';
import 'package:polar_tab_bar/models/polar_tab_item.dart';
import 'package:polar_tab_bar/polar_tab_bar.dart';
import 'package:polar_tab_bar/widgets/polar_tab_page.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/widgets/gift_history.dart';

import '../../models/joinable_live_room_model.dart';
import '../../models/prime_gift_list_model.dart';
import '../../providers/api_call_provider.dart';

class GiftStatsBottomsheet extends StatefulWidget {
  const GiftStatsBottomsheet({super.key, required this.roomDetail});
  final JoinableLiveRoomModel roomDetail;

  @override
  State<GiftStatsBottomsheet> createState() => _GiftStatsBottomsheetState();
}

class _GiftStatsBottomsheetState extends State<GiftStatsBottomsheet> {
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPrimeGift();
    });
  }

  loadPrimeGift() async {}

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    final List<PolarTabItem> tabs = [
      PolarTabItem(
        index: 0,
        title: '24 Hours',
        page: PolarTabPage(
          child: GiftStatsHistory(
            type: 1,
            liveId: widget.roomDetail.id ?? '',
          ),
        ),
      ),
      PolarTabItem(
          index: 1,
          title: 'Total',
          page: PolarTabPage(
            child: GiftStatsHistory(
              type: 0,
              liveId: widget.roomDetail.id ?? '',
            ),
          )),
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      expand: false,
      builder: (_, controller) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: PolarTabBar(
            radius: 10,
            tabs: tabs,
            background: const Color(0xFFD6D6D6),
          ),
        ),
      ),
    );
  }
}
