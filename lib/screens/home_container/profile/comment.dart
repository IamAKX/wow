import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';

import '../../../models/comment.dart';
import '../../../models/comment_data.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/generic_api_calls.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.commentData});
  static const String route = '/commentScreen';
  final CommentData commentData;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  UserProfileDetail? user;
  late ApiCallProvider apiCallProvider;
  final TextEditingController _commentCtrl = TextEditingController();
  List<Comment> commentList = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
      loadComment();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void loadUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
        });
      },
    );
  }

  void loadComment() async {
    apiCallProvider.postRequest(
        API.getComments, {'feedId': widget.commentData.feedId}).then(
      (value) {
        if (value['success'] == '1' && value['details'] != null) {
          commentList.clear();
          for (Map<String, dynamic> item in value['details']) {
            commentList.add(Comment.fromMap(item));
          }
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, commentList.length);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          title: const Text('Comments'),
        ),
        body: getBody(context),
      ),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: commentList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircularImage(
                    imagePath: commentList.elementAt(index).image ?? '',
                    diameter: 40),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${commentList.elementAt(index).name ?? ''} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: commentList.elementAt(index).comment ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  commentList.elementAt(index).commentCreatedTime ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                onTap: commentList.elementAt(index).userId ==
                            prefs.getString(PrefsKey.userId) ||
                        prefs.getString(PrefsKey.userId) ==
                            widget.commentData.feedSenderId
                    ? () {
                        showDeleteCommentPopup(
                            commentList.elementAt(index).id ?? '');
                      }
                    : null,
              );
            },
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: BorderedCircularImage(
                imagePath: user?.image ?? '',
                diameter: 30,
                borderColor: Colors.black,
                borderThickness: 1,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _commentCtrl,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  hintText: 'Comment as ........',
                  fillColor: Color(0xFFF7F7F7),
                ),
              ),
            ),
            TextButton(
              onPressed: apiCallProvider.status == ApiStatus.loading
                  ? null
                  : () {
                      if (_commentCtrl.text.isEmpty) {
                        return;
                      }
                      apiCallProvider.postRequest(API.addComment, {
                        'feedId': widget.commentData.feedId,
                        'userId': prefs.getString(PrefsKey.userId),
                        'comment': _commentCtrl.text
                      }).then(
                        (value) {
                          _focusNode.unfocus();
                          if (value['success'] == '1') {
                            _commentCtrl.text = '';
                            loadComment();
                          }
                        },
                      );
                    },
              child: const Text(
                'Post',
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        )
      ],
    );
  }

  void showDeleteCommentPopup(String commentId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Comment'),
          content: const Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                _focusNode.unfocus();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () async {
                _focusNode.unfocus();
                apiCallProvider.postRequest(API.deleteComment, {
                  'feedId': widget.commentData.feedId,
                  'commentId': commentId
                }).then(
                  (value) {
                    Navigator.of(context).pop();
                    showToastMessageWithLogo(value['message'], context);
                    loadComment();
                  },
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }
}
