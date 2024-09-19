import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svgaplayer_flutter_rhr/svgaplayer_flutter.dart';
import 'package:worldsocialintegrationapp/models/prime_gift_list_model.dart';
import 'package:worldsocialintegrationapp/models/prime_gift_model.dart';
import 'package:worldsocialintegrationapp/screens/live_room/get_friend_bottonsheet.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/joinable_live_room_model.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/prefs_key.dart';

class PrimeGiftBottom extends StatefulWidget {
  const PrimeGiftBottom(
      {super.key, required this.roomDetail, required this.myCoins});
  final JoinableLiveRoomModel roomDetail;
  final String myCoins;

  @override
  State<PrimeGiftBottom> createState() => _PrimeGiftBottomState();
}

class _PrimeGiftBottomState extends State<PrimeGiftBottom>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ApiCallProvider apiCallProvider;
  PrimeGiftListModel? primeGift;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPrimeGift();
    });
  }

  loadPrimeGift() async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
    };
    await apiCallProvider
        .postRequest(API.getPrimeGift, reqBody)
        .then((value) async {
      if (value['success'] == '1') {
        primeGift = PrimeGiftListModel.fromMap(value['details']);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return FractionallySizedBox(
      heightFactor: 0.6, // Set height to 60% of screen height
      child: ClipRRect(
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
              Row(
                children: [
                  Text('${widget.myCoins}'),
                  horizontalGap(10),
                  Image.asset(
                    'assets/image/coins_img.png',
                    width: 25,
                  ),
                  horizontalGap(10),
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      isScrollable: true,
                      labelStyle: TextStyle(fontSize: 14),
                      labelPadding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 0),
                      indicatorPadding: EdgeInsets.zero,
                      tabs: const [
                        Tab(
                          text: 'Privilege',
                        ),
                        Tab(
                          text: 'Trick',
                        ),
                        Tab(
                          text: 'Event Gifts',
                        ),
                        Tab(
                          text: 'Sound Gifts',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    getGridList(primeGift?.Privilege, false),
                    getGridList(primeGift?.Trick, false),
                    getGridList(primeGift?.EventGifts, false),
                    getGridList(primeGift?.SoundGifts, true),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getGridList(List<PrimeGiftModel>? list, bool isSvga) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: list?.length ?? 0,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // To enable custom height
              builder: (context) => GetFriendBottomsheet(
                  roomDetail: widget.roomDetail,
                  permissionId: list?.elementAt(index).id ?? '',
                  themeId: '',
                  image: File(''),
                  isStoreTheme: false),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: isSvga
                    ? SizedBox(
                        width: 40,
                        height: 40,
                        child: SVGASimpleImage(
                          resUrl: list?.elementAt(index).image ?? '',
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: list?.elementAt(index).image ?? '',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Text('Error ${error.toString()}'),
                        ),
                        fit: BoxFit.contain,
                        width: 40,
                        height: 40,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      list?.elementAt(index).primeAccount ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Image.asset(
                    'assets/image/coins_img.png',
                    width: 10,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
