import 'package:flutter/material.dart';

import '../../../utils/dimensions.dart';
import '../../../widgets/gaps.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        verticalGap(10),
        Row(
          children: [
            horizontalGap(10),
            Expanded(
              child: Image.asset(
                'assets/dummy/game1.png',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            horizontalGap(10),
            Expanded(
              child: Image.asset(
                'assets/dummy/game1.png',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            horizontalGap(10),
          ],
        ),
        getPopulerGamesButton(),
        Image.asset('assets/dummy/game1.png'),
        Image.asset('assets/dummy/game1.png'),
        Image.asset('assets/dummy/game1.png'),
      ],
    );
  }

  Padding getPopulerGamesButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: pagePadding,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xfff83302),
                      Color(0xfffbc100),
                      Color(0xfff83302),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Popular Games',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 1.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
