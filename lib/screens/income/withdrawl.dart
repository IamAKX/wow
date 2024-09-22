import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:worldsocialintegrationapp/screens/income/bank_details.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';

import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/generic_api_calls.dart';

class WithdrawlScreen extends StatefulWidget {
  const WithdrawlScreen({super.key});
  static const String route = '/withdrawlScreen';

  @override
  State<WithdrawlScreen> createState() => _WithdrawlScreenState();
}

class _WithdrawlScreenState extends State<WithdrawlScreen> {
  UserProfileDetail? user;
  int selectedIndex = -1;
  late Razorpay _razorpay;

  late ApiCallProvider apiCallProvider;
  List<AmountCard> amountCardList = [
    AmountCard(id: 0, title: '32,000 Diamond', subtitle: 'Rs 2400 (INR)'),
    AmountCard(id: 1, title: '70,000 Diamond', subtitle: 'Rs 5250 (INR)'),
    AmountCard(id: 2, title: '2,00,000 Diamond', subtitle: 'Rs 15,000 (INR)'),
    AmountCard(
        id: 3,
        title: 'Custom',
        subtitle: '(In the multiple of\n1,000 Diamonds = 75\nRs INR)'),
  ];

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
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

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Withdraw'),
        actions: [
          TextButton(
            onPressed: () {
              initiateRazorPayPayment();
            },
            child: const Text('Proceed'),
          ),
        ],
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            'Balance',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/image/new_diamond.png',
                width: 25,
                height: 25,
                fit: BoxFit.fill,
              ),
              horizontalGap(5),
              Text(
                user?.myDiamond ?? '0',
                style: const TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
        verticalGap(20),
        Container(
          color: Colors.grey.shade100,
          height: 10,
          width: double.infinity,
        ),
        verticalGap(20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            'Withdraw To',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(BankDetails.route);
            },
            title: const Text(
              'Withdraw',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'You are expected to receive it in 7 working days',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            leading: Image.asset(
              'assets/image/coins_img.png',
              width: 40,
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            'Coin Dealer',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListTile(
            onTap: () {},
            title: const Text(
              'Please select the coin seller information',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        GridView.builder(
          padding: const EdgeInsets.all(10),
          primary: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1.3),
          itemCount: amountCardList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Card(
                elevation: index == selectedIndex ? 20 : 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      amountCardList.elementAt(index).title ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      amountCardList.elementAt(index).subtitle ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void initiateRazorPayPayment() {
    var options = {
      'key': 'rzp_test_usEmd5LTJQKCTA', 
      'amount': 100, 
      'name': user?.name ?? '',
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
}

class AmountCard {
  String? title;
  String? subtitle;
  int? id;
  AmountCard({
    this.title,
    this.subtitle,
    this.id,
  });

  AmountCard copyWith({
    String? title,
    String? subtitle,
    int? id,
  }) {
    return AmountCard(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (title != null) {
      result.addAll({'title': title});
    }
    if (subtitle != null) {
      result.addAll({'subtitle': subtitle});
    }
    if (id != null) {
      result.addAll({'id': id});
    }

    return result;
  }

  factory AmountCard.fromMap(Map<String, dynamic> map) {
    return AmountCard(
      title: map['title'],
      subtitle: map['subtitle'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AmountCard.fromJson(String source) =>
      AmountCard.fromMap(json.decode(source));

  @override
  String toString() =>
      'AmountCard(title: $title, subtitle: $subtitle, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AmountCard &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ subtitle.hashCode ^ id.hashCode;
}
