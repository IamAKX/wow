import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class GiftWall extends StatefulWidget {
  const GiftWall({super.key});
  static const String route = '/giftWall';

  @override
  State<GiftWall> createState() => _GiftWallState();
}

class _GiftWallState extends State<GiftWall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text(
          'Gift Wall',
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF00EE),
                Color(0xFF9600FF),
              ],
            ),
          ),
        ),
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Image.asset(
                'assets/image/gift_wall_image.png',
                height: 80,
              ),
            ),
            verticalGap(50),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '''1. What is the gift wall?
A single gift of more than 5,000 coins will appear on the gift wall!
            
2. How to grab the front row of the gift wall?
The larger the number of gold coins in a single gift, the more advanced the display.
            
3. How long will the records on the gift will be kept?
24 Hours''',
                textAlign: TextAlign.left,
              ),
            ),
          ],
        )
      ],
    );
  }
}
