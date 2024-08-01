import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => const ListTile(
              title: Text('Deepika Singh'),
              subtitle: Text('Some random message'),
              trailing: Icon(Icons.chevron_right),
              leading: CircularImage(
                  imagePath: 'assets/dummy/girl.jpeg', diameter: 50),
            ),
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,
          );
        },
        itemCount: 50);
  }
}
