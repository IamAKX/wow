import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/joinable_live_room_model.dart';
import '../../models/prime_gift_list_model.dart';
import '../../providers/api_call_provider.dart';

class GiftStatsBottomsheet extends StatefulWidget {
  const GiftStatsBottomsheet({super.key, required this.roomDetail});
  final JoinableLiveRoomModel roomDetail;

  @override
  State<GiftStatsBottomsheet> createState() => _GiftStatsBottomsheetState();
}

class _GiftStatsBottomsheetState extends State<GiftStatsBottomsheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ApiCallProvider apiCallProvider;
  PrimeGiftListModel? primeGift;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPrimeGift();
    });
  }

  loadPrimeGift() async {}

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 14),
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                indicatorPadding: EdgeInsets.zero,
                tabs: const [
                  Tab(
                    text: 'Privilege',
                  ),
                  Tab(
                    text: 'Trick',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(),
                    Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
