import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter_rhr/player.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/user_level_cars.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';

import '../../../widgets/gaps.dart';

class SendingScreen extends StatefulWidget {
  const SendingScreen({super.key});

  @override
  State<SendingScreen> createState() => _SendingScreenState();
}

class _SendingScreenState extends State<SendingScreen> {
  @override
  Widget build(BuildContext context) {
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
            const Text(
              'LV.22',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            horizontalGap(10),
            Container(
              width: 200,
              child: LinearProgressIndicator(
                value: 0.4,
                color: Colors.red,
                minHeight: 10,
                backgroundColor: Colors.red.withOpacity(0.4),
              ),
            ),
            horizontalGap(10),
            const Text(
              'LV.23',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            )
          ],
        ),
        verticalGap(5),
        const Text(
          '1352773/9999999',
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
                Container(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
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
                            Align(
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
                              child: SVGASimpleImage(
                                resUrl:
                                    'https://github.com/yyued/SVGA-Samples/blob/master/angel.svga?raw=true',
                              ),
                            ),
                            const Text(
                              '10(s)',
                              style: TextStyle(fontSize: 12),
                            ),
                            const Text(
                              'Unlock LV 100',
                              style: TextStyle(fontSize: 12),
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
            onTap: () {},
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
