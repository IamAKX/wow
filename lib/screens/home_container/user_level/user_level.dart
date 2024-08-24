import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/receiving_screen.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_level/sending_screen.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class UserLevelScreen extends StatefulWidget {
  const UserLevelScreen({super.key});
  static const String route = '/userLevelScreen';

  @override
  State<UserLevelScreen> createState() => _UserLevelScreenState();
}

class _UserLevelScreenState extends State<UserLevelScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(
      () {
        setState(() {});
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Stack(
      children: [
        _tabController.index == 1
            ? Image.asset('assets/image/levell_13.png')
            : Image.asset('assets/image/levell_1.png'),
        Container(
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
                    SendingScreen(),
                    ReceivingScreen(),
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
