import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/vip_model.dart';
import 'package:worldsocialintegrationapp/screens/vip/vip_options.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';

import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';

class VipScreen extends StatefulWidget {
  static const String route = '/vipScreen';
  const VipScreen({super.key});

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ApiCallProvider apiCallProvider;
  List<VipModel> vipList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadVip();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  loadVip() async {
    apiCallProvider.getRequest(API.getVipLevelDetails).then((value) {
      vipList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          vipList.add(VipModel.fromJson(item));
        }
        _tabController = TabController(length: vipList.length, vsync: this);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VIP Center',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF080A20),
        iconTheme: IconThemeData(color: Colors.white),
        bottom: vipList.isEmpty
            ? null
            : TabBar(
                controller: _tabController,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color(0xFFC5A36C),
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 50.0),
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                indicatorColor: Color(0xFFC5A36C),
                indicatorPadding: const EdgeInsets.only(bottom: 10),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC5A36C),
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                tabs: [
                  for (VipModel model in vipList) ...{
                    Tab(
                      text: 'VIP${model.vipLevel}',
                    ),
                  }
                ],
              ),
      ),
      body: vipList.isEmpty
          ? DefaultPageLoader()
          : TabBarView(
              controller: _tabController,
              children: [
                for (var i = 0; i < vipList.length; i++) ...{
                  VipOptions(
                    vipModel: vipList.elementAt(i),
                  ),
                }
              ],
            ),
    );
  }
}
