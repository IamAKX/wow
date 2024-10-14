import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'package:worldsocialintegrationapp/models/visitor_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_detail_screen/other_user_detail_screen.dart';

import '../models/friend_model.dart';
import 'circular_image.dart';
import 'gaps.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.visitorModel,
  });
  final FriendModel visitorModel;

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
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
          OtherUserDeatilScreen.route,
          arguments: visitorModel.id ?? ''),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
                color: visitorModel.gender == 'Male'
                    ? Color(0xFF0FDEA5)
                    : Color.fromARGB(255, 245, 97, 250),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  visitorModel.gender == 'Male' ? Icons.male : Icons.female,
                  color: Colors.white,
                  size: 12,
                ),
                horizontalGap(5),
                Text(
                  '${visitorModel.age}',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
          horizontalGap(5),
          if ((visitorModel.lavelInformation?.sendLevel ?? '0') != '0')
            Container(
              width: 60,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(
                      visitorModel.lavelInformation?.sandBgImage ?? '',
                    ),
                    fit: BoxFit.fill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/image/starlevel.png',
                    width: 12,
                  ),
                  horizontalGap(5),
                  Text(
                    '${visitorModel.lavelInformation?.sendLevel}',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
          horizontalGap(5),
          if ((visitorModel.lavelInformation?.reciveLevel ?? '0') != '0')
            Container(
              width: 60,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(
                      visitorModel.lavelInformation?.reciveBgImage ?? '',
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
                    '${visitorModel.lavelInformation?.reciveLevel}',
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