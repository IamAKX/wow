// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/comment_data.dart';
import 'package:worldsocialintegrationapp/models/firebase_user.dart';
import 'package:worldsocialintegrationapp/models/report_model.dart';
import 'package:worldsocialintegrationapp/models/visitor_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/user_detail_screen/report_category.dart';
import 'package:worldsocialintegrationapp/services/firebase_db_service.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/user_profile_details_convertor.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../main.dart';
import '../../../models/chat_window_model.dart';
import '../../../models/feed.dart';
import '../../../models/live_room_detail_model.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../utils/colors.dart';
import '../../../utils/generic_api_calls.dart';
import '../../../utils/helpers.dart';
import '../../../utils/prefs_key.dart';
import '../../../widgets/feed_video_player.dart';
import '../../../widgets/network_image_preview_fullscreen.dart';
import '../../live_room/live_room_screen.dart';
import '../chat/chat_window.dart';
import '../profile/comment.dart';

class OtherUserDeatilScreen extends StatefulWidget {
  const OtherUserDeatilScreen({super.key, required this.otherUserId});
  static const String route = '/otherUserDeatilScreen';
  final String otherUserId;
  @override
  State<OtherUserDeatilScreen> createState() => _OtherUserDeatilScreenState();
}

class _OtherUserDeatilScreenState extends State<OtherUserDeatilScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserProfileDetail? user;
  UserProfileDetail? otherUser;
  late ApiCallProvider apiCallProvider;
  List<FeedModel> momentsList = [];
  bool isFriend = false;
  bool isRequested = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0;
    _tabController.addListener(
      () {
        setState(() {});
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSelfUserData();
      loadUserData();
      loadMoments();
      setVistor();
    });
  }

  void loadSelfUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
        });
      },
    );
  }

  void setVistor() async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'otherUserId': widget.otherUserId
    };
    await apiCallProvider.postRequest(API.setVisitor, reqBody).then(
          (value) {},
        );
  }

  Future<void> followUnfollow(String type) async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'followingUserId': widget.otherUserId,
      'type': type
    };
    await apiCallProvider.postRequest(API.followUnfollow, reqBody).then(
      (value) {
        if (value['message'] != null) {
          showToastMessage(value['message']);
        }

        setState(() {});
        if (type == 'follow') {
          loadUserData();
        }
      },
    );
  }

  void blockUnblock() async {
    Map<String, dynamic> reqBody = {
      'blocker': prefs.getString(PrefsKey.userId),
      'blockerTo': widget.otherUserId
    };
    apiCallProvider.postRequest(API.blockUnblock, reqBody).then(
      (value) {
        if (value['message'] != null) {
          showToastMessage(value['message']);
        }

        setState(() {});
        loadUserData();
      },
    );
  }

  void loadMoments() async {
    momentsList.clear();
    Map<String, dynamic> reqBody = {
      'userId': widget.otherUserId,
      'otherId': widget.otherUserId
    };
    apiCallProvider.postRequest(API.feedDetails, reqBody).then(
      (value) {
        if (value['details'] != null) {
          for (Map<String, dynamic> item in value['details']) {
            momentsList.add(FeedModel.fromMap(item));
          }
          setState(() {});
        }
      },
    );
  }

  loadUserData() async {
    isFriend = await FirebaseDbService.isMyFriend(
        prefs.getString(PrefsKey.userId) ?? '', widget.otherUserId);
    isRequested = await FirebaseDbService.isFriendRequested(
        prefs.getString(PrefsKey.userId) ?? '', widget.otherUserId);

    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId) ?? '0',
      'otherUserId': widget.otherUserId,
      'kickTo': prefs.getString(PrefsKey.userId) ?? '0'
    };
    apiCallProvider.postRequest(API.getUserDataById, reqBody).then((value) {
      if (value['details'] != null) {
        otherUser = UserProfileDetail.fromMap(value['details']);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return Scaffold(
      body: getBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          horizontalGap(10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: isRequested
                  ? null
                  : isFriend
                      ? () async {
                          ChatWindowModel chatWindowModel = ChatWindowModel(
                              chatWindowId: getChatRoomId(otherUser?.id ?? '',
                                  prefs.getString(PrefsKey.userId)!),
                              currentUser: user,
                              friendUser:
                                  UserProfileDetailConverter.toVisitorModel(
                                      otherUser));
                          Navigator.of(context, rootNavigator: true).pushNamed(
                              ChatWindow.route,
                              arguments: chatWindowModel);
                        }
                      : () async {
                          // Call Friend request

                          FirebaseUserModel friendReqestModel =
                              FirebaseUserModel(
                                  image: user?.image,
                                  name: user?.name,
                                  userId: user?.id,
                                  userName: user?.username);

                          await FirebaseDbService.addFriendRequest(
                              friendReqestModel, otherUser?.id ?? '');
                          loadUserData();
                          String type = 'friendRequest';
                          await followUnfollow(type).then(
                            (value) async {},
                          );
                        },
              label: isRequested
                  ? Text('Requested')
                  : isFriend
                      ? Text('Chat')
                      : Text('Add'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                disabledBackgroundColor: Color(
                  0xFFFBC100,
                ),
                backgroundColor: Color(
                  0xFFFBC100,
                ),
              ),
              icon: Icon(
                isRequested
                    ? Icons.person_add_alt_1_sharp
                    : isFriend
                        ? Icons.chat_outlined
                        : Icons.person_add_alt,
                color: Colors.white,
              ),
            ),
          ),
          horizontalGap(20),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                String type = 'follow';
                followUnfollow(type);
              },
              label: Text(
                  (otherUser?.followStatus ?? false) ? 'Following' : 'Follow'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Color(0xFF01ACFE),
              ),
              icon: Icon(
                (otherUser?.followStatus ?? false) ? Icons.remove : Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          horizontalGap(10),
        ],
      ),
    );
  }

  getBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: profileTopWidget(),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                indicatorColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.only(bottom: 10),
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                tabs: const [
                  Tab(
                    text: 'MOMENTS',
                  ),
                  Tab(
                    text: 'DETAILED PROFILE',
                  ),
                ],
              ),
              if (_tabController.index == 0) ...{
                if (momentsList.isEmpty) ...{
                  Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: Text(
                      'No moments created yet!',
                      style: TextStyle(color: hintColor),
                    ),
                  )
                } else ...{
                  for (FeedModel moment in momentsList) ...{
                    getMomentCard(moment)
                  },
                  SizedBox(
                    height: 50,
                  )
                }
              } else ...{
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF3CAFEE),
                    child: SvgPicture.asset(
                      'assets/svg/trophy_1_.svg',
                      color: Colors.white,
                      width: 20,
                    ),
                  ),
                  title: Text('Gift Wall'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  onTap: () {},
                )
              },
              verticalGap(70)
            ],
          ),
        )
      ],
    );
  }

  Container profileTopWidget() {
    return Container(
      height: 350,
      child: Stack(
        children: [
          (otherUser?.image ?? '').isEmpty
              ? Container(
                  color: Colors.grey,
                  height: 300,
                  width: double.infinity,
                )
              : InkWell(
                  onTap: () => Navigator.of(context, rootNavigator: true)
                      .pushNamed(NetworkImagePreviewFullScreen.route,
                          arguments: otherUser?.image ?? ''),
                  child: CachedNetworkImage(
                    imageUrl: otherUser?.image ?? '',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey,
                      height: 300,
                      width: double.infinity,
                    ),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                title: Text(
                  otherUser?.name ?? '',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'report':
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            ReportCategory.route,
                            arguments: ReportModel(
                              postId: '',
                              userId: prefs.getString(PrefsKey.userId),
                              otherUserId: otherUser?.id,
                            ),
                          );
                          break;
                        case 'block':
                          blockUnblock();
                          break;
                        case 'Unfriend':
                          String type = 'removeFriend ';
                          followUnfollow(type);
                          break;
                      }
                    },
                    icon: Icon(Icons.more_horiz),
                    iconColor: Colors.white,
                    iconSize: 40,
                    position: PopupMenuPosition.under,
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'report',
                          child: Text('Report'),
                        ),
                        PopupMenuItem<String>(
                          value: 'block',
                          child: Text(
                              '${(otherUser?.blockStatus ?? false) ? 'Remove from' : 'Add to'}  blocklist'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Unfriend',
                          child: Text('Unfriend'),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () => Navigator.of(context, rootNavigator: true)
                        .pushNamed(NetworkImagePreviewFullScreen.route,
                            arguments: otherUser?.image ?? ''),
                    child: BorderedCircularImage(
                      borderColor: Colors.white,
                      borderThickness: 2,
                      diameter: 80,
                      imagePath: otherUser?.image ?? '',
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: pagePadding),
                    child: Text(
                      otherUser?.name ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: otherUser?.liveStatus ?? false,
                    child: InkWell(
                      onTap: () async {
                        if (otherUser?.userLive?.password?.isNotEmpty ??
                            false) {
                          String? isPasswordVerified = await showPasswordDialog(
                              context, otherUser!.userLive!.password!);
                          if (isPasswordVerified != 'true') {
                            return;
                          }
                        }
                        LiveRoomDetailModel liveRoomDetailModel =
                            LiveRoomDetailModel(
                          channelName: otherUser?.userLive?.channelName,
                          mainId: otherUser?.userLive?.id,
                          token: otherUser?.userLive?.rtmToken,
                          isSelfCreated: false,
                          roomCreatedBy: otherUser?.userLive?.userId,
                        );
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(LiveRoomScreen.route,
                                arguments: liveRoomDetailModel)
                            .then(
                              (value) {},
                            );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset(
                          'assets/image/audio-8777_128.gif',
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: pagePadding, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                          color: otherUser?.gender == 'Male'
                              ? Color(0xFF0FDEA5)
                              : Color.fromARGB(255, 245, 97, 250),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            otherUser?.gender == 'Male'
                                ? Icons.male
                                : Icons.female,
                            color: Colors.white,
                            size: 12,
                          ),
                          horizontalGap(5),
                          Text(
                            '${otherUser?.age}',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    horizontalGap(5),
                    if ((otherUser?.lavelInfomation?.sendLevel ?? '0') != '0')
                      Container(
                        constraints: BoxConstraints(minWidth: 70),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(
                                otherUser?.lavelInfomation?.sandBgImage ?? '',
                              ),
                              fit: BoxFit.fill),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/image/starlevel.png',
                              width: 12,
                            ),
                            horizontalGap(5),
                            Text(
                              '${otherUser?.lavelInfomation?.sendLevel}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    horizontalGap(10),
                    if ((otherUser?.lavelInfomation?.reciveLevel ?? '0') != '0')
                      Container(
                        constraints: BoxConstraints(minWidth: 70),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(
                                otherUser?.lavelInfomation?.reciveBgImage ?? '',
                              ),
                              fit: BoxFit.fill),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/image/coins_img.png',
                              width: 12,
                            ),
                            horizontalGap(5),
                            Text(
                              otherUser?.lavelInfomation?.reciveLevel ?? '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      width: 90,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/image/family_badge_23.webp',
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            otherUser?.familyName ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pagePadding),
                child: Row(
                  children: [
                    Text(
                      'ID:${otherUser?.username ?? ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 1,
                      height: 10,
                      color: Colors.white,
                    ),
                    Text(
                      '${otherUser?.country ?? ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 1,
                      height: 10,
                      color: Colors.white,
                    ),
                    Text(
                      'Fans:${otherUser?.followersCount ?? ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 10),
                    //   width: 1,
                    //   height: 10,
                    //   color: Colors.white,
                    // ),
                    // Text(
                    //   'Following:${otherUser?.followingCount ?? ''}',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 5),
                    //   width: 1,
                    //   height: 10,
                    //   color: Colors.white,
                    // ),
                    // Text(
                    //   'Visitor:${otherUser?.visitorsCount ?? ''}',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 5),
                    //   width: 1,
                    //   height: 10,
                    //   color: Colors.white,
                    // ),
                    // Text(
                    //   'Friends:${otherUser?.friendsCount ?? ''}',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 315,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(otherUser?.bio ?? ''),
            ),
          ),
        ],
      ),
    );
  }

  Widget getProfileMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalGap(5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Container getMomentCard(FeedModel moment) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              horizontalGap(pagePadding / 2),
              CircularImage(imagePath: moment.image ?? '', diameter: 35),
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
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        ReportCategory.route,
                        arguments: ReportModel(
                          postId: moment.id,
                          userId: prefs.getString(PrefsKey.userId),
                          otherUserId: otherUser?.id,
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
            constraints: BoxConstraints(
              maxHeight: 300.0,
            ),
            color: Colors.white,
            child: moment.mediaStatus == '1'
                ? FeedVideoPlayer(
                    url: moment.media ?? '',
                    play: false,
                  )
                : CachedNetworkImage(
                    imageUrl: moment.media ?? '',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text('Error ${error.toString()}'),
                    ),
                    fit: BoxFit.fitWidth,
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
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(
                    CommentScreen.route,
                    arguments: CommentData(
                        feedId: moment.mediaId,
                        senderId: otherUser?.id,
                        senderImage: otherUser?.image,
                        feedSenderId: moment.userId),
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
                  apiCallProvider.postRequest(API.likeDislike, {
                    'userId': otherUser?.id ?? '0',
                    'feedId': moment.mediaId
                  }).then(
                    (value) {
                      setState(() {
                        moment.likeCount = value['likeCount'].toString();
                        moment.likeStatus = value['likeUnLikestatus'];
                      });
                    },
                  );
                },
                child: moment.likeStatus ?? false
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
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(
                CommentScreen.route,
                arguments: CommentData(
                    feedId: moment.mediaId,
                    senderId: otherUser?.id,
                    senderImage: otherUser?.image,
                    feedSenderId: moment.userId),
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
              getTimesAgo(moment.postCreateddateTime ?? ''),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
