import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/invitation.dart';

import '../../../models/family_details.dart';

class OnlyInvitationScreen extends StatefulWidget {
  const OnlyInvitationScreen({super.key, required this.familyDetails});
  static const String route = '/onlyInvitationScreen';
  final FamilyDetails familyDetails;

  @override
  State<OnlyInvitationScreen> createState() => _OnlyInvitationScreenState();
}

class _OnlyInvitationScreenState extends State<OnlyInvitationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INVITATIONS'),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF5E2694),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: Invitation(
        familyDetails: widget.familyDetails,
      ),
    );
  }
}
