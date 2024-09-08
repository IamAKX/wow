import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svgaplayer_flutter_rhr/player.dart';
import 'package:worldsocialintegrationapp/models/lucky_model.dart';
import 'package:worldsocialintegrationapp/models/send_friend_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/mall/send_friend.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../main.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/prefs_key.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  late ApiCallProvider apiCallProvider;
  List<LuckyModel> carList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLuck();
    });
  }

  getLuck() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    carList.clear();
    await apiCallProvider.postRequest(API.getLuckyId, reqBody).then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          carList.add(LuckyModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  purchaseLuckyId(String luckyId, int index) async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'luckyId': luckyId
    };
    await apiCallProvider
        .postRequest(API.purchaseLuckyId, reqBody)
        .then((value) {
      showToastMessage(value['message'] ?? '');

      if (value['success'] != 1) {
        carList.elementAt(index).isMy = true;
        setState(() {});
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
      itemCount: carList.length,
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
                      '${carList.elementAt(index).validity}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showTestDrivePopup('${carList.elementAt(index).image}');
                      },
                      child: const Text(
                        'Test drive',
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
                    resUrl: '${carList.elementAt(index).image}',
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
                      '${carList.elementAt(index).price}',
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
                      onTap: carList.elementAt(index).isMy ?? false
                          ? null
                          : () {
                              showBuyPopUp(carList.elementAt(index).id!, index);
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
                          carList.elementAt(index).isMy ?? false
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
                            isCar: true,
                            id: carList.elementAt(index).id,
                            price: carList.elementAt(index).price,
                            validity: carList.elementAt(index).validity,
                            url: carList.elementAt(index).image);
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
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: SVGASimpleImage(
                resUrl: link,
              ),
            ),
          ),
        );
      },
    );
  }

  void showBuyPopUp(String luckyId, int index) {
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
                        purchaseLuckyId(luckyId, index);
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
