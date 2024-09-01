import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/level_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/receiving_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/sending_screen.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';

class UserLevelScreen extends StatefulWidget {
  const UserLevelScreen({super.key});
  static const String route = '/userLevelScreen';

  @override
  State<UserLevelScreen> createState() => _UserLevelScreenState();
}

class _UserLevelScreenState extends State<UserLevelScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ApiCallProvider apiCallProvider;
  LevelModel? levelModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(
      () {
        setState(() {});
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLevelModel();
    });
  }

  getLevelModel() async {
    Map<String, dynamic> reqBody = {'userId': prefs.getString(PrefsKey.userId)};
    apiCallProvider.postRequest(API.getLevelList, reqBody).then((value) {
      if (value['details'] != null) {
        levelModel = LevelModel.fromJson(value['details']);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Stack(
      children: [
        _tabController.index == 0
            ? CachedNetworkImage(
                imageUrl: levelModel?.sandBgImage ?? '',
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/image/levell_1.png',
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                height: 350,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              )
            : CachedNetworkImage(
                imageUrl: levelModel?.reciveBgImage ?? '',
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/image/levell_1.png',
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                height: 350,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              verticalGap(50),
              buildTabBar(context),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SendingScreen(
                      levelModel: levelModel ?? LevelModel(),
                    ),
                    ReceivingScreen(
                      levelModel: levelModel ?? LevelModel(),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Row buildTabBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: TabBar(
            controller: _tabController,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
              insets: EdgeInsets.symmetric(horizontal: 60.0),
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 5),
            indicatorColor: Colors.white,
            indicatorPadding: const EdgeInsets.only(bottom: 5),
            labelStyle: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            tabs: const [
              Tab(
                text: 'SENDING',
              ),
              Tab(
                text: 'RECEIVING',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
