import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/income/diamond_help.dart';
import 'package:worldsocialintegrationapp/screens/income/live_record.dart';
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
  String exchangedGold = '0';
  final TextEditingController editingController = TextEditingController();
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    editingController.addListener(() {
      if (editingController.text.isEmpty) {
        exchangedGold = '0';
      } else {
        exchangedGold = editingController.text;
      }
      setState(() {});
    });

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
            onPressed: () {
              Navigator.of(context).pushNamed(LiveRecord.route);
            },
            child: const Text('Live Record'),
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
                      editingController.text = user?.myDiamond ?? '';
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
                  onPressed: () {},
                  child: Text('EXCHANGE OF GOLDS'),
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
                user?.myCoin ?? '0',
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
                  Navigator.of(context).pushNamed(DiamondHelp.route);
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
}
