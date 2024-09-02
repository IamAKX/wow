import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/report_category.dart';
import 'package:worldsocialintegrationapp/models/report_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_detail_screen.dart/report_subcategory.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';

class ReportCategory extends StatefulWidget {
  const ReportCategory({super.key, required this.reportModel});
  static const String route = '/reportCategory';
  final ReportModel reportModel;

  @override
  State<ReportCategory> createState() => _ReportCategoryState();
}

class _ReportCategoryState extends State<ReportCategory> {
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
    apiCallProvider.getRequest(API.getUserReportTypeCategories).then((value) {
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
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Select the illegal component',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => RadioListTile(
            tileColor: Colors.white,
            value: list.elementAt(index).id,
            groupValue: widget.reportModel.reportCategory,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (value) {
              setState(() {
                widget.reportModel.reportCategory = value;
              });
            },
            title: Text(
              list.elementAt(index).categoryName ?? '',
            ),
          ),
          separatorBuilder: (context, index) => const Divider(
            color: Colors.grey,
            height: 1,
          ),
          itemCount: list.length,
        ),
        verticalGap(100),
        Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.reportModel.reportCategory == null
                ? null
                : () {
                    Navigator.of(context).pushReplacementNamed(
                        ReportSubCategory.route,
                        arguments: widget.reportModel);
                  },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: widget.reportModel.reportCategory == null
                  ? Colors.grey
                  : Colors.blue,
            ),
            child: const Text('Next'),
          ),
        )
      ],
    );
  }
}
