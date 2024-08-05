import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worldsocialintegrationapp/providers/generic_auth_provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/friends/friend_fans_following.dart';
import 'package:worldsocialintegrationapp/screens/home_container/friends/visitor_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/profile_detail_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/settings/settings_screen.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFE3400),
                Color(0xffFBC108),
              ],
            ),
          ),
        ),
        getProfileHeader(),
        Container(
          margin: const EdgeInsets.only(top: 180),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(pagePadding),
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(VisitorScreen.route);
                      },
                      child: getProfileMetric('Visitors', '1'),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(FriendFansFollowing.route, arguments: 0);
                      },
                      child: getProfileMetric('Friends', '2'),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(FriendFansFollowing.route, arguments: 1);
                      },
                      child: getProfileMetric('Following', '1'),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(FriendFansFollowing.route, arguments: 2);
                      },
                      child: getProfileMetric('Fan', '3'),
                    ),
                  ),
                ],
              ),
              verticalGap(pagePadding * 2),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/rechargecoins.svg',
                  width: 20,
                ),
                title: const Text(
                  'Recharge',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '1262',
                      style: TextStyle(fontSize: 12),
                    ),
                    horizontalGap(5),
                    Image.asset(
                      'assets/image/coins_img.png',
                      width: 16,
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/income.svg',
                  width: 20,
                ),
                title: const Text(
                  'Income',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '0',
                      style: TextStyle(fontSize: 12),
                    ),
                    horizontalGap(5),
                    Image.asset(
                      'assets/image/diamond.png',
                      width: 14,
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/userlevel.svg',
                  width: 20,
                ),
                title: const Text(
                  'User Level',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                indent: 50,
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/vip_1.svg',
                  width: 20,
                ),
                title: const Text(
                  'VIP Center',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Chip(
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  backgroundColor: Color(0xFFD5C09B),
                  label: Text(
                    'Daily Reward',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF645948),
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/badges.svg',
                  width: 20,
                ),
                title: const Text(
                  'Badge',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/mall.svg',
                  width: 20,
                ),
                title: const Text(
                  'Mall',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/mylook.svg',
                  width: 20,
                ),
                title: const Text(
                  'My Look',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {},
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                indent: 50,
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/family.svg',
                  width: 20,
                ),
                title: const Text(
                  'Family',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                leading: Image.asset(
                  'assets/image/onlineServices.png',
                  color: Colors.orange,
                  width: 20,
                ),
                title: const Text(
                  'Online Services',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Image.asset(
                  'assets/image/settings.png',
                  width: 20,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(SettingsScreen.route);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getProfileMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalGap(5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  SizedBox getProfileHeader() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Row(
        children: [
          horizontalGap(pagePadding),
          const CircularImage(
              imagePath: 'assets/dummy/girl.jpeg', diameter: 60),
          horizontalGap(pagePadding),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${GenericAuthProvider.instance.user?.displayName}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              verticalGap(5),
              Text(
                'ID: 873562893',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ProfileDeatilScreen.route);
            },
            icon: const Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
