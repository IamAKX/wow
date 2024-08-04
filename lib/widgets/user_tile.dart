import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_detail_screen.dart/user_detail_screen.dart';

import 'circular_image.dart';
import 'gaps.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircularImage(
          imagePath: 'assets/dummy/girl.jpeg', diameter: 40),
      title: const Text(
        'Test User',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(UserDeatilScreen.route),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: const BoxDecoration(
                color: Color(0xFF0FDEA5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.male,
                  color: Colors.white,
                  size: 12,
                ),
                horizontalGap(5),
                const Text(
                  '27',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
          horizontalGap(5),
          Container(
            width: 60,
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/image/level_1.png',
                  ),
                  fit: BoxFit.fill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/image/coins_img.png',
                  width: 12,
                ),
                horizontalGap(5),
                const Text(
                  '22',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ),
          horizontalGap(10),
          Container(
            width: 60,
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/image/level_9.png',
                  ),
                  fit: BoxFit.fill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/image/coins_img.png',
                  width: 12,
                ),
                horizontalGap(5),
                const Text(
                  '22',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
