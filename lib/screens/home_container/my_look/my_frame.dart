import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svgaplayer_flutter_rhr/player.dart';
import 'package:worldsocialintegrationapp/models/purchased_car_model.dart';
import 'package:worldsocialintegrationapp/models/purchased_frame_model.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../main.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/prefs_key.dart';

class MyFrame extends StatefulWidget {
  const MyFrame({super.key});

  @override
  State<MyFrame> createState() => _MyFrameState();
}

class _MyFrameState extends State<MyFrame> {
  late ApiCallProvider apiCallProvider;
  List<PurchasedFrameModel> list = [];

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
        .postRequest(API.getPurchaseFrame, reqBody)
        .then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(PurchasedFrameModel.fromJson(item));
        }
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
                        showTestDrivePopup(
                            '${list.elementAt(index).frameIMage}');
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
                  width: 100,
                  height: 100,
                  child: SVGASimpleImage(
                    resUrl: '${list.elementAt(index).frameIMage}',
                  ),
                ),
                verticalGap(15),
                Text(
                  'deadline:\n${list.elementAt(index).dateTo} / ${list.elementAt(index).expTime}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    Map<String, dynamic> reqBody = {
                      'userId': prefs.getString(PrefsKey.userId),
                      'frameId': list.elementAt(index).frameId,
                    };

                    await apiCallProvider
                        .postRequest(API.applyFrame, reqBody)
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
}
