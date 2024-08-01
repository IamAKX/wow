// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                pagePadding, pagePadding / 2, pagePadding / 2, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Gift Wall',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton.icon(
                  onPressed: () {},
                  label: const Text(
                    'More',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin:
                EdgeInsets.fromLTRB(pagePadding, 0, pagePadding, pagePadding),
            decoration: BoxDecoration(
                color: Color(0xFFFAF4FF),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getProfileCouple(),
                getProfileCouple(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: pagePadding),
            child: const Text(
              'Countries',
              style: TextStyle(fontSize: 16),
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.all(10),
            primary: true,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFFF5F7F9),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/image/canada1.png',
                      width: 20,
                    ),
                    horizontalGap(5),
                    Text('Canada')
                  ],
                ),
              );
            },
          ),
          verticalGap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: pagePadding),
            child: const Text(
              'New',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Column getProfileCouple() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: Stack(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularImage(
                        imagePath: 'assets/dummy/girl.jpeg', diameter: 60),
                    horizontalGap(10),
                    CircularImage(
                        imagePath: 'assets/dummy/girl.jpeg', diameter: 60),
                  ],
                ),
              ),
              Container(
                width: 130,
                height: 60,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/image/lion.png',
                  width: 30,
                ),
              )
            ],
          ),
        ),
        verticalGap(5),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/image/money.png',
              width: 14,
            ),
            horizontalGap(5),
            Text(
              '1055486',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
