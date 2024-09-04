import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/friend_feed_model.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';

import '../../../main.dart';
import '../../../models/comment_data.dart';
import '../../../models/report_model.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../utils/helpers.dart';
import '../../../utils/prefs_key.dart';
import '../../../widgets/circular_image.dart';
import '../../../widgets/feed_video_player.dart';
import '../../../widgets/gaps.dart';
import '../profile/comment.dart';
import '../user_detail_screen.dart/report_category.dart';

class FriendFeedScreen extends StatefulWidget {
  const FriendFeedScreen({super.key});

  @override
  State<FriendFeedScreen> createState() => _FriendFeedScreenState();
}

class _FriendFeedScreenState extends State<FriendFeedScreen> {
  List<FriendFeedModel> momentsList = [];
  late ApiCallProvider apiCallProvider;
  UserProfileDetail? user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
      loadMoments();
    });
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

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return apiCallProvider.status == ApiStatus.loading
        ? const DefaultPageLoader()
        : ListView.builder(
            itemCount: momentsList.length,
            itemBuilder: (context, index) {
              return getMomentCard(momentsList.elementAt(index));
            },
          );
  }

  void loadMoments() async {
    momentsList.clear();
    String? userId = prefs.getString(PrefsKey.userId) ?? '0';
    Map<String, dynamic> reqBody = {'userId': userId};
    await apiCallProvider.postRequest(API.getFriendsPosts, reqBody).then(
      (value) {
        if (value['details'] != null) {
          for (Map<String, dynamic> item in value['details']) {
            momentsList.add(FriendFeedModel.fromJson(item));
          }
          setState(() {});
        }
      },
    );
  }

  Container getMomentCard(FriendFeedModel moment) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              horizontalGap(pagePadding / 2),
              CircularImage(
                  imagePath: moment.userImage?.image ?? '', diameter: 35),
              horizontalGap(pagePadding / 2),
              Text(
                moment.name ?? '',
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'report':
                      Navigator.of(context).pushNamed(
                        ReportCategory.route,
                        arguments: ReportModel(
                          postId: moment.id,
                          userId: prefs.getString(PrefsKey.userId),
                          otherUserId: moment.userId,
                        ),
                      );
                      break;
                  }
                },
                position: PopupMenuPosition.under,
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'report',
                      child: Text('Report'),
                    ),
                  ];
                },
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: moment.status == '1'
                ? FeedVideoPlayer(
                    url: moment.image ?? '',
                    play: false,
                  )
                : CachedNetworkImage(
                    imageUrl: moment.image ?? '',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text('Error ${error.toString()}'),
                    ),
                    fit: BoxFit.fitHeight,
                  ),
          ),
          if (moment.likeCount != '0')
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                bottom: 5,
                top: 5,
              ),
              child: Text('${moment.likeCount ?? 0} likes'),
            ),
          Row(
            children: [
              horizontalGap(10),
              if (moment.commentCount != '0') ...{
                Text(
                  '${moment.commentCount}',
                  style: TextStyle(fontSize: 16),
                ),
                horizontalGap(10),
              },
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(
                    CommentScreen.route,
                    arguments: CommentData(
                        feedId: moment.id,
                        senderId: user?.id,
                        senderImage: user?.image),
                  )
                      .then(
                    (value) {
                      moment.commentCount = '$value';
                      setState(() {});
                    },
                  );
                },
                child: SvgPicture.asset(
                  'assets/svg/chat.svg',
                  width: 20,
                ),
              ),
              horizontalGap(10),
              InkWell(
                onTap: () {
                  apiCallProvider.postRequest(API.likeDislike,
                      {'userId': user?.id ?? '0', 'feedId': moment.id}).then(
                    (value) {
                      setState(() {
                        moment.likeCount = value['likeCount'].toString();
                        moment.postLikeStatus = value['likeUnLikestatus'];
                      });
                    },
                  );
                },
                child: moment.postLikeStatus ?? false
                    ? Icon(
                        Icons.favorite,
                        color: Color(0xFFC22B1A),
                        size: 20,
                      )
                    : Icon(
                        Icons.favorite_border,
                        size: 20,
                      ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(
                CommentScreen.route,
                arguments: CommentData(
                    feedId: moment.id,
                    senderId: user?.id,
                    senderImage: user?.image),
              )
                  .then(
                (value) {
                  moment.commentCount = '$value';
                  setState(() {});
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 10, top: 5),
              child: Text(
                'View all comments',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Visibility(
            visible:
                moment.comment != null && (moment.comment ?? '').isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 10, left: 10, top: 5, right: 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${moment.commentByame ?? ''} ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: moment.comment ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, top: 5),
            child: Text(
              getTimesAgo(moment.created ?? ''),
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
