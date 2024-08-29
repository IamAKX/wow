import 'package:flutter/material.dart';

class FamilyRule extends StatelessWidget {
  FamilyRule({super.key});
  static const String route = '/familyRule';

  final List<Map<String, String>> faqData = [
    {
      'question': 'What is Flutter?',
      'answer':
          'Flutter is an open-source UI software development kit created by Google.'
    },
    {
      'question': 'How do I use Flutter?',
      'answer':
          'You can use Flutter to build natively compiled applications for mobile, web, and desktop from a single codebase.'
    },
    {
      'question': 'What is Dart?',
      'answer':
          'Dart is a programming language optimized for building mobile, desktop, server, and web applications.'
    },
    {
      'question': 'Is Flutter free to use?',
      'answer':
          'Yes, Flutter is free and open-source, maintained by Google and the community.'
    },
    {
      'question': 'Can Flutter be used for web development?',
      'answer':
          'Yes, Flutter can be used to develop web applications in addition to mobile and desktop applications.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('family rules'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView.builder(
      itemCount: faqData.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          backgroundColor: Color(0xFFF6F7F9),
          collapsedBackgroundColor: Colors.white,
          title: Text(
            faqData[index]['question']!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(faqData[index]['answer']!),
            ),
          ],
        );
      },
    );
  }
}
