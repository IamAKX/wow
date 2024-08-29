import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/invitation.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/request.dart';

import '../../../providers/api_call_provider.dart';

class InvitationRequestScreen extends StatefulWidget {
  const InvitationRequestScreen({super.key, required this.userProfileDetail});
  static const String route = '/invitationScreen';
  final UserProfileDetail userProfileDetail;

  @override
  State<InvitationRequestScreen> createState() =>
      _InvitationRequestScreenState();
}

class _InvitationRequestScreenState extends State<InvitationRequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: Color(0xFF008877),
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          indicatorColor: const Color(0xFF008877),
          indicatorPadding: const EdgeInsets.only(bottom: 10),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFFC0AC8B),
          ),
          tabs: const [
            Tab(
              text: 'INVITATIONS',
            ),
            Tab(
              text: 'REQUESTS',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Invitation(
            userProfileDetail: widget.userProfileDetail,
          ),
          Request(
            userProfileDetail: widget.userProfileDetail,
          ),
        ],
      ),
    );
  }
}
