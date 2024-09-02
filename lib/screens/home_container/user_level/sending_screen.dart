import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/level_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/user_level_cars.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';

import '../../../main.dart';
import '../../../models/car_by_level.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/prefs_key.dart';
import '../../../widgets/gaps.dart';
import 'how_to_level_up.dart';

class SendingScreen extends StatefulWidget {
  const SendingScreen({super.key, required this.levelModel});
  final LevelModel levelModel;

  @override
  State<SendingScreen> createState() => _SendingScreenState();
}

class _SendingScreenState extends State<SendingScreen> {
  late ApiCallProvider apiCallProvider;
  List<CarByLevel> carList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCarByLevel();
    });
  }

  getCarByLevel() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    apiCallProvider.postRequest(API.getCarsByLevel, reqBody).then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          carList.add(CarByLevel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Image.asset(
            'assets/image/level_img.png',
            width: 70,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LV.${widget.levelModel.sendLevel ?? 1}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            horizontalGap(10),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: ((widget.levelModel.requiredExperience ?? 1) -
                        (widget.levelModel.sendExp ?? 1)) /
                    (widget.levelModel.sendEnd ?? 1),
                color: Colors.red,
                minHeight: 10,
                backgroundColor: Colors.red.withOpacity(0.4),
              ),
            ),
            horizontalGap(10),
            Text(
              'LV.${(widget.levelModel.sendLevel ?? 1) + 1}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            )
          ],
        ),
        verticalGap(5),
        Text(
          '${((widget.levelModel.requiredExperience ?? 1) - (widget.levelModel.sendExp ?? 1))} / ${(widget.levelModel.sendEnd ?? 1)}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
        verticalGap(20),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                verticalGap(10),
                const Text(
                  'Level rewards',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Car',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(UserLevelCars.route);
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                        size: 14,
                      ),
                      iconAlignment: IconAlignment.end,
                      label: const Text(
                        'More',
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: carList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        height: 170,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF7F8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFFF9B55),
                                radius: 12,
                                child: Icon(
                                  Icons.lock_sharp,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              height: 80,
                              // child: SVGASimpleImage(
                              //   resUrl:
                              //       'https://github.com/yyued/SVGA-Samples/blob/master/angel.svga?raw=true',
                              // ),
                              child: CachedNetworkImage(
                                imageUrl: carList.elementAt(index).image ?? '',
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child: Text('Error ${error.toString()}'),
                                ),
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Text(
                              '${carList.elementAt(index).validity}(s)',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Unlock LV ${carList.elementAt(index).level}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Frame',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_right,
                        size: 14,
                      ),
                      iconAlignment: IconAlignment.end,
                      label: const Text(
                        'More',
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Color ID',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_right,
                        size: 14,
                      ),
                      iconAlignment: IconAlignment.end,
                      label: const Text(
                        'More',
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(pagePadding),
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, HowToLevelUp.route),
            child: Container(
              width: double.infinity,
              height: 50,
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
              child: const Text(
                'How to level up?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
