import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/how_to_level_up.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';

import '../../../main.dart';
import '../../../models/car_by_level.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/prefs_key.dart';

class UserLevelCars extends StatefulWidget {
  const UserLevelCars({super.key});
  static const String route = '/userLevelCars';

  @override
  State<UserLevelCars> createState() => _UserLevelCarsState();
}

class _UserLevelCarsState extends State<UserLevelCars> {
  late ApiCallProvider apiCallProvider;
  List<CarByLevel> carList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCarByLevel();
    });
  }

  getCarByLevel() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    apiCallProvider.postRequest(API.getCarsByLevel, reqBody).then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          carList.add(CarByLevel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.orange,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Cars'),
      ),
      body: apiCallProvider.status == ApiStatus.loading
          ? const DefaultPageLoader()
          : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.7,
            ),
            itemCount: carList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5C8D3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          color: Color(0xFFFF9B55),
                          size: 15,
                        ),
                        InkWell(
                          onTap: () => showPreviewPopup(
                              carList.elementAt(index).image ?? ''),
                          child: const Text(
                            'Preview',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        width: 80,
                        // child: SVGASimpleImage(
                        //   resUrl:
                        //       'https://github.com/yyued/SVGA-Samples/blob/master/angel.svga?raw=true',
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: carList.elementAt(index).image ?? '',
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Text('Error ${error.toString()}'),
                          ),
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Text(
                      '${carList.elementAt(index).validity}(s)',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Unlock LV ${carList.elementAt(index).level}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, HowToLevelUp.route),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(pagePadding),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: const Text(
              'How to obtain?',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        )
      ],
    );
  }

  void showPreviewPopup(String link) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.width - 40,
            // child: SVGASimpleImage(
            //   resUrl: link,
            // ),
            child: CachedNetworkImage(
              imageUrl: link,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Center(
                child: Text('Error ${error.toString()}'),
              ),
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.width - 40,
            ),
          ),
        );
      },
    );
  }
}
