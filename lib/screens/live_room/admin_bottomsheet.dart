import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class AdminBottomsheet extends StatefulWidget {
  const AdminBottomsheet({super.key});

  @override
  State<AdminBottomsheet> createState() => _AdminBottomsheetState();
}

class _AdminBottomsheetState extends State<AdminBottomsheet> {
  String prompt =
      '''1. Way to add: Cilck on Add as admin at mini profile of any users in the room:
2. Permanently valid unless you remove him;
3. You can set up 8 admins. 1 admin can be set for each
30 charming level increased; 4. Admin privileges in this room:
(1) Kick out from the seat;
(2) Kick out from the room;
(3) Ban from chatting;
(4) Set voice effect;''';

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6, // Set height to 60% of screen height
      child: ClipRRect(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Admin',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              verticalGap(20),
              const Text(
                'Rules',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              verticalGap(10),
              Text(prompt),
            ],
          ),
        ),
      ),
    );
  }
}
