import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../widgets/user_tile.dart';

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key});
  static const String route = '/visitorScreen';

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Visitor'),
        elevation: 1,
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        UserTile(),
      ],
    );
  }
}
