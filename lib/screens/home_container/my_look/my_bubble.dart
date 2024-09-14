import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svgaplayer_flutter_rhr/player.dart';
import 'package:worldsocialintegrationapp/models/purchased_bubble_model.dart';
import 'package:worldsocialintegrationapp/models/purchased_car_model.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../main.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/prefs_key.dart';

class MyBubble extends StatefulWidget {
  const MyBubble({super.key});

  @override
  State<MyBubble> createState() => _MyBubbleState();
}

class _MyBubbleState extends State<MyBubble> {
  late ApiCallProvider apiCallProvider;
  List<PurchasedVipModel> list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLuck();
    });
  }

  getLuck() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    list.clear();
    await apiCallProvider
        .postRequest(
            '${API.getVipImages}?userId=${prefs.getString(PrefsKey.userId)}',
            reqBody)
        .then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(PurchasedVipModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return list.isEmpty
        ? Center(
            child: Text('No item found'),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.8,
            ),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              showPreviewPopup(
                                  '${list.elementAt(index).vipImage}');
                            },
                            child: const Text(
                              'Preview',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF73400),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CachedNetworkImage(
                          imageUrl: list.elementAt(index).vipImage ?? '',
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Text('Error ${error.toString()}'),
                          ),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          Map<String, dynamic> reqBody = {
                            'userId': prefs.getString(PrefsKey.userId),
                            'vipId': list.elementAt(index).id,
                          };

                          await apiCallProvider
                              .postRequest(API.applyVip, reqBody)
                              .then((value) {
                            if (value['message'] != null) {
                              showToastMessage(value['message']);

                              getLuck();
                            }
                          });
                        },
                        child: Container(
                          width: 70,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffFE3400),
                                Color(0xffFBC108),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            list.elementAt(index).isApplied ?? false
                                ? 'Remove'
                                : 'Apply',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }

  void showPreviewPopup(String link) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.width - 40,
            // child: SVGASimpleImage(
            //   resUrl: link,
            // ),
            child: CachedNetworkImage(
              imageUrl: link,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Center(
                child: Text('Error ${error.toString()}'),
              ),
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.width - 40,
            ),
          ),
        );
      },
    );
  }
}
