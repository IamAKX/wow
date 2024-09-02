import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/models/level_model.dart';

import '../../../widgets/gaps.dart';

class ReceivingScreen extends StatefulWidget {
  const ReceivingScreen({super.key, required this.levelModel});
  final LevelModel levelModel;

  @override
  State<ReceivingScreen> createState() => _ReceivingScreenState();
}

class _ReceivingScreenState extends State<ReceivingScreen> {
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
            Text(
              'LV.${widget.levelModel.reciveLevel ?? 1}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            horizontalGap(10),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: ((widget.levelModel.receiveRequiredExperience ?? 1) -
                        (widget.levelModel.reciveExp ?? 1)) /
                    (widget.levelModel.reciveEnd ?? 1),
                color: Colors.red,
                minHeight: 10,
                backgroundColor: Colors.red.withOpacity(0.4),
              ),
            ),
            horizontalGap(10),
            Text(
              'LV.${(widget.levelModel.reciveLevel ?? 1) + 1}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            )
          ],
        ),
        verticalGap(5),
        Text(
          '${((widget.levelModel.receiveRequiredExperience ?? 1) - (widget.levelModel.reciveExp ?? 1))} / ${(widget.levelModel.reciveEnd ?? 1)}',
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
                  'How to upgrade?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFF6F0FF),
                    child: Image.asset(
                      'assets/image/laugh_1.png',
                      width: 20,
                      color: const Color(0xFF9E50FF),
                    ),
                  ),
                  title: const Text(
                    'Received Gifts',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    '1 diamond = 5 Exp',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Text(
                    '+5',
                    style: TextStyle(
                      color: Color(0xFFC39955),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFF6F0FF),
                    child: Image.asset(
                      'assets/image/laugh_1.png',
                      width: 20,
                      color: const Color(0xFF9E50FF),
                    ),
                  ),
                  title: const Text(
                    'Received Tricks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    '1 diamond = 5 Exp',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Text(
                    '+5',
                    style: TextStyle(
                      color: Color(0xFFC39955),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
