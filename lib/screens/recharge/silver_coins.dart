import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/coin_model.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import '../../utils/prefs_key.dart';

class SilverCoins extends StatefulWidget {
  const SilverCoins({super.key});

  @override
  State<SilverCoins> createState() => _SilverCoinsState();
}

class _SilverCoinsState extends State<SilverCoins> {
  late ApiCallProvider apiCallProvider;
  List<CoinModel> coins = [];
  UserProfileDetail? user;
  String silverCoins = '0';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCoins();
      loadUserData();
      getWalletDetails();
    });
  }

  getCoins() async {
    coins.clear();
    await apiCallProvider.getRequest(API.getSilverCoinValue).then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          coins.add(CoinModel.fromMap(item));
        }
        setState(() {});
      }
    });
  }

  purchaseSilverCoins(String coinValue, String id) async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'coinId': id
    };

    await apiCallProvider
        .postRequest(API.purchaseSilverCoin, reqBody)
        .then((value) {
      showToastMessage(value['message']);
      getWalletDetails();
    });
  }

  void loadUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return apiCallProvider.status == ApiStatus.loading && coins.isEmpty
        ? const DefaultPageLoader()
        : getBody(context);
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFE3400),
                Color(0xffFBC108),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/image/silver_img.png',
                width: 25,
              ),
              horizontalGap(10),
              Text(
                silverCoins,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.95,
            ),
            itemCount: coins.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  purchaseSilverCoins(coins.elementAt(index).moneyValue ?? '',
                      coins.elementAt(index).id ?? '');
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/silver_img.png',
                          width: 20,
                        ),
                        Text(
                          coins.elementAt(index).moneyValue ?? '0',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/image/coins_img.png',
                              width: 16,
                            ),
                            horizontalGap(5),
                            Text(
                              '${coins.elementAt(index).coinValue ?? '0'}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void getWalletDetails() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};

    await apiCallProvider
        .postRequest(API.getTotalSilverCoins, reqBody)
        .then((value) {
      if (value['details'] != null) {
        silverCoins = value['details']['coinValue'];
        setState(() {});
      }
    });
  }
}
