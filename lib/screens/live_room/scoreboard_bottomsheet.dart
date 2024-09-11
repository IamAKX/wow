import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class ScoreboardBottomsheet extends StatefulWidget {
  const ScoreboardBottomsheet({super.key});

  @override
  State<ScoreboardBottomsheet> createState() => _ScoreboardBottomsheetState();
}

class _ScoreboardBottomsheetState extends State<ScoreboardBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7, // Set height to 60% of screen height
      child: ClipRRect(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Color(0xFFC39955),
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Text(
                      'History',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 20,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          CircularImage(imagePath: '', diameter: 40),
                          horizontalGap(20),
                          Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Image.asset('assets/image/diamond.png'),
                          Text(
                            '700',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          horizontalGap(10),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
