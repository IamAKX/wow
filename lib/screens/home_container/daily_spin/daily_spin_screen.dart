import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:provider/provider.dart';
import 'package:svgaplayer_flutter_rhr/player.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';
import 'package:worldsocialintegrationapp/widgets/wheel.dart';
import 'package:kbspinningwheel/kbspinningwheel.dart';
import '../../../models/spin_data_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../widgets/spinwheel_winner_popup.dart';

class DailySpinScreen extends StatefulWidget {
  static const String route = '/dailySpinScreen';

  const DailySpinScreen({super.key});

  @override
  State<DailySpinScreen> createState() => _DailySpinScreenState();
}

class _DailySpinScreenState extends State<DailySpinScreen> {
  late ApiCallProvider apiCallProvider;
  final StreamController _dividerController = StreamController<int>.broadcast();
  final _wheelNotifier = StreamController<double>.broadcast();
  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 8000;
  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
  List<SpinDataModel> spinDataList = [];

  @override
  void dispose() {
    _dividerController.close();
    _wheelNotifier.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSpinnerData();
    });
  }

  loadSpinnerData() async {
    spinDataList.clear();
    Map<String, dynamic> reqBody = {'type': '1'};
    await apiCallProvider
        .postRequest(API.getSpinWheelDetails, reqBody)
        .then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          spinDataList.add(
            SpinDataModel(
              header: item['coins'],
              subtitle: 'coins',
              quantity: item['coins'],
              typeId: '1',
              typeName: 'coins',
            ),
          );
        }
      }
    });
    reqBody = {'type': '2'};
    await apiCallProvider
        .postRequest(API.getSpinWheelDetails, reqBody)
        .then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          spinDataList.add(
            SpinDataModel(
              header: item['diamonds'],
              subtitle: 'diamonds',
              quantity: item['diamonds'],
              typeId: '2',
              typeName: 'diamonds',
            ),
          );
        }
      }
    });

    reqBody = {'type': '3'};
    await apiCallProvider
        .postRequest(API.getSpinWheelDetails, reqBody)
        .then((value) {
      if (value['details'] != null) {
        spinDataList.add(
          SpinDataModel(
            header: '${(value['details'] as List<dynamic>).length}',
            subtitle: 'frames',
            quantity: '${(value['details'] as List<dynamic>).length}',
            typeId: '3',
            typeName: 'frame',
          ),
        );
      }
    });

    reqBody = {'type': '4'};
    await apiCallProvider
        .postRequest(API.getSpinWheelDetails, reqBody)
        .then((value) {
      if (value['details'] != null) {
        spinDataList.add(
          SpinDataModel(
            header: '${(value['details'] as List<dynamic>).length}',
            subtitle: 'Entry Effect',
            quantity: '${(value['details'] as List<dynamic>).length}',
            typeId: '4',
            typeName: 'entryEffect',
          ),
        );
      }
    });

    reqBody = {'type': '5'};
    await apiCallProvider
        .postRequest(API.getSpinWheelDetails, reqBody)
        .then((value) {
      if (value['details'] != null) {
        spinDataList.add(
          SpinDataModel(
            header: '${(value['details'] as List<dynamic>).length}',
            subtitle: 'Gift',
            quantity: '${(value['details'] as List<dynamic>).length}',
            typeId: '5',
            typeName: 'gift',
          ),
        );
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFff4d0b),
                  Color(0xFFff840a),
                  Color(0xFFfdb813),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/image/spinitwinit.webp',
                width: 300,
              ),
            ),
          ),
          spinDataList.isEmpty
              ? SizedBox.shrink()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/image/spin_stand.webp',
                              width: 300,
                              height: 300,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 120,
                          left: MediaQuery.of(context).size.width / 2,
                          child: InkWell(
                            onTap: () async {
                              spinWheel();
                            },
                            child: SpinningWheel(
                              image: CustomPaint(
                                painter: WheelPainter(
                                  spinDataList: spinDataList,
                                ),
                                willChange: true,
                              ),
                              width: 300,
                              height: 300,
                              dividers: 8,
                              initialSpinAngle: _generateRandomAngle(),
                              spinResistance: 0.9,
                              canInteractWhileSpinning: false,
                              onUpdate: _dividerController.add,
                              onEnd: (finalValue) {
                                handleSpinResult(finalValue);
                              },
                              shouldStartOrStop: _wheelNotifier.stream,
                            ),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2 - 40,
                          top: 80,
                          child: InkWell(
                            onTap: () {
                              spinWheel();
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/image/roulette-center-300.png',
                                  width: 80,
                                  height: 80,
                                ),
                                Image.asset(
                                  'assets/image/spin_btn.webp',
                                  width: 50,
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/image/coin_treasure.webp',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  void handleSpinResult(finalValue) async {
    int index = (finalValue % spinDataList.length) - 3;

    if (index < 0) {
      index += spinDataList.length;
    }
    SpinDataModel result = spinDataList[index];
    publishSpinResult(
      result,
    );
  }

  publishSpinResult(SpinDataModel result) async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'coins': result.quantity,
      'type': result.typeId
    };
    await apiCallProvider.postRequest(API.hitSpinWheel, reqBody).then((value) {
      if (value['message'] != null) {
        showToastMessage(value['message']);
        if (['1', '2'].contains(result.typeId)) {
          showWinninDialog(context, result);
        } else {
          showSVGAWinningDialog(context, result, value);
        }
      }
    });
  }

  void showWinninDialog(BuildContext context, SpinDataModel result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20.0), // Margin around the dialog
          child: SpinwheelWinnerPopup(
            spinDataModel: result,
          ),
        );
      },
    );
  }

  Future<void> spinWheel() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    await apiCallProvider
        .postRequest(API.checkSpinWheel, reqBody)
        .then((value) {
      if (value['success'] == '0') {
        showToastMessage(value['message']);
      } else {
        _wheelNotifier.sink.add(_generateRandomVelocity());
      }
    });
  }

  void showSVGAWinningDialog(
      BuildContext context, SpinDataModel result, Map value) {
    String url = value['details']['gift'];
    if (result.typeId == '3' || result.typeId == '4') {
      if (value['details']['frame'] != '') {
        url = '${API.baseUrl}/${value['details']['frame']}';
      } else {
        url = value['details']['entryEffect'];
      }
    }
    debugPrint('url = $url');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: (result.typeId == '3' || result.typeId == '4')
                    ? SVGASimpleImage(
                        resUrl: url,
                      )
                    : Image.network(url),
              ),
              verticalGap(10),
              Text('Congratulations'),
              verticalGap(5),
              Text('you Won ${result.header ?? ''} ${result.subtitle ?? ''}'),
              verticalGap(10),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF3488D5),
                        Color(0xFFEA0A8A),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
