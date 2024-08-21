import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/api_call_provider.dart';

class FamilyLeaderboard extends StatefulWidget {
  const FamilyLeaderboard({super.key});
  static const String route = '/familyLeaderboard';

  @override
  State<FamilyLeaderboard> createState() => _FamilyLeaderboardState();
}

class _FamilyLeaderboardState extends State<FamilyLeaderboard> {
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Todo: call api after screen load
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
        backgroundColor: const Color(0xFFF6F7F9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Family Leaderboard'),
          actions: [],
        ),
        body: getBody(context));
  }

  getBody(BuildContext context) {
    return Container();
  }
}
