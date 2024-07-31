import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class MeetScreen extends StatefulWidget {
  const MeetScreen({super.key});

  @override
  State<MeetScreen> createState() => _MeetScreenState();
}

class _MeetScreenState extends State<MeetScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Top Trending Broadcasters',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.8),
            itemCount: 51,
            itemBuilder: (context, index) {
              return getProfileItem();
            },
          ),
        ),
      ],
    );
  }

  Column getProfileItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/dummy/girl.jpeg',
                width: 80,
                height: 80,
              ),
            ),
            Positioned(
              right: -13,
              bottom: -13,
              child: Image.asset(
                'assets/image/ic_icon_check.png',
                width: 50,
              ),
            ),
          ],
        ),
        verticalGap(5),
        const Text(
          'Deepika',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person,
              color: Colors.grey,
              size: 18,
            ),
            Text(
              '55',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
