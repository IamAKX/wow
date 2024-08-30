import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/family_details.dart';

import '../../../providers/api_call_provider.dart';

class Invitation extends StatefulWidget {
  const Invitation({super.key, required this.familyDetails});
  final FamilyDetails familyDetails;

  @override
  State<Invitation> createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {
  late ApiCallProvider apiCallProvider;

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return ListView();
  }
}
