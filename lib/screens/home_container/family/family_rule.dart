import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FamilyRule extends StatefulWidget {
  const FamilyRule({super.key});
  static const String route = '/familyRule';

  @override
  State<FamilyRule> createState() => _FamilyRuleState();
}

class _FamilyRuleState extends State<FamilyRule> {
  final List<Map<String, String>> faqData = [
    {
      'question': '1. What is a family?',
      'answer':
          'A family is an organization created by user on their own.\nUsers apply to join the family and work together with like-\nminded partners to keep the family growing.',
    },
    {
      'question': '2. How to create/Join a family?',
      'answer':
          'Create a family: you can create a family after your wealth level\nmeet the requirement,Upload the family cover,name nad\nnotice,you can run your family after passing the review.\n\nJoin the family: On the family Home page, click "Join Family" to\nInitiate the application,and you can join the family after passing the family review.',
    },
    {
      'question': '3. Can I join multiple families?',
      'answer': 'No, one person can only create or join the family.',
    },
    {
      'question': '4. How many people can the family hold?',
      'answer':
          'The number of members is related to the family level, and the\ninitial number is 150.The higher the family level, the greater the capacity.',
    },
    {
      'question': '5. How many administrators can be set in a family?',
      'answer': 'A family can have to 5 administrators',
    },
    {
      'question': '6. How is the family  list ranked?',
      'answer': 'sort by the total contribution of family members.',
    },
    {
      'question': '7. What is the family level?',
      'answer':
          'The family level represents the strength of the family.The\nstronger the family,the higher the level.The current family\nlevel is divided into four levels:steel,bronze,silver,and gold. ',
    },
    {
      'question': '8. What can the family level upgrade bring?',
      'answer':
          'As the level increases, the upper limit of member and\nadministrators will continue to increase;at the same 6time, the \nstyle of family badge and family frame will continue to\nupgrade as the level increases. Upgrade to the Golden Family\nto unlock the exclusive gifts of the golden family.',
    },
    {
      'question': '9. How to improve the family level?',
      'answer':
          'Calculate the sum of Contribution of family members in\neach season.The higher the contribution value,the higher the\nlevel.The level will be settled at the end of the season as the\ninitial level for the next season.',
    },
    {
      'question': '10. How is the contribution calculated?',
      'answer': '',
    }
  ];

  List list = [
    {'task': 'Login', 'points': '+20 per member per day'},
    {
      'task': 'Every 10 minutes of Watching live',
      'points': '+50 ,upto +250 per member per day'
    },
    {
      'task': 'Every 10 minutes of chatting on mic',
      'points': '+150, upto +750 per member per day'
    },
    {'task': 'Send gifts', 'points': '1 coin=1'},
  ];
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Colors.transparent, // Set to your default or previous color
      statusBarIconBrightness:
          Brightness.dark, // Set to your default icon brightness
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF5E2694),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text('family rules'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView.builder(
      itemCount: faqData.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          backgroundColor: const Color(0xFFF7F8FA),
          collapsedBackgroundColor: Colors.white,
          expandedAlignment: Alignment.centerLeft,
          title: Text(
            faqData[index]['question']!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            if (index != 9)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  faqData[index]['answer']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            if (index == 9) getTable(),
            if (index == 9)
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  'If a user quits a family, their family level remains the same, yet contribution will be reset;',
                  style: TextStyle(color: Color(0xFFB0AFAF), fontSize: 14),
                ),
              ),
            if (index == 9)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Users\' starting contribution level after joining the family is 0.',
                  style: TextStyle(color: Color(0xFFB0AFAF), fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }

  getTable() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        border: TableBorder.all(
          color: Color(0xFFDDDDDE),
          width: 1,
        ), // All borders

        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
        },
        children: [
          const TableRow(
            decoration: BoxDecoration(),
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Tasks',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Contribution',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          for (var item in list)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${item['task']}',
                    style:
                        const TextStyle(color: Color(0xFFB0AFAF), fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${item['points']}',
                    style:
                        const TextStyle(color: Color(0xFFB0AFAF), fontSize: 14),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
