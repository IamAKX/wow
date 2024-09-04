import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:worldsocialintegrationapp/models/create_event.dart';
import 'package:worldsocialintegrationapp/screens/home_container/event/create_event_two.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class CreateEventOne extends StatefulWidget {
  const CreateEventOne({super.key});
  static const String route = '/createEventOne';

  @override
  State<CreateEventOne> createState() => _CreateEventOneState();
}

class _CreateEventOneState extends State<CreateEventOne> {
  CreateEvent createEvent = CreateEvent(event_Type: 'Themed');
  final TextEditingController topicCtrl = TextEditingController();
  final TextEditingController ruleCtrl = TextEditingController();
  DateTime eventStartTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text(
          'Create an event',
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFFCECECE),
          ),
          child: const Text(
            'Event type',
            style: TextStyle(
              color: Color(0xFFA5B2BE),
            ),
          ),
        ),
        Row(
          children: [
            horizontalGap(20),
            Radio(
              value: 'Themed',
              groupValue: createEvent.event_Type,
              visualDensity: VisualDensity.compact,
              onChanged: (value) {
                createEvent.event_Type = value;
                topicCtrl.text = 'Themed event';
                setState(() {});
              },
            ),
            const Text(
              'Themed event',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            horizontalGap(20),
            Radio(
              value: 'Birthday',
              visualDensity: VisualDensity.compact,
              groupValue: createEvent.event_Type,
              onChanged: (value) {
                createEvent.event_Type = value;
                topicCtrl.text = 'Birthday celebration';
                setState(() {});
              },
            ),
            const Text(
              'Birthday party',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            horizontalGap(20),
            Radio(
              value: 'Anniversary',
              visualDensity: VisualDensity.compact,
              groupValue: createEvent.event_Type,
              onChanged: (value) {
                createEvent.event_Type = value;
                topicCtrl.text = 'Anniversary celebration';
                setState(() {});
              },
            ),
            const Text(
              'Anniversary',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFFCECECE),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Event\'s topic',
                style: TextStyle(
                  color: Color(0xFFA5B2BE),
                ),
              ),
              Text(
                '${topicCtrl.text.length}/80',
                style: const TextStyle(
                  color: Color(0xFFA5B2BE),
                ),
              ),
            ],
          ),
        ),
        TextField(
          controller: topicCtrl,
          maxLength: 80,
          minLines: 3,
          maxLines: 3,
          textInputAction: TextInputAction.done,
          enabled: createEvent.event_Type == 'Themed',
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: createEvent.event_Type,
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            counterText: '',
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFFCECECE),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Event\'s rule',
                style: TextStyle(
                  color: Color(0xFFA5B2BE),
                ),
              ),
              Text(
                '${ruleCtrl.text.length}/100',
                style: const TextStyle(
                  color: Color(0xFFA5B2BE),
                ),
              ),
            ],
          ),
        ),
        TextField(
          controller: ruleCtrl,
          maxLength: 100,
          minLines: 2,
          maxLines: 2,
          textInputAction: TextInputAction.done,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
            hintText: 'Event rule',
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            counterText: '',
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFFCECECE),
          ),
          child: const Text(
            'Event\'s Time',
            style: TextStyle(
              color: Color(0xFFA5B2BE),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Starting timing',
                style: TextStyle(color: Colors.black),
              ),
              InkWell(
                onTap: () async {
                  eventStartTime = await showDateTimePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          lastDate: DateTime.now()
                              .add(const Duration(days: 365 * 5))) ??
                      DateTime.now();
                  createEvent.event_startTime =
                      DateFormat('yyyy-MM-dd HH:mm').format(eventStartTime);
                  setState(() {});
                },
                child: Text(
                  DateFormat('yyyy-MM-dd HH:mm').format(eventStartTime),
                  style: const TextStyle(),
                ),
              ),
            ],
          ),
        ),
        verticalGap(20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green, // Text color
              shadowColor: Colors.green, // No shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: ((createEvent.event_Type?.isEmpty ?? false) ||
                    topicCtrl.text.isEmpty ||
                    ruleCtrl.text.isEmpty)
                ? null
                : () {
                    createEvent.event_topic = topicCtrl.text;
                    createEvent.description = ruleCtrl.text;
                    Navigator.pushReplacementNamed(
                        context, CreateEventTwo.route,
                        arguments: createEvent);
                  },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Next'),
            ),
          ),
        )
      ],
    );
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }
}
