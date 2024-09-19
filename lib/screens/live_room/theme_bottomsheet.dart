import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/live_room/get_friend_bottonsheet.dart';
import 'package:worldsocialintegrationapp/screens/live_room/purchase_gallery_bottomsheet.dart';
import 'package:worldsocialintegrationapp/services/live_room_firebase.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';

import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/joinable_live_room_model.dart';
import '../../models/theme_free_image_model.dart';
import '../../models/theme_paid_image_model.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/prefs_key.dart';
import '../../widgets/enum.dart';

class ThemeBottomsheet extends StatefulWidget {
  const ThemeBottomsheet({
    Key? key,
    required this.roomDetail,
  }) : super(key: key);
  final JoinableLiveRoomModel roomDetail;

  @override
  State<ThemeBottomsheet> createState() => _ThemeBottomsheetState();
}

class _ThemeBottomsheetState extends State<ThemeBottomsheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ApiCallProvider apiCallProvider;

  List<ThemeFreeImageModel> freeThemeList = [];
  List<ThemePaidImageModel> paidThemeList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFreeImage();
      loadPaidImage();
    });
  }

  loadFreeImage() async {
    apiCallProvider.getRequest(API.getImages).then((value) {
      freeThemeList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          freeThemeList.add(ThemeFreeImageModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  loadPaidImage() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    apiCallProvider.postRequest(API.getThemes, reqBody).then((value) {
      paidThemeList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          paidThemeList.add(ThemePaidImageModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  Future<bool> buyTheme(String themeId) async {
    bool res = false;
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'themeId': themeId,
    };
    await apiCallProvider
        .postRequest(API.purchaseThemes, reqBody)
        .then((value) {
      if (value['success'] != null) {
        res = value['success'] == '1';
        showToastMessage(value['message']);
        setState(() {});
      }
    });
    return res;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return FractionallySizedBox(
      heightFactor: 0.6, // Set height to 60% of screen height
      child: ClipRRect(
        borderRadius: BorderRadius.only(
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
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.green,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        ),
                      ),
                      labelPadding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                      indicatorPadding: const EdgeInsets.only(bottom: 10),
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      tabs: const [
                        Tab(
                          text: 'THEME',
                        ),
                        Tab(
                          text: 'STORE',
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // To enable custom height
                        builder: (context) => PurchaseGalleryBottomsheet(
                            roomDetail: widget.roomDetail),
                      );
                    },
                    icon: const Icon(
                      Icons.photo_library_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    freeTheme(),
                    storeTheme(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  freeTheme() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            'Free',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        verticalGap(10),
        Expanded(
          child: GridView.builder(
            primary: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9),
            itemCount: freeThemeList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showImageDialog(
                      context, freeThemeList.elementAt(index).images ?? '');
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: freeThemeList.elementAt(index).images ?? '',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text('Error ${error.toString()}'),
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  storeTheme() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GridView.builder(
            primary: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7),
            itemCount: paidThemeList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: paidThemeList.elementAt(index).theme ?? '',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Text('Error ${error.toString()}'),
                        ),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time_filled,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                horizontalGap(5),
                                Text(
                                  '${paidThemeList.elementAt(index).valditity ?? '0'} days',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    showPreviewImageDialog(
                                        context,
                                        paidThemeList.elementAt(index).theme ??
                                            '');
                                  },
                                  child: const Icon(
                                    Icons.preview_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${paidThemeList.elementAt(index).price ?? ''} coins',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.red,
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: (paidThemeList
                                                .elementAt(index)
                                                .purchasedType ??
                                            false)
                                        ? () {
                                            showImageDialog(
                                                context,
                                                paidThemeList
                                                        .elementAt(index)
                                                        .theme ??
                                                    '');
                                          }
                                        : () {
                                            showPaidImageDialog(context,
                                                paidThemeList.elementAt(index));
                                          },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: Text(
                                        (paidThemeList
                                                    .elementAt(index)
                                                    .purchasedType ??
                                                false)
                                            ? 'Set'
                                            : 'Buy',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled:
                                            true, // To enable custom height
                                        builder: (context) =>
                                            GetFriendBottomsheet(
                                                roomDetail: widget.roomDetail,
                                                permissionId: '',
                                                themeId: paidThemeList
                                                        .elementAt(index)
                                                        .id ??
                                                    '',
                                                image: File(''),
                                                giftType: GiftType.STORE),
                                      ).then(
                                        (value) {
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Send',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Image Preview'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Text('Error ${error.toString()}'),
                ),
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Set'),
              onPressed: () async {
                await LiveRoomFirebase.updateLiveRoomTheme(
                    widget.roomDetail.id ?? '', imageUrl);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showPreviewImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Image Preview'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Text('Error ${error.toString()}'),
                ),
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showPaidImageDialog(
      BuildContext context, ThemePaidImageModel pageImageModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Image Preview'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: pageImageModel.theme ?? '',
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Text('Error ${error.toString()}'),
                ),
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Buy'),
              onPressed: () async {
                bool res = await buyTheme(pageImageModel.id ?? '');
                if (res) {
                  await LiveRoomFirebase.updateLiveRoomTheme(
                      widget.roomDetail.id ?? '', pageImageModel.theme ?? '');
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
