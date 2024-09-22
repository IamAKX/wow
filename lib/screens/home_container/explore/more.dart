// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/new_live_user_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/explore/gift_wall_more.dart';
import 'package:worldsocialintegrationapp/utils/country_continent_map.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/sending_receiving_gifting_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../user_detail_screen/other_user_detail_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late ApiCallProvider apiCallProvider;
  List<SenderReceiverGiftingModel> list = [];
  List<NewLiveUserModel> newLiveUserList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getGiftWall();
      getNewLiveUser();
    });
  }

  getGiftWall() async {
    await apiCallProvider
        .getRequest(API.getSenderReceiverGifting)
        .then((value) {
      list.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(SenderReceiverGiftingModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  getNewLiveUser() async {
    await apiCallProvider.getRequest(API.getNewLiveUsers).then((value) {
      newLiveUserList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          newLiveUserList.add(NewLiveUserModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                pagePadding, pagePadding / 2, pagePadding / 2, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Gift Wall',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(GiftWallMore.route);
                  },
                  label: const Text(
                    'More',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin:
                EdgeInsets.fromLTRB(pagePadding, 0, pagePadding, pagePadding),
            decoration: BoxDecoration(
                color: Color(0xFFFAF4FF),
                borderRadius: BorderRadius.circular(10)),
            child: list.isEmpty
                ? SizedBox.shrink()
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return getProfileCouple(list.elementAt(index));
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: pagePadding),
            child: const Text(
              'Countries',
              style: TextStyle(fontSize: 16),
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.all(10),
            primary: true,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3),
            itemCount: getMoreCountryList().length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFFF5F7F9),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      getMoreCountryList().values.elementAt(index).flagPath ??
                          '',
                      width: 20,
                    ),
                    horizontalGap(5),
                    Text(
                      getMoreCountryList().values.elementAt(index).country ??
                          '',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              );
            },
          ),
          verticalGap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: pagePadding),
            child: const Text(
              'New',
              style: TextStyle(fontSize: 16),
            ),
          ),
          newLiveUserList.isEmpty
              ? SizedBox.shrink()
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1,
                  ),
                  itemCount: newLiveUserList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return getLiveUser(newLiveUserList.elementAt(index));
                  },
                )
        ],
      ),
    );
  }

  Column getProfileCouple(SenderReceiverGiftingModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: Stack(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularImage(
                        imagePath: item.senderImage ?? '', diameter: 60),
                    horizontalGap(10),
                    CircularImage(
                        imagePath: item.receiverImage ?? '', diameter: 60),
                  ],
                ),
              ),
              Container(
                width: 130,
                height: 60,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/image/lion.png',
                  width: 30,
                ),
              )
            ],
          ),
        ),
        verticalGap(5),
        Row(
          children: [
            horizontalGap(10),
            Expanded(
                child: Text(
              item.senderName ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            )),
            horizontalGap(10),
            Expanded(
                child: Text(
              item.receiverName ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            )),
            horizontalGap(10),
          ],
        ),
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Color(0xFFDFDFE1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/image/money.png',
                width: 12,
              ),
              horizontalGap(5),
              Text(
                item.diamond?.split('.').first ?? '',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getLiveUser(NewLiveUserModel liveUser) {
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
          OtherUserDeatilScreen.route,
          arguments: liveUser.userId ?? ''),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              image: NetworkImage(liveUser.imageDp ?? ''), fit: BoxFit.cover),
        ),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                'Any',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 10,
                  ),
                  Text(
                    '${liveUser.name ?? ''}',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
