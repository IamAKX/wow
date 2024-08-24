import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter_rhr/player.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/how_to_level_up.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';

class UserLevelCars extends StatefulWidget {
  const UserLevelCars({super.key});
  static const String route = '/userLevelCars';

  @override
  State<UserLevelCars> createState() => _UserLevelCarsState();
}

class _UserLevelCarsState extends State<UserLevelCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.7,
            ),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5C8D3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Color(0xFFFF9B55),
                          size: 15,
                        ),
                        Text(
                          'Preview',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        width: 80,
                        child: SVGASimpleImage(
                          resUrl:
                              'https://github.com/yyued/SVGA-Samples/blob/master/angel.svga?raw=true',
                        ),
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
        InkWell(
          onTap: () => Navigator.pushNamed(context, HowToLevelUp.route),
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(pagePadding),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Text(
              'How to obtain?',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        )
      ],
    );
  }
}
