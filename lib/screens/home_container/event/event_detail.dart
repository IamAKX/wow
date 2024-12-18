import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/event_subscriber.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/share_event.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';

import '../../../main.dart';
import '../../../models/whats_on_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/helpers.dart';
import '../../../utils/prefs_key.dart';
import '../../../widgets/bordered_circular_image.dart';
import '../../../widgets/gaps.dart';
import '../profile/profile_detail_screen.dart';
import '../user_detail_screen/other_user_detail_screen.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({super.key, required this.whatsonModel});
  static const String route = '/eventDetail';
  final WhatsonModel whatsonModel;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late ApiCallProvider apiCallProvider;
  EventSubscriber? eventSubscriber;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  loadData() async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'eventId': widget.whatsonModel.id
    };
    apiCallProvider
        .postRequest(API.eventSubscriberDetails, reqBody)
        .then((value) {
      if (value['details'] != null) {
        eventSubscriber = EventSubscriber.fromJson(value['details']);
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
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.redAccent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text(
          'Details',
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
                image: AssetImage(
                  'assets/image/birthday_image_11.jpeg',
                ),
                fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BorderedCircularImage(
                    imagePath: eventSubscriber?.imageDp ?? '',
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
                        eventSubscriber?.name ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Id : ${eventSubscriber?.username ?? ''}',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventSubscriber?.eventTopic ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            eventSubscriber?.description ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
                    'will start on ${eventSubscriber?.eventStartTime ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    (eventSubscriber?.subscriberStatus ?? false)
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  horizontalGap(2),
                  Text(
                    eventSubscriber?.eventSubscriberCounts ?? '',
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
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                EventSubscribers? subscribers =
                    eventSubscriber?.eventSubscribers?.elementAt(index);
                return ListTile(
                  onTap: () {
                    if (subscribers?.userId ==
                        prefs.getString(PrefsKey.userId)) {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(ProfileDeatilScreen.route)
                          .then(
                        (value) {
                          loadData();
                        },
                      );
                    } else {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(OtherUserDeatilScreen.route,
                              arguments: subscribers?.userId)
                          .then(
                        (value) {
                          loadData();
                        },
                      );
                    }
                  },
                  leading: CircularImage(
                      imagePath: subscribers?.imageDp ?? '', diameter: 40),
                  title: Text(
                    subscribers?.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.male,
                              color: Colors.white,
                              size: 10,
                            ),
                            horizontalGap(5),
                             Text(
                              '22',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${subscribers?.createdAt?.split(' ')[1]}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const Text(
                        'Subscribed',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                  ),
              itemCount: eventSubscriber?.eventSubscribers?.length ?? 0),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Text color
                    shadowColor: Colors.blue, // No shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                        ShareEvent.route,
                        arguments: widget.whatsonModel.id);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('SHARE'),
                  ),
                ),
              ),
              horizontalGap(20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Text color
                    shadowColor: Colors.green, // No shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {
                    subscribeUnSubscribeEvent(widget.whatsonModel.id ?? '');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('SUBSCRIBE'),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
