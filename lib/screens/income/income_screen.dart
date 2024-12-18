import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/screens/income/diamond_help.dart';
import 'package:worldsocialintegrationapp/screens/income/live_record.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/button_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import '../../utils/helpers.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});
  static const String route = '/incomeScreen';

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  // UserProfileDetail? user;
  String exchangedGold = '0';
  String walletDiamond = '0';
  String walletCoin = '0';
  final TextEditingController editingController = TextEditingController();
  late ApiCallProvider apiCallProvider;
  late Razorpay _razorpay;
  bool isHost = false;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    editingController.addListener(() {
      if (editingController.text.isEmpty) {
        exchangedGold = '0';
      } else {
        exchangedGold = editingController.text;
      }
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // loadUserData();
      getHost();
      getWalletDetail();
    });
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showToastMessage('Payment Successful: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showToastMessage('Payment Failed: ${response.code} - ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showToastMessage('External Wallet Selected: ${response.walletName}');
  }

  // void initiateRazorPayPayment() {
  //   double amount = int.parse(user?.myDiamond ?? '0') / 1000 * 75;
  //   var options = {
  //     'key': 'rzp_test_usEmd5LTJQKCTA',
  //     'amount': 100, // amount * 100,
  //     'name': user?.name ?? '',
  //     'description': 'Requesting for withdrawl from ${user?.username}',
  //     'prefill': {'contact': '${user?.phone}', 'email': '${user?.email}'},
  //     'external': {
  //       'wallets': ['paytm']
  //     }
  //   };

  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // void loadUserData() async {
  //   await getCurrentUser().then(
  //     (value) {
  //       user = value;
  //       setState(() {});
  //     },
  //   );
  // }

  void getHost() async {
    Map<String, dynamic> reqBody = {};

    reqBody['userId'] = prefs.getString(PrefsKey.userId);

    await apiCallProvider.postRequest(API.getHost, reqBody).then((value) async {
      if (value['success'] == '1') {
        isHost = true;
      } else {
        isHost = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Income'),
        actions: [
          Visibility(
            visible: isHost,
            child: TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(LiveRecord.route);
              },
              child: const Text('Live Record'),
            ),
          )
        ],
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          color: Colors.grey.withOpacity(0.2),
          alignment: Alignment.center,
          child: const Text(
            'Diamonds available',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(25),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/image/new_diamond.png',
                width: 25,
                height: 25,
                fit: BoxFit.fill,
              ),
              horizontalGap(10),
              Text(
                walletDiamond,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.grey.withOpacity(0.2),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade200,
                    child: Image.asset(
                      'assets/image/new_diamond.png',
                      width: 25,
                      height: 25,
                      fit: BoxFit.fill,
                    ),
                  ),
                  horizontalGap(20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Diamonds Exchange',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      verticalGap(10),
                      const Text(
                        '*At least exchange 100 diamonds',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              verticalGap(20),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: (MediaQuery.of(context).size.width - 40) * 0.75,
                    decoration: const BoxDecoration(
                      color: Colors.white, // Background color for the container
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30), // Rounded left corners
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(0), // Square right corners
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    child: TextField(
                      controller: editingController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Enter exchange number',
                        hintStyle: TextStyle(fontSize: 12),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      editingController.text = walletDiamond;
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      width: (MediaQuery.of(context).size.width - 40) * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple
                            .shade200, // Background color for the container
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30), // Rounded left corners
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(0), // Square right corners
                          bottomLeft: Radius.circular(0),
                        ),
                      ),
                      child: const Text(
                        'All',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              verticalGap(20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade200,
                    child: Image.asset(
                      'assets/image/new_diamond.png',
                      width: 25,
                      height: 25,
                      fit: BoxFit.fill,
                    ),
                  ),
                  horizontalGap(20),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Redemption Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        verticalGap(10),
                        const Text(
                          '1. The gifts you receive will be automatically converted into diamonds',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        verticalGap(10),
                        const Text(
                          '2. Data is refreshed every 10 minutes',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        verticalGap(10),
                        const Text(
                          '3. Please note that the gifts received from rooms will be automatically converted into diamonds(not include lucky gifts.), the gifts received in moment will not be automatically converted into diamond temporarily.',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalGap(20),
              const Divider(
                thickness: 1,
                color: Colors.black26,
              ),
              verticalGap(20),
              Row(
                children: [
                  const Text(
                    'Exchange the gold:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  Image.asset(
                    'assets/image/coins_img.png',
                    width: 22,
                  ),
                  Expanded(
                    child: Text(
                      '$exchangedGold',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              verticalGap(20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: editingController.text.isEmpty
                      ? null
                      : () {
                          // initiateRazorPayPayment();
                          exchangeDiamond();
                        },
                  child: apiCallProvider.status == ApiStatus.loading
                      ? ButtonLoader()
                      : Text('EXCHANGE OF GOLDS'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: const Text(
                  'Coins available',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(25),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/image/coins_img.png',
                width: 25,
                height: 25,
                fit: BoxFit.fill,
              ),
              horizontalGap(10),
              Text(
                walletCoin,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          color: Colors.grey.withOpacity(0.2),
          alignment: Alignment.center,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(DiamondHelp.route);
                },
                child: Icon(
                  Icons.help_outline,
                  color: Colors.grey,
                ),
              ),
              const Text(
                'What\'s the use of diamonds?',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getWalletDetail() async {
    Map<String, dynamic> reqBody = {};
    reqBody['userId'] = prefs.getString(PrefsKey.userId);

    await apiCallProvider
        .postRequest(API.getWalletDetails, reqBody)
        .then((value) {
      if (value['status'] == '1') {
        walletDiamond = value['details']['myDiamond'];
        walletCoin = value['details']['myCoin'];
        setState(() {});
      }
    });
  }

  exchangeDiamond() async {
    Map<String, dynamic> reqBody = {};
    reqBody['userId'] = prefs.getString(PrefsKey.userId);
    reqBody['myDiamond'] = editingController.text;

    await apiCallProvider
        .postRequest(API.exchangeCoins, reqBody)
        .then((value) async {
      showToastMessage(value['message'] ?? '');
      if (value['status'] == '1') {
        editingController.text = '';
        await getWalletDetail();
        setState(() {});
      }
    });
  }
}
