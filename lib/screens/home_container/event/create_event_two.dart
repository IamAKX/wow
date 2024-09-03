import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:worldsocialintegrationapp/models/create_event.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class CreateEventTwo extends StatefulWidget {
  const CreateEventTwo({super.key, required this.createEvent});
  static const String route = '/createEventTwo';
  final CreateEvent createEvent;

  @override
  State<CreateEventTwo> createState() => _CreateEventTwoState();
}

class _CreateEventTwoState extends State<CreateEventTwo> {
  CreateEvent createEvent = CreateEvent(event_Type: 'Themed');
  final TextEditingController topicCtrl = TextEditingController();
  final TextEditingController ruleCtrl = TextEditingController();
  DateTime eventStartTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF00EE),
                Color(0xFF9600FF),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
