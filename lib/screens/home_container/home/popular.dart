// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/event_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/family_leaderboard.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => {},
        child: Image.asset(
          'assets/image/spinnwheell.png',
          width: 60,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          getCarousel(),
          getFamilyEventButton(),
          Container(
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            child: Text(
              'Live Not Found',
              style: TextStyle(
                color: Color(0xff575252),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding getFamilyEventButton() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, FamilyLeaderboard.route);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: pagePadding,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xff4f007a),
                      Color(0xff8e3dc2),
                      Color(0xff4f007a),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Family',
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
          horizontalGap(10),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, EventScreen.route);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: pagePadding,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
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
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Events',
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

  FlutterCarousel getCarousel() {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 180.0,
        showIndicator: true,
        autoPlay: true,
        pageSnapping: true,
        floatingIndicator: true,
        viewportFraction: 1,
        slideIndicator: const CircularSlideIndicator(
          slideIndicatorOptions: SlideIndicatorOptions(
              currentIndicatorColor: Color(0xffFA03E6),
              indicatorBackgroundColor: Colors.white),
        ),
      ),
      items: [
        'assets/dummy/banner1.jpeg',
        'assets/dummy/banner2.jpeg',
        'assets/dummy/banner3.jpeg',
        'assets/dummy/banner4.jpeg',
        'assets/dummy/banner5.jpeg'
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Image.asset(
              i,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            );
          },
        );
      }).toList(),
    );
  }
}
