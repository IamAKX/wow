import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:worldsocialintegrationapp/models/coin_model.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/coin_billing_model.dart';
import '../../models/silver_coin_billing_model.dart';
import '../../models/user_profile_detail.dart';
import '../../models/wallet_model.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import '../../utils/helpers.dart';
import '../../utils/prefs_key.dart';

class SilverCoinBilling extends StatefulWidget {
  const SilverCoinBilling({super.key});

  @override
  State<SilverCoinBilling> createState() => _SilverCoinBillingState();
}

class _SilverCoinBillingState extends State<SilverCoinBilling> {
  late ApiCallProvider apiCallProvider;
  List<SilverCoinBillingModel> list = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  loadData() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    list.clear();
    await apiCallProvider
        .postRequest(API.getSilverCoinHistory, reqBody)
        .then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(SilverCoinBillingModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return apiCallProvider.status == ApiStatus.loading
        ? const DefaultPageLoader()
        : getBody(context);
  }

  getBody(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            title: Text(
              list.elementAt(index).message ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              list.elementAt(index).createdAt ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      list.elementAt(index).silverCoin ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                    Image.asset(
                      'assets/image/silver_img.png',
                      width: 14,
                    ),
                  ],
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Text(
                //       list.elementAt(index).goldCoin ?? '',
                //       style: const TextStyle(
                //         fontWeight: FontWeight.bold,
                //         color: Colors.blue,
                //         fontSize: 14,
                //       ),
                //     ),
                //     Image.asset(
                //       'assets/image/coins_img.png',
                //       width: 15,
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: hintColor,
          );
        },
        itemCount: list.length);
  }
}
