import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svgaplayer_flutter_rhr/svgaplayer_flutter.dart';
import 'package:worldsocialintegrationapp/models/frame_model.dart';

import '../../../main.dart';
import '../../../models/send_friend_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/helpers.dart';
import '../../../utils/prefs_key.dart';
import '../../../widgets/gaps.dart';
import 'send_friend.dart';

class FramesScreen extends StatefulWidget {
  const FramesScreen({super.key});

  @override
  State<FramesScreen> createState() => _FramesScreenState();
}

class _FramesScreenState extends State<FramesScreen> {
  late ApiCallProvider apiCallProvider;
  List<FrameModel> frameList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFrames();
    });
  }

  getFrames() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    frameList.clear();
    await apiCallProvider.postRequest(API.getFrames, reqBody).then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          frameList.add(FrameModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  purchaseFrame(String frameId, int index) async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'frameId': frameId
    };
    await apiCallProvider
        .postRequest(API.purchaseFrames, reqBody)
        .then((value) {
      showToastMessage(value['message'] ?? '');
      if (value['success'] != 1) {
        setState(() {
          frameList.elementAt(index).isMy = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.95,
      ),
      itemCount: frameList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled_sharp,
                      size: 20,
                      color: Colors.grey,
                    ),
                    horizontalGap(5),
                    Text(
                      '${frameList.elementAt(index).validity}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showTestDrivePopup(
                            '${frameList.elementAt(index).frameImg}');
                      },
                      child: const Text(
                        'Test Wear',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF73400),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: SVGASimpleImage(
                    resUrl: '${frameList.elementAt(index).frameImg}',
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/image/money.png',
                      width: 20,
                    ),
                    horizontalGap(5),
                    Text(
                      '${frameList.elementAt(index).price}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                verticalGap(10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: frameList.elementAt(index).isMy ?? false
                          ? null
                          : () {
                              showBuyPopUp(
                                  frameList.elementAt(index).id!, index);
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
                          frameList.elementAt(index).isMy ?? false
                              ? 'Bought'
                              : 'Buy',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    horizontalGap(10),
                    InkWell(
                      onTap: () {
                        SendFriendModel model = SendFriendModel(
                            isCar: false,
                            id: frameList.elementAt(index).id,
                            price: frameList.elementAt(index).price,
                            validity: frameList.elementAt(index).validity,
                            url: frameList.elementAt(index).frameImg);
                        Navigator.pushNamed(context, SendFriendScreen.route,
                            arguments: model);
                      },
                      child: Container(
                        width: 70,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffFE3400),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const Text(
                          'Send',
                          style: TextStyle(color: Color(0xffFE3400)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showTestDrivePopup(String link) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.width - 40,
            child: SVGASimpleImage(
              resUrl: link,
            ),
          ),
        );
      },
    );
  }

  void showBuyPopUp(String frameId, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tips',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              verticalGap(20),
              const Text(
                'Sure to buy this car? If use the car, you \'ll get more attentin in the Live Room.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                textAlign: TextAlign.end,
              ),
              verticalGap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  horizontalGap(20),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        purchaseFrame(frameId, index);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFF73201),
                      ),
                      child: const Text(
                        'BUY',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
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
