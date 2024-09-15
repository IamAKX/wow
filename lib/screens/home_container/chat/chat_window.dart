import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:svgaplayer_flutter_rhr/player.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/chat_model.dart';
import 'package:worldsocialintegrationapp/models/chat_window_model.dart';
import 'package:worldsocialintegrationapp/services/firebase_db_service.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/audio_player_chat.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';
import 'package:path/path.dart' as p;
import 'dart:ui' as ui show Gradient;

import '../../../providers/api_call_provider.dart';
import '../../../services/storage_service.dart';
import '../../../utils/api.dart';
import '../../../widgets/enum.dart';
import '../../../widgets/network_image_preview_fullscreen.dart';

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
  File? _image;
  final ImagePicker _picker = ImagePicker();
  late final RecorderController recorderController;
  PlayerController controller = PlayerController();
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

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
                  // .orderByChild('timestamp')
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

                messageList.sort(
                  (a, b) {
                    return (a.timestamp ?? 0).compareTo(b.timestamp ?? 0);
                  },
                );
                _scrollToBottom();
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
              GestureDetector(
                onLongPress: () async {
                  log('recording start');
                  await recorderController.record();
                  setState(() {});
                },
                onLongPressUp: () async {
                  log('recording end');
                  final path = await recorderController.stop();
                  setState(() {});
                  log('Recording file : $path');
                  if (path != null && path.isNotEmpty) {
                    showSendAudioPopup(path, context);
                  }
                },
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/microphone_white.svg',
                    width: 20,
                    color: const Color(0xFFFF0095),
                  ),
                  onPressed: null,
                ),
              ),
              if (recorderController.isRecording)
                AudioWaveforms(
                  enableGesture: true,
                  size: Size(MediaQuery.of(context).size.width - 130, 40),
                  recorderController: recorderController,
                  waveStyle: WaveStyle(
                    waveThickness: 2,
                    spacing: 5,
                    scaleFactor: 80,
                    gradient: ui.Gradient.linear(
                      const Offset(70, 50),
                      Offset(MediaQuery.of(context).size.width / 2, 0),
                      [
                        Colors.red,
                        Colors.green,
                      ],
                    ),
                    extendWaveform: true,
                    showMiddleLine: false,
                  ),
                  padding: const EdgeInsets.only(left: 18),
                ),
              if (!recorderController.isRecording)
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/gallery.svg',
                    width: 20,
                    color: const Color(0xFFFF0095),
                  ),
                  onPressed: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                        showSendImagePopup(_image, context);
                      } else {
                        log('No image selected.');
                      }
                    });
                  },
                ),
              if (!recorderController.isRecording)
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
              if (!recorderController.isRecording)
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
            margin: const EdgeInsets.only(top: 20),
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
            backGroundColor: const Color(0xffE7E7ED),
            margin: const EdgeInsets.only(top: 20),
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

      case 'IMAGE':
        return getImageTypeChat(chat);

      case 'AUDIO':
        return getAudioTypeChat(chat);

      case 'CAR':
      case 'FRAME':
        return getSVGATypeChat(chat);

      default:
        return const SizedBox.shrink();
    }
  }

  Widget getSVGATypeChat(ChatModel chat) {
    return Column(
      crossAxisAlignment: chat.senderId == prefs.getString(PrefsKey.userId)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: SVGASimpleImage(
            resUrl: chat.url ?? '',
          ),
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
        Visibility(
            visible: chat.senderId != prefs.getString(PrefsKey.userId),
            child: InkWell(
              onTap: (chat.isClaimed ?? true)
                  ? null
                  : () async {
                      Map<String, dynamic> reqBody = {
                        'garageId': chat.assetId,
                        'type': chat.assetTypeId,
                        'image': chat.url,
                        'userId': prefs.getString(PrefsKey.userId)
                      };
                      chat.isClaimed = true;
                      await apiCallProvider
                          .postRequest(API.claim_garage, reqBody)
                          .then(
                        (value) {
                          showToastMessage(value['message']);
                          if (value['success'] == '1') {
                            FirebaseDbService.updateChat(
                                    widget.chatWindowDetails.chatWindowId ?? '',
                                    chat)
                                .then(
                              (value) {
                                textCtrl.text = '';
                                _scrollToBottom();
                              },
                            );
                          }
                        },
                      );
                    },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: Text(
                  (chat.isClaimed ?? true) ? 'Claimed' : 'Claim',
                  style: const TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    colors: [Colors.deepOrange, Colors.yellow],
                  ),
                ),
              ),
            ))
      ],
    );
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

  Widget getImageTypeChat(ChatModel chat) {
    return Column(
      crossAxisAlignment: chat.senderId == prefs.getString(PrefsKey.userId)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                NetworkImagePreviewFullScreen.route,
                arguments: chat.url ?? ''),
            child: CachedNetworkImage(
              imageUrl: chat.url ?? '',
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Center(
                child: Text('Error ${error.toString()}'),
              ),
              fit: BoxFit.fill,
              height: 250,
            ),
          ),
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

  Widget getAudioTypeChat(ChatModel chat) {
    return Column(
      crossAxisAlignment: chat.senderId == prefs.getString(PrefsKey.userId)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularImage(
                      imagePath: chat.senderId ==
                              prefs.getString(PrefsKey.userId)
                          ? widget.chatWindowDetails.currentUser?.image ?? ''
                          : widget.chatWindowDetails.friendUser?.image ?? '',
                      diameter: 50),
                  horizontalGap(5),
                  ChatAudioPlayer(url: chat.url ?? ''),
                ],
              ),
            )),
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

  void showSendImagePopup(File? image, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isUploading = false;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    isUploading = true;
                  });
                  // upload and send
                  await StorageService.uploadFile(
                    image!,
                    'message/${widget.chatWindowDetails.chatWindowId}/images/${widget.chatWindowDetails.currentUser?.id}-${p.basename(image.path)}',
                  ).then((value) async {
                    ChatModel chat = ChatModel(
                        assetId: '',
                        message: '',
                        msgType: MessageType.IMAGE.name,
                        senderId: prefs.getString(PrefsKey.userId),
                        url: value,
                        videoThumbnaiil: '');
                    await FirebaseDbService.sendChat(
                            widget.chatWindowDetails.chatWindowId ?? '', chat)
                        .then(
                      (value) {
                        setState(() {
                          isUploading = false;
                        });
                        textCtrl.text = '';
                        _scrollToBottom();
                      },
                    );
                    Navigator.pop(context);
                  });
                },
                child: const Text('Send'),
              )
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Visibility(
                  visible: isUploading,
                  child: Container(
                    color: Colors.white.withOpacity(0.1),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  void showSendAudioPopup(String audioPath, BuildContext context) async {
    await controller.preparePlayer(
      path: audioPath,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isPlaying = false;
        bool isUploading = false;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (!isPlaying) {
                    setState(() {
                      isPlaying = true;
                    });

                    controller.startPlayer(forceRefresh: true);
                  } else {
                    setState(() {
                      isPlaying = false;
                    });
                    controller.pausePlayer();
                  }
                },
                child: isPlaying ? const Text('Pause') : const Text('Play'),
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    isUploading = true;
                  });
                  // upload and send
                  File file = File(audioPath);
                  await StorageService.uploadFile(
                    file,
                    'message/${widget.chatWindowDetails.chatWindowId}/audio/${widget.chatWindowDetails.currentUser?.id}-${p.basename(file.path)}',
                  ).then((value) async {
                    ChatModel chat = ChatModel(
                        assetId: '',
                        message: '',
                        msgType: MessageType.AUDIO.name,
                        senderId: prefs.getString(PrefsKey.userId),
                        url: value,
                        videoThumbnaiil: '');
                    await FirebaseDbService.sendChat(
                            widget.chatWindowDetails.chatWindowId ?? '', chat)
                        .then(
                      (value) {
                        setState(() {
                          isUploading = false;
                        });
                        textCtrl.text = '';
                        _scrollToBottom();
                      },
                    );
                    Navigator.pop(context);
                  });
                },
                child: const Text('Send'),
              )
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Tap Play to listen your recording'),
                verticalGap(20),
                AudioFileWaveforms(
                  size: Size(MediaQuery.of(context).size.width, 100.0),
                  playerController: controller,
                  enableSeekGesture: true,
                  waveformType: WaveformType.long,
                  waveformData: [],
                  playerWaveStyle: const PlayerWaveStyle(
                    fixedWaveColor: Colors.white54,
                    liveWaveColor: Colors.blueAccent,
                    spacing: 6,
                  ),
                ),
                Visibility(
                  visible: isUploading,
                  child: Container(
                    color: Colors.white.withOpacity(0.1),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }
}
