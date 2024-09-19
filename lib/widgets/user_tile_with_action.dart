import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/models/visitor_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_detail_screen/other_user_detail_screen.dart';

import 'circular_image.dart';
import 'gaps.dart';

class UserTileWithAction extends StatelessWidget {
  const UserTileWithAction({
    super.key,
    required this.visitorModel,
    required this.trailingWidget,
  });
  final VisitorModel visitorModel;
  final Widget trailingWidget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularImage(imagePath: visitorModel.image ?? '', diameter: 40),
      title: Text(
        visitorModel.name ?? '',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailingWidget,
      onTap: () => Navigator.of(context).pushNamed(OtherUserDeatilScreen.route,
          arguments: visitorModel.id ?? ''),
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
          if ((visitorModel.sendLevel ?? '0') != '0')
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
                  Text(
                    (visitorModel.sendLevel ?? '0'),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
          horizontalGap(5),
          if ((visitorModel.reciveLevel ?? '0') != '0')
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
                  Text(
                    (visitorModel.reciveLevel ?? '0'),
                    style: const TextStyle(
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
