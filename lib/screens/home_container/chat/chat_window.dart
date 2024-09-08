import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/chat_model.dart';
import 'package:worldsocialintegrationapp/models/chat_window_model.dart';
import 'package:worldsocialintegrationapp/services/firebase_db_service.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../widgets/enum.dart';

class ChatWindow extends StatefulWidget {
  const ChatWindow({super.key, required this.chatWindowDetails});
  final ChatWindowModel chatWindowDetails;
  static const String route = '/chatWindow';

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  final TextEditingController textCtrl = TextEditingController();
  DatabaseReference chatWindowRef = FirebaseDatabase.instance.ref();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: CircularImage(
            imagePath: widget.chatWindowDetails.friendUser?.image ?? '',
            diameter: 40,
          ),
          title: Text(
            widget.chatWindowDetails.friendUser?.name ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            'Offline',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: chatWindowRef
                  .child('message/${widget.chatWindowDetails.chatWindowId}')
                  .orderByChild('timestamp')
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.snapshot.value == null) {
                  return const Center(child: Text('No messages yet!'));
                }
                Map<dynamic, dynamic>? chatData =
                    snapshot.data!.snapshot.value as Map;

                List<ChatModel> messageList = [];

                chatData.values.forEach(
                    (value) => messageList.add(ChatModel.fromMap(value)));

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return getChatBubble(messageList.elementAt(index));
                  },
                );
              },
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              horizontalGap(10),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/svg/microphone_white.svg',
                  width: 20,
                  color: const Color(0xFFFF0095),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/svg/gallery.svg',
                  width: 20,
                  color: const Color(0xFFFF0095),
                ),
                onPressed: () {},
              ),
              Expanded(
                child: TextField(
                  controller: textCtrl,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.send,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: 'Type message...',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                    counterText: '',
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (textCtrl.text.isEmpty) return;
                  ChatModel chat = ChatModel(
                      assetId: '',
                      message: textCtrl.text,
                      msgType: MessageType.TEXT.name,
                      senderId: prefs.getString(PrefsKey.userId),
                      url: '',
                      videoThumbnaiil: '');
                  FirebaseDbService.sendChat(
                          widget.chatWindowDetails.chatWindowId ?? '', chat)
                      .then(
                    (value) {
                      textCtrl.text = '';
                      _scrollToBottom();
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.blue,
                        Color(0xFFFF0095),
                      ],
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/ic_sent_mail__1_.svg',
                    width: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              horizontalGap(10),
            ],
          )
        ],
      ),
    );
  }

  getChatBubble(ChatModel chat) {
    return chat.senderId == prefs.getString(PrefsKey.userId)
        ? ChatBubble(
            clipper: ChatBubbleClipper2(type: BubbleType.sendBubble),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 20),
            backGroundColor: Colors.blue,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: getChatBubbleBody(chat),
            ),
          )
        : ChatBubble(
            clipper: ChatBubbleClipper2(type: BubbleType.receiverBubble),
            backGroundColor: Color(0xffE7E7ED),
            margin: EdgeInsets.only(top: 20),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: getChatBubbleBody(chat),
            ),
          );
  }

  getChatBubbleBody(ChatModel chat) {
    switch (chat.msgType) {
      case 'TEXT':
        return getTextTypeChat(chat);

      default:
        return const SizedBox.shrink();
    }
  }

  Widget getTextTypeChat(ChatModel chat) {
    return Column(
      crossAxisAlignment: chat.senderId == prefs.getString(PrefsKey.userId)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          chat.message ?? '',
          style: TextStyle(
              color: chat.senderId == prefs.getString(PrefsKey.userId)
                  ? Colors.white
                  : Colors.black,
              fontSize: 16),
        ),
        verticalGap(5),
        Text(
          getChatTimesAgo(chat.timestamp ?? 0),
          style: TextStyle(
              color: chat.senderId == prefs.getString(PrefsKey.userId)
                  ? Colors.white
                  : Colors.black,
              fontSize: 12),
        ),
      ],
    );
  }
}
