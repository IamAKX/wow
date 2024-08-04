import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/widgets/user_tile.dart';

class FriendFansFollowing extends StatefulWidget {
  const FriendFansFollowing({super.key, required this.index});
  final int index;
  static const String route = '/friendFansFollowing';

  @override
  State<FriendFansFollowing> createState() => _FriendFansFollowingState();
}

class _FriendFansFollowingState extends State<FriendFansFollowing>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = widget.index;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: Colors.grey,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            insets: EdgeInsets.symmetric(horizontal: 50.0),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          indicatorColor: Colors.grey,
          indicatorPadding: const EdgeInsets.only(bottom: 10),
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          tabs: const [
            Tab(
              text: 'Friends',
            ),
            Tab(
              text: 'Following',
            ),
            Tab(
              text: 'Fans',
            ),
          ],
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemBuilder: (context, index) => UserTile(),
            itemCount: 2,
          ),
          ListView.builder(
            itemBuilder: (context, index) => UserTile(),
            itemCount: 1,
          ),
          ListView.builder(
            itemBuilder: (context, index) => UserTile(),
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}
