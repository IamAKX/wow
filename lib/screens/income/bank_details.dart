import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/bank_list.dart';
import 'package:worldsocialintegrationapp/widgets/button_loader.dart';

import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/bank_detail_model.dart';
import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/generic_api_calls.dart';
import '../../utils/helpers.dart';

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
  final TextEditingController _confAccountNoCtrl = TextEditingController();
  final TextEditingController _branchNameCtrl = TextEditingController();
  final TextEditingController _bankNameCtrl = TextEditingController();
  final TextEditingController _cardHolderCtrl = TextEditingController();
  final TextEditingController _accountType = TextEditingController();
  final TextEditingController _ifscCtrl = TextEditingController();

  String selectedBank = 'Select a bank';
  String accounType = 'savings';
  BankDetailsModel? bankDetailsModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  getBankDetails() async {
    Map<String, dynamic> reqBody = {};

    reqBody['userId'] = user?.id;

    await apiCallProvider
        .postRequest(API.getUserBankDetails, reqBody)
        .then((value) async {
      if (value['success'] == '1') {
        bankDetailsModel = BankDetailsModel.fromJson(value['details']);

        _accountNoCtrl.text = bankDetailsModel?.accountNumber ?? '';
        _confAccountNoCtrl.text = bankDetailsModel?.accountNumber ?? '';
        _branchNameCtrl.text = bankDetailsModel?.branchName ?? '';
        _bankNameCtrl.text = bankDetailsModel?.bankName ?? '';
        _cardHolderCtrl.text = bankDetailsModel?.accountHolderName ?? '';
        _accountType.text = bankDetailsModel?.accountType ?? '';
        _ifscCtrl.text = bankDetailsModel?.ifscCode ?? '';

        setState(() {});
      }
      showToastMessage(value['message']);
    });
  }

  void loadUserData() async {
    await getCurrentUser().then(
      (value) async {
        user = value;
        await getBankDetails();
        setState(() {});
      },
    );
  }

  void saveBankDetails() async {
    Map<String, dynamic> reqBody = {};

    reqBody['userId'] = user?.id;
    reqBody['accHolderName'] = _cardHolderCtrl.text;
    reqBody['accNumber'] = _accountNoCtrl.text;
    reqBody['confirmAccNumber'] = _confAccountNoCtrl.text;
    reqBody['bankName'] = _bankNameCtrl.text;
    reqBody['branchName'] = _branchNameCtrl.text;
    reqBody['ifscCode'] = _ifscCtrl.text;
    reqBody['accountType'] = _accountType.text;

    await apiCallProvider
        .postRequest(API.addBankAccountDetails, reqBody)
        .then((value) async {
      if (value['success'] == '1') {
        Navigator.of(context, rootNavigator: true).pop();
      }
      showToastMessage(value['message']);
    });
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
                'Account Type*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextField(
                  decoration: const InputDecoration(
                    hintText: 'Account Type*',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _showAccountTypeSelectionMenu(context);
                  },
                  readOnly: true,
                  controller: _accountType),
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
                'Confirm Bank account*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextField(
                  decoration: const InputDecoration(
                    hintText: 'Confirm Bank account*',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  controller: _confAccountNoCtrl),
              Divider(
                color: Colors.grey,
              ),
              const Text(
                'Branch Name*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextField(
                  decoration: const InputDecoration(
                    hintText: 'Branch Name*',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  controller: _branchNameCtrl),
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
            if (user == null ||
                _cardHolderCtrl.text.isEmpty ||
                _bankNameCtrl.text.isEmpty ||
                _accountType.text.isEmpty ||
                _accountNoCtrl.text.isEmpty ||
                _confAccountNoCtrl.text.isEmpty ||
                _branchNameCtrl.text.isEmpty ||
                _ifscCtrl.text.isEmpty) {
              showToastMessage('All fields are mandatory');
              return;
            }
            if (_accountNoCtrl.text != _confAccountNoCtrl.text) {
              showToastMessage(
                  'Confirm account number is not same as account number');
              return;
            }
            saveBankDetails();
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
            child: apiCallProvider.status == ApiStatus.loading
                ? ButtonLoader()
                : const Text(
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

  void _showAccountTypeSelectionMenu(BuildContext context) async {
    _accountType.text = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(100, 300, 100, 0),
          items: ['savings', 'current'].map((String bank) {
            return PopupMenuItem<String>(
              value: bank,
              child: Text(bank),
            );
          }).toList(),
        ) ??
        '';
  }
}
