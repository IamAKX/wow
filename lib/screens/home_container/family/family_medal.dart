import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/single_family_detail_model.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../widgets/family_upgrade_bottom_sheet_content.dart';

class FamilyMedalScreen extends StatefulWidget {
  const FamilyMedalScreen({super.key});
  static const String route = '/familyMedalScreen';

  @override
  State<FamilyMedalScreen> createState() => _FamilyMedalScreenState();
}

class _FamilyMedalScreenState extends State<FamilyMedalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ApiCallProvider apiCallProvider;
  List<List<SingleFamilyDetailModel>> list = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  void loadData() async {
    for (int i = 1; i <= 5; i++) {
      await loadSingleFamilyDeatilsData(i);
    }
  }

  loadSingleFamilyDeatilsData(int type) async {
    List<SingleFamilyDetailModel> medalList = [];
    Map<String, dynamic> reqBody = {'type': '$type'};
    await apiCallProvider
        .postRequest(API.getSingleFamilyDetails, reqBody)
        .then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          medalList.add(SingleFamilyDetailModel.fromJson(item));
        }
        list.add(medalList);
        log('Added at $type');
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: Color(0xFF00DA39),
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            insets: EdgeInsets.symmetric(horizontal: 50.0),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          indicatorColor: const Color(0xFF00DA39),
          indicatorPadding: const EdgeInsets.only(bottom: 10),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00DA39),
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9F9E9E),
          ),
          tabs: const [
            Tab(
              text: 'Iron',
            ),
            Tab(
              text: 'Bronze',
            ),
            Tab(
              text: 'Silver',
            ),
            Tab(
              text: 'Gold',
            ),
            Tab(
              text: 'Diamond',
            ),
          ],
        ),
      ),
      body: apiCallProvider.status == ApiStatus.loading
          ? const DefaultPageLoader(
              progressColor: Color(0xFF00DA39),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                getBody(context, 0),
                getBody(context, 1),
                getBody(context, 2),
                getBody(context, 3),
                getBody(context, 4),
              ],
            ),
    );
  }

  getBody(BuildContext context, int position) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 40),
          height: 200,
          child: getMedalCarousel(list.elementAt(position)),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Privileges',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: getPrivilegeCard('Rank Medal',
                            list[position].first.mainImage ?? '')),
                    Expanded(
                        child: getPrivilegeCard(
                            '${list[position].first.members} Medal',
                            list[position].first.memberImage ?? '')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: getPrivilegeCard(
                            '${list[position].first.admin} Admins',
                            list[position].first.adminImage ?? '')),
                    (position == 0)
                        ? Expanded(
                            child: getPrivilegeCard('Exclusive background',
                                list[position].first.exclusiveBackground ?? ''))
                        : Expanded(
                            child: getPrivilegeCard('Exclusive frame',
                                list[position].first.exclusiveFrames ?? '')),
                  ],
                ),
                if (position > 0)
                  Row(
                    children: [
                      Expanded(
                          child: getPrivilegeCard('Exclusive background',
                              list[position].first.exclusiveBackground ?? '')),
                      if (position == 3)
                        Expanded(
                            child: getPrivilegeCard('Exclusive gift',
                                list[position].first.exclusiveGift ?? '')),
                    ],
                  )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close),
                        ),
                      ),
                      // Image.asset(
                      //   'assets/image/fire.png',
                      //   fit: BoxFit.fill,
                      //   width: 40,
                      //   height: 40,
                      // ),
                      const Text(
                        '🔥',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                      verticalGap(10),
                      const Text(
                        'You can speed up Your family\'s level up process by completing the following tasks.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalGap(10),
                      FamilyUpgradeBottomSheetContent(),
                    ],
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF00DA39),
              foregroundColor: Colors.white,
            ),
            child: const Text('How to upgrade quickly?'),
          ),
        )
      ],
    );
  }

  getPrivilegeCard(String label, String image) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Set the border radius here
      ),
      margin: const EdgeInsets.all(10),
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Center(
                child: Text('Error ${error.toString()}'),
              ),
              width: 50,
              height: 50,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getMedalCarousel(List<SingleFamilyDetailModel> medalList) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 180.0,
        showIndicator: false,
        autoPlay: false,
        pageSnapping: true,
        floatingIndicator: false,
        viewportFraction: 1,
        slideIndicator: const CircularSlideIndicator(
          slideIndicatorOptions: SlideIndicatorOptions(
              currentIndicatorColor: Color(0xffFA03E6),
              indicatorBackgroundColor: Colors.white),
        ),
      ),
      items: medalList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: i.mainImage ?? '',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text('Error ${error.toString()}'),
                    ),
                    width: 90,
                    height: 90,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                        imageUrl: i.mainImage ?? '',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Text('Error ${error.toString()}'),
                        ),
                        width: 100,
                        height: 100,
                      ),
                      verticalGap(10),
                      Text(
                        i.levelName ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: i.mainImage ?? '',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text('Error ${error.toString()}'),
                    ),
                    width: 90,
                    height: 90,
                  ),
                )
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
