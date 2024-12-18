import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:worldsocialintegrationapp/models/coin_model.dart';
import 'package:worldsocialintegrationapp/utils/colors.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/coin_billing_model.dart';
import '../../models/user_profile_detail.dart';
import '../../models/wallet_model.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import '../../utils/helpers.dart';
import '../../utils/prefs_key.dart';

class CoinBilling extends StatefulWidget {
  const CoinBilling({super.key});

  @override
  State<CoinBilling> createState() => _CoinBillingState();
}

class _CoinBillingState extends State<CoinBilling> {
  late ApiCallProvider apiCallProvider;
  List<CoinBillingModel> list = [];

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
        .postRequest(API.userBillingRecords, reqBody)
        .then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(CoinBillingModel.fromJson(item));
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
              list.elementAt(index).created ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  list.elementAt(index).coins ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
                Image.asset(
                  'assets/image/coins_img.png',
                  width: 20,
                ),
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
