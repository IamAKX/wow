import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../models/spin_data_model.dart';

class SpinwheelWinnerPopup extends StatefulWidget {
  const SpinwheelWinnerPopup({super.key, required this.spinDataModel});
  final SpinDataModel spinDataModel;

  @override
  State<SpinwheelWinnerPopup> createState() => _SpinwheelWinnerPopupState();
}

class _SpinwheelWinnerPopupState extends State<SpinwheelWinnerPopup> {
  double randomInRange(double min, double max) {
    return min + Random().nextDouble() * (max - min);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      launchConfetti();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity, // Full width
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/image/bg_dashboard.jpg',
              height: double.infinity,
              fit: BoxFit.fitHeight,
            ),
            Image.asset(
              'assets/image/bg_header_small.png',
              fit: BoxFit.fill,
              height: 100,
              width: double.infinity,
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Result',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  'assets/image/btn_close.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
            Positioned(
              top: 150,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/image/rays.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(80),
                    width: 350,
                    height: 350,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/image/paper.png',
                          ),
                          fit: BoxFit.fill),
                    ),
                    child: Container(
                      width: 250,
                      height: 250,
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/image/leaves.png',
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: const BorderedCircularImage(
                          imagePath: '',
                          diameter: 200,
                          borderColor: Colors.white,
                          borderThickness: 2),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 420,
              left: MediaQuery.of(context).size.width / 2 - 80,
              child: Container(
                height: 50,
                width: 130,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/bg_coin_profile.png'),
                  ),
                ),
                child: Text(
                  '    ${widget.spinDataModel.header ?? ''} ${widget.spinDataModel.subtitle ?? ''}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              alignment: Alignment.center,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Congratulations...',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    verticalGap(10),
                    Image.asset(
                      'assets/image/txt_youwin.png',
                      width: 180,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void launchConfetti() async {
    for (int i = 0; i < 10; i++) {
      Confetti.launch(
        context,
        options: ConfettiOptions(
            angle: randomInRange(55, 125),
            spread: randomInRange(50, 70),
            particleCount: randomInRange(50, 100).toInt(),
            y: 1),
      );
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
