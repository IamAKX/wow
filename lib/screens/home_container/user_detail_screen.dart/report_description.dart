import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/report_category.dart';
import 'package:worldsocialintegrationapp/models/report_model.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';

class ReportDescription extends StatefulWidget {
  const ReportDescription({super.key, required this.reportModel});
  static const String route = '/reportDescription';
  final ReportModel reportModel;

  @override
  State<ReportDescription> createState() => _ReportDescriptionState();
}

class _ReportDescriptionState extends State<ReportDescription> {
  late ApiCallProvider apiCallProvider;
  List<ReportCategoryModel> list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  void loadUserData() async {
    apiCallProvider.getRequest(API.getSingleFamilyDetails).then((value) {
      list.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(ReportCategoryModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('User Report'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column();
  }
}
