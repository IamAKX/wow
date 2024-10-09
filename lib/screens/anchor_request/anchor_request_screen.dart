import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../models/agency_model.dart';
import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/country_continent_map.dart';
import '../../utils/generic_api_calls.dart';
import '../../utils/helpers.dart';
import '../../utils/prefs_key.dart';
import '../../widgets/button_loader.dart';

class AnchorRequestScreen extends StatefulWidget {
  const AnchorRequestScreen({super.key});
  static const String route = '/anchorRequestScreen';

  @override
  State<AnchorRequestScreen> createState() => _AnchorRequestScreenState();
}

class _AnchorRequestScreenState extends State<AnchorRequestScreen> {
  late ApiCallProvider apiCallProvider;
  UserProfileDetail? user;
  List<AgencyModel> agencyModelList = [];
  AgencyModel? selectedAgent;
  DateTime selectedDate = DateTime.now();
  String country = 'India';
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    dateCtrl.text = dateFormat.format(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSelfUserData();
      loadAgency();
    });
  }

  loadAgency() async {
    apiCallProvider.getRequest(API.get_agencies).then((value) {
      agencyModelList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          agencyModelList.add(AgencyModel.fromMap(item));
        }
        selectedAgent = agencyModelList.first;
        setState(() {});
      }
    });
  }

  void loadSelfUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
          nameCtrl.text = user?.name ?? '';
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
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        title: const Text('Apply for Anchor'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    log('agencyModelList : ${agencyModelList.length}');
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Broadcaster information table',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        verticalGap(20),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Your personal information is safe with us. You can\nfill up the details worry-free!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.purple, fontSize: 16),
          ),
        ),
        verticalGap(20),
        Row(
          children: [
            const Text(
              'WOW\'s ID : ',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            horizontalGap(20),
            Text(
              '${user?.username ?? 0}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        verticalGap(10),
        SizedBox(
          width: double.infinity,
          child: TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              hintText: '*Enter you real name',
              labelText: '*Enter you real name',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        verticalGap(20),
        const Text(
          '* Country/Region',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        SizedBox(
          width: double.infinity,
          child: DropdownButton2<String>(
            hint: const Text('Select your country'),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 300,
              offset: Offset(0, 10),
            ),
            value: country,
            items: countryToContinent.keys.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                country = newValue!;
              });
            },
          ),
        ),
        verticalGap(20),
        const Text(
          'Date',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        verticalGap(10),
        TextField(
          controller: dateCtrl,
          decoration: const InputDecoration(),
          // onTap: () {
          //   FocusScope.of(context).requestFocus(FocusNode());
          //   _selectDate(context);
          // },
          readOnly: true,
        ),
        verticalGap(20),
        const Text(
          '* I am verified user of WOW\'s and I want to join...',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        DropdownButton2<AgencyModel>(
          hint: const Text('Select agent'),
          value: selectedAgent,
          items: agencyModelList.map((AgencyModel item) {
            return DropdownMenuItem<AgencyModel>(
              value: item,
              child: Text('${item.username ?? ''} (${item.agencyCode ?? ''})'),
            );
          }).toList(),
          onChanged: (AgencyModel? newValue) {
            setState(() {
              selectedAgent = newValue!;
            });
          },
        ),
        verticalGap(30),
        InkWell(
          onTap: () {
            if (nameCtrl.text.isEmpty || dateCtrl.text.isEmpty) {
              showToastMessage('All fields are mandatory');
              return;
            }
            Map<String, dynamic> reqBody = {
              'userId': user?.id,
              'agencyId': selectedAgent?.agencyCode ?? '',
              'name': nameCtrl.text,
              'country': country,
              'nationalId': '',
            };
            apiCallProvider.postRequest(API.hostApi, reqBody).then((value) {
              if (apiCallProvider.status == ApiStatus.success) {
                showToastMessageWithLogo('${value['message']}', context);
                Navigator.pop(context);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3488D5),
                  Color(0xFFEA0A8A),
                ],
              ),
            ),
            alignment: Alignment.center,
            child: apiCallProvider.status == ApiStatus.loading
                ? const ButtonLoader()
                : const Text(
                    'Apply',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: '',
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF008577),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateCtrl.text = dateFormat.format(picked);
      });
    }
  }
}
