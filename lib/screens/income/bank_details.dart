import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/bank_list.dart';

import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/generic_api_calls.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});
  static const String route = '/bankDetails';

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  UserProfileDetail? user;

  late ApiCallProvider apiCallProvider;

  final TextEditingController _accountNoCtrl = TextEditingController();
  final TextEditingController _bankNameCtrl = TextEditingController();
  final TextEditingController _cardHolderCtrl = TextEditingController();
  final TextEditingController _ifscCtrl = TextEditingController();

  String selectedBank = "Select a bank";

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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Withdraw'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Card holder*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextField(
                  decoration: const InputDecoration(
                    hintText: 'Card holder*',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  controller: _cardHolderCtrl),
              Divider(
                color: Colors.grey,
              ),
              const Text(
                'Bank name*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextField(
                  decoration: const InputDecoration(
                    hintText: 'Bank name*',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _showBankSelectionMenu(context);
                  },
                  readOnly: true,
                  controller: _bankNameCtrl),
              Divider(
                color: Colors.grey,
              ),
              const Text(
                'Bank account*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextField(
                  decoration: const InputDecoration(
                    hintText: 'Bank account*',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  controller: _accountNoCtrl),
              Divider(
                color: Colors.grey,
              ),
              const Text(
                'IFSC code*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextField(
                  decoration: const InputDecoration(
                    hintText: 'IFSC code*',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  controller: _ifscCtrl),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Please make sure all the information filled is correct. Your salary claiming might be affected if there is any mistake.',
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        verticalGap(20),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFF07C431),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        verticalGap(40),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {},
            child: const Text(
              'Help',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
          ),
        ),
        verticalGap(20),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Contact us if you have any question.:\nwow@wow.com',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  // Function to show the popup menu with the list of banks
  void _showBankSelectionMenu(BuildContext context) async {
    _bankNameCtrl.text = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(100, 100, 100, 100),
          items: bankList.map((String bank) {
            return PopupMenuItem<String>(
              value: bank,
              child: Text(bank),
            );
          }).toList(),
        ) ??
        '';
  }
}
