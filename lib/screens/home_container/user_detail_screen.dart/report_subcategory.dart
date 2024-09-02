import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/report_model.dart';
import 'package:worldsocialintegrationapp/models/report_type.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/button_loader.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../widgets/gaps.dart';

class ReportSubCategory extends StatefulWidget {
  const ReportSubCategory({super.key, required this.reportModel});
  static const String route = '/reportSubCategory';
  final ReportModel reportModel;

  @override
  State<ReportSubCategory> createState() => _ReportSubCategoryState();
}

class _ReportSubCategoryState extends State<ReportSubCategory> {
  late ApiCallProvider apiCallProvider;
  List<ReportType> list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  void loadUserData() async {
    apiCallProvider
        .getRequest(API.getUserReportTypeSubCategories)
        .then((value) {
      list.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(ReportType.fromJson(item));
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Tell us why you report this user please',
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
            groupValue: widget.reportModel.reportSubCategory,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (value) {
              setState(() {
                widget.reportModel.reportSubCategory = value;
              });
            },
            title: Text(
              list.elementAt(index).typeName ?? '',
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
            onPressed: widget.reportModel.reportSubCategory == null ||
                    apiCallProvider.status == ApiStatus.loading
                ? null
                : () async {
                    Map<String, dynamic> reqBody = {
                      'userReport_catId': widget.reportModel.reportCategory,
                      'userReport_SubcatId':
                          widget.reportModel.reportSubCategory,
                      'userId': widget.reportModel.userId,
                      'otherUserId': widget.reportModel.otherUserId,
                    };
                    await apiCallProvider
                        .postRequest(API.getSingleFamilyDetails, reqBody)
                        .then((value) {
                      if (value['message'] != null) {
                        showToastMessageWithLogo(value['message'], context);
                        Navigator.pop(context);
                      }
                    });
                  },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: widget.reportModel.reportSubCategory == null
                  ? Colors.grey
                  : Colors.blue,
            ),
            child: apiCallProvider.status == ApiStatus.loading
                ? const ButtonLoader()
                : const Text('Next'),
          ),
        )
      ],
    );
  }
}
