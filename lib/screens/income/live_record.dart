import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../models/user_profile_detail.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/generic_api_calls.dart';

class LiveRecord extends StatefulWidget {
  const LiveRecord({super.key});
  static const String route = '/LiveRecord';

  @override
  State<LiveRecord> createState() => _LiveRecordState();
}

class _LiveRecordState extends State<LiveRecord> {
  String selectedDate = formatDate(DateTime.now());
  UserProfileDetail? user;

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
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('Monthly Records'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      children: [
        TextButton.icon(
          onPressed: () async {
            DateTime? dateTime = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(2500));
            setState(() {
              selectedDate = formatDate(dateTime ?? DateTime.now());
            });
          },
          iconAlignment: IconAlignment.end,
          icon: const Icon(
            Icons.arrow_drop_down_sharp,
            color: Colors.purpleAccent,
          ),
          label: Text(
            selectedDate,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purpleAccent,
            ),
          ),
        ),
        verticalGap(40),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'All data will be updated every 10 minutes',
            style: TextStyle(
                color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        verticalGap(20),
        Container(
          padding: EdgeInsets.all(25),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Color(0xFFFA02E7),
                Color(0xFF881AFC),
              ],
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Diamonds : ${user?.myDiamond ?? '0'}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              horizontalGap(10),
              Image.asset(
                'assets/image/new_diamond.png',
                width: 20,
              )
            ],
          ),
        ),
        verticalGap(20),
        Container(
          padding: EdgeInsets.all(25),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Color(0xFFF93500),
                Color(0xFFFCBF01),
              ],
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Valid Days : 2',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }
}