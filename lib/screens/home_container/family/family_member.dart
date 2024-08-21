import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/widgets/categorized_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';

import '../../../providers/api_call_provider.dart';
import '../../../widgets/gaps.dart';

class FamilyMemberScreen extends StatefulWidget {
  const FamilyMemberScreen({super.key});
  static const String route = '/familyMemberScreen';

  @override
  State<FamilyMemberScreen> createState() => _FamilyMemberScreenState();
}

class _FamilyMemberScreenState extends State<FamilyMemberScreen> {
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Todo: call api after screen load
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Members'),
          actions: [],
        ),
        body: getBody(context));
  }

  getBody(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const CategorizedCircularImage(
              imagePath:
                  'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?cs=srgb&dl=pexels-andrewpersonaltraining-697509.jpg&fm=jpg',
              imageSize: 50,
              categoryPath: 'assets/image/lion.png'),
          title: const Text(
            'Test 1',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
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
                      size: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(10),
              Container(
                constraints: const BoxConstraints(minWidth: 50),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                      width: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(5),
              Container(
                constraints: const BoxConstraints(minWidth: 50),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                      width: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          trailing: Container(
            width: 60,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/family_points_border.png'),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '0',
                  style: TextStyle(fontSize: 10),
                ),
                horizontalGap(2),
                Image.asset(
                  'assets/image/fire.png',
                  width: 9,
                )
              ],
            ),
          ),
        ),
        ListTile(
          leading: const CircularImage(
            imagePath:
                'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?cs=srgb&dl=pexels-andrewpersonaltraining-697509.jpg&fm=jpg',
            diameter: 50,
          ),
          title: const Text(
            'Test 2',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              Image.asset(
                'assets/image/fire.png',
                width: 20,
              ),
              horizontalGap(10),
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
                      size: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(10),
              Container(
                constraints: const BoxConstraints(minWidth: 50),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                      width: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(5),
              Container(
                constraints: const BoxConstraints(minWidth: 50),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                      width: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          trailing: Container(
            width: 60,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/family_points_border.png'),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '0',
                  style: TextStyle(fontSize: 10),
                ),
                horizontalGap(2),
                Image.asset(
                  'assets/image/fire.png',
                  width: 9,
                )
              ],
            ),
          ),
        ),
        ListTile(
          leading: const CircularImage(
            imagePath:
                'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?cs=srgb&dl=pexels-andrewpersonaltraining-697509.jpg&fm=jpg',
            diameter: 50,
          ),
          title: const Text(
            'Test 3',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
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
                      size: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(10),
              Container(
                constraints: const BoxConstraints(minWidth: 50),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                      width: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(5),
              Container(
                constraints: const BoxConstraints(minWidth: 50),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                      width: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '22',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          trailing: Container(
            width: 60,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/family_points_border.png'),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '0',
                  style: TextStyle(fontSize: 10),
                ),
                horizontalGap(2),
                Image.asset(
                  'assets/image/fire.png',
                  width: 9,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
