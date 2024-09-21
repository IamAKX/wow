import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/generic_api_calls.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});
  static const String route = '/incomeScreen';

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  UserProfileDetail? user;

  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
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
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Income'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Live Record'),
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
          padding: EdgeInsets.all(10),
          color: Colors.grey.withOpacity(0.3),
          alignment: Alignment.center,
          child: const Text(
            'Diamonds available',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(25),
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
                user?.myDiamond ?? '0',
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
          color: Colors.grey.withOpacity(0.3),
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
                      Text(
                        'Diamonds Exchange',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      verticalGap(10),
                      Text(
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
                      Text(
                        'Redemption Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      verticalGap(10),
                      Text(
                        '*At least exchange 100 diamonds',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
