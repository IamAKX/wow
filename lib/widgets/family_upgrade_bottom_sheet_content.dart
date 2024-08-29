import 'package:flutter/material.dart';

class FamilyUpgradeBottomSheetContent extends StatelessWidget {
  FamilyUpgradeBottomSheetContent({super.key});

  List list = [
    {'task': 'Daily login', 'points': '+20🔥'},
    {
      'task': 'Every 10 minutes watched daily',
      'points': '+50🔥 / up to +250🔥 per day'
    },
    {
      'task': 'Every 10 minutes on-mic daily',
      'points': '+150🔥 / up to +750🔥 per day'
    },
    {'task': 'Recharge', 'points': '+1💰=+1🔥'},
    {'task': 'Send gifts', 'points': '+1💰=+1🔥'},
  ];

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Colors.grey,
        width: 1,
        borderRadius: BorderRadius.circular(10),
      ), // All borders

      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(
            color: Colors.white, // Header background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tasks',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Points',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
        for (var item in list)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${item['task']}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xFF00DA39), fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${item['points']}',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
