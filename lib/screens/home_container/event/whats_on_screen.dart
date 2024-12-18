import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/event_detail.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/whats_on_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import 'share_event.dart';

class WhatsOnScreen extends StatefulWidget {
  const WhatsOnScreen({super.key});

  @override
  State<WhatsOnScreen> createState() => _WhatsOnScreenState();
}

class _WhatsOnScreenState extends State<WhatsOnScreen> {
  late ApiCallProvider apiCallProvider;
  List<WhatsonModel> list = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  loadData() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    apiCallProvider.postRequest(API.getAllEvents, reqBody).then((value) {
      list.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(WhatsonModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  subscribeUnSubscribeEvent(String eventId) async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'eventId': eventId
    };
    await apiCallProvider
        .postRequest(API.subscribeUnSubscribeEvent, reqBody)
        .then((value) {
      if (value['message'] != null) {
        showToastMessage(value['message']);
        loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    // return apiCallProvider.status == ApiStatus.loading
    //     ? const DefaultPageLoader()
    //     :
    return list.isEmpty
        ? const Center(
            child: Text(
              'No Event Found',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(EventDetail.route,
                          arguments: list.elementAt(index))
                      .then(
                    (value) {
                      loadData();
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: list.elementAt(index).eventImage ?? '',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/image/birthday_image_11.jpeg',
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                BorderedCircularImage(
                                  imagePath:
                                      list.elementAt(index).imageDp ?? '',
                                  diameter: 30,
                                  borderColor: Colors.white,
                                  borderThickness: 2,
                                ),
                                horizontalGap(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      list.elementAt(index).name ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'Id : ${list.elementAt(index).username ?? ''}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            verticalGap(5),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  horizontalGap(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          list.elementAt(index).eventTopic ??
                                              '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          list.elementAt(index).description ??
                                              '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  (list.elementAt(index).eventCreaterId ==
                                          prefs.getString(PrefsKey.userId))
                                      ? ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                Colors.blue, // Text color
                                            shadowColor:
                                                Colors.blue, // No shadow
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(ShareEvent.route,
                                                    arguments: list
                                                            .elementAt(index)
                                                            .id ??
                                                        '');
                                          },
                                          child: const Text('SHARE'),
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                Colors.green, // Text color
                                            shadowColor:
                                                Colors.green, // No shadow
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            subscribeUnSubscribeEvent(
                                                list.elementAt(index).id ?? '');
                                          },
                                          child: Text((list
                                                      .elementAt(index)
                                                      .isSubscribe ??
                                                  false)
                                              ? 'SUBSCRIBED'
                                              : 'SUBSCRIBE'),
                                        ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                horizontalGap(5),
                                Text(
                                  'will start on ${list.elementAt(index).eventStartTime ?? ''}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.bookmark_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                horizontalGap(2),
                                Text(
                                  list.elementAt(index).eventSubscriberCounts ??
                                      '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                horizontalGap(5),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
