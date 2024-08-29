import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/user_profile_detail.dart';

import '../../../providers/api_call_provider.dart';

class Request extends StatefulWidget {
  const Request({super.key, required this.userProfileDetail});
  final UserProfileDetail userProfileDetail;

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  late ApiCallProvider apiCallProvider;

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return ListView();
  }
}
