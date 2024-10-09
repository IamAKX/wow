import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../widgets/inward_curve_clipper.dart';

class VipOptions extends StatefulWidget {
  const VipOptions({super.key});

  @override
  State<VipOptions> createState() => _VipOptionsState();
}

class _VipOptionsState extends State<VipOptions> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://c4.wallpaperflare.com/wallpaper/620/81/253/pattern-design-dark-texture-wallpaper-preview.jpg',
          errorWidget: (context, url, error) => Center(
            child: Text('Error ${error.toString()}'),
          ),
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShapeOfView(
                elevation: 0,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                shape: ArcShape(
                    direction: ArcDirection.Outside,
                    height: 30,
                    position: ArcPosition.Top),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/image/vip_privileges.png'),
                              fit: BoxFit.fill),
                        ),
                        child: Text(
                          'Privileges',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      verticalGap(10),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 1.5),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.punch_clock_outlined,
                                    size: 30,
                                    color: Color(0xFFC5A36C),
                                  ),
                                  Text(
                                    'Some text',
                                    style: TextStyle(
                                        color: Color(0xFFC5A36C),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
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
              const Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '60000 coins / 30 days',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'You are not VIP1',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('SEND'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFC5A36C)),
                          foregroundColor: const Color(0xFFC5A36C),
                        ),
                      ),
                      horizontalGap(10),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('BUY'),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xFFC5A36C)),
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
