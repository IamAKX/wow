import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:worldsocialintegrationapp/models/coin_model.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/generate_order_model.dart';
import '../../models/user_profile_detail.dart';
import '../../models/wallet_model.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import '../../utils/helpers.dart';
import '../../utils/prefs_key.dart';

class Coins extends StatefulWidget {
  const Coins({super.key});

  @override
  State<Coins> createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  late ApiCallProvider apiCallProvider;
  List<CoinModel> coins = [];
  UserProfileDetail? user;
  late Razorpay _razorpay;
  WalletModel? walletModel;
  String selectedAmount = '0';

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getWalletDetails();
      getCoins();
      loadUserData();
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('Payment details : ${response.data}');
    debugPrint('orderId details : ${response.orderId}');
    debugPrint('paymentId details : ${response.paymentId}');
    debugPrint('signature details : ${response.signature}');
    showToastMessage('Payment Successful: ${response.paymentId}');
    purchaseCoin(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showToastMessage(
        'Payment Failed: ${response.error?['code']} - ${response.error?['reason']}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showToastMessage('External Wallet Selected: ${response.walletName}');
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  getCoins() async {
    coins.clear();
    await apiCallProvider.getRequest(API.getCoinValue).then((value) {
      if (value['details'] != null) {
        for (var item in value['details']) {
          coins.add(CoinModel.fromMap(item));
        }
        setState(() {});
      }
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
    return apiCallProvider.status == ApiStatus.loading
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
                'assets/image/coins_img.png',
                width: 25,
              ),
              horizontalGap(10),
              Text(
                walletModel?.walletAmount ?? '',
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
                  selectedAmount = coins.elementAt(index).id ?? '0';
                  orderIdGenerate(coins.elementAt(index).moneyValue ?? '0');
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/coins_img.png',
                          width: 20,
                        ),
                        Text(
                          coins.elementAt(index).coinValue ?? '0',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '₹ ${coins.elementAt(index).moneyValue ?? '0'}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
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

  void initiateRazorPayPayment(
    String amount,
    GenerateOrderModel? generateOrderModel,
  ) {
    var options = {
      'key': generateOrderModel?.key ?? 'rzp_test_usEmd5LTJQKCTA',
      'amount': '${amount}00',
      'name': user?.name ?? '',
      'order_id': generateOrderModel?.orderId ?? '',
      'description': 'Requesting for withdrawl from ${user?.username}',
      'prefill': {'contact': '${user?.phone}', 'email': '${user?.email}'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getWalletDetails() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};

    await apiCallProvider.postRequest(API.getUserWallet, reqBody).then((value) {
      if (value['details'] != null) {
        walletModel = WalletModel.fromJson(value['details'][0]);
        setState(() {});
      }
    });
  }

  GenerateOrderModel? generateOrderModel;
  void orderIdGenerate(String amount) async {
    Map<String, dynamic> reqBody = {'amount': amount};

    await apiCallProvider
        .postRequest(API.orderIdGenerate, reqBody)
        .then((value) {
      if (value['success'] == '1') {
        generateOrderModel = GenerateOrderModel.fromJson(value);
        setState(() {});
        initiateRazorPayPayment(amount, generateOrderModel);
      }
    });
  }

  purchaseCoin(PaymentSuccessResponse response) async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'wallet_amount': selectedAmount,
      'razorpay_order_id': response.orderId,
      'razorpay_payment_id': response.paymentId,
      'razorpay_signature': response.signature
    };

    await apiCallProvider
        .postRequest(API.purchaseGoldCoins, reqBody)
        .then((value) {
      if (value['success'] == '1') {
        setState(() {});
        getWalletDetails();
        getCoins();
        loadUserData();
      }
    });
  }
}
