// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/add_moments.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/comment.dart';
import 'package:worldsocialintegrationapp/screens/home_container/profile/edit_profile.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/bordered_circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/feed_video_player.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';
import 'package:worldsocialintegrationapp/widgets/network_image_preview_fullscreen.dart';

import '../../../models/comment_data.dart';
import '../../../models/feed.dart';
import '../../../models/user_profile_detail.dart';
import '../../../providers/api_call_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/generic_api_calls.dart';
import '../friends/friend_fans_following.dart';
import '../friends/friend_navigator_model.dart';

class ProfileDeatilScreen extends StatefulWidget {
  const ProfileDeatilScreen({super.key});
  static const String route = '/profileDeatilScreen';

  @override
  State<ProfileDeatilScreen> createState() => _ProfileDeatilScreenState();
}

class _ProfileDeatilScreenState extends State<ProfileDeatilScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserProfileDetail? user;
  List<FeedModel> momentsList = [];
  late ApiCallProvider apiCallProvider;

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
      loadUserData();
      loadMoments();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddMoments.route).then(
            (value) {
              loadMoments();
            },
          );
        },
        backgroundColor: themePinkDark,
        child: Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
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
              verticalGap(20),
              Row(
                children: [
                  horizontalGap(20),
                  Text('Bio:'),
                  horizontalGap(10),
                  Text(user?.bio ?? ''),
                ],
              ),
              verticalGap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(
                              FriendFansFollowing.route,
                              arguments: FriendNavigatorModel(
                                  index: 2, userId: user?.id ?? ''),
                            )
                            .then(
                              (value) => loadUserData(),
                            );
                      },
                      child:
                          getProfileMetric('Fans', '${user?.followersCount}')),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(
                            FriendFansFollowing.route,
                            arguments: FriendNavigatorModel(
                                index: 1, userId: user?.id ?? ''),
                          )
                          .then(
                            (value) => loadUserData(),
                          );
                    },
                    child: getProfileMetric(
                        'Following', '${user?.followingCount ?? 0}'),
                  ),
                ],
              ),
              Divider(
                height: 30,
                thickness: 5,
                color: Colors.grey.withOpacity(0.1),
              ),
              TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                indicatorColor: themePinkDark,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.only(bottom: 10),
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: themePinkDark,
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
                  }
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
              }
            ],
          ),
        )
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
                    case 'remove':
                      showDeleteMomentPopup(moment);

                      break;
                  }
                },
                position: PopupMenuPosition.under,
                itemBuilder: (BuildContext context) {
                  return [
                    if (moment.userId != user?.id)
                      PopupMenuItem<String>(
                        value: 'report',
                        child: Text('Report'),
                      ),
                    PopupMenuItem<String>(
                      value: 'remove',
                      child: Text('Remove'),
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
                  Navigator.of(context)
                      .pushNamed(
                    CommentScreen.route,
                    arguments: CommentData(
                        feedId: moment.mediaId,
                        senderId: prefs.getString(PrefsKey.userId),
                        senderImage: user?.image,
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
                    'userId': user?.id ?? '0',
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
              Navigator.of(context)
                  .pushNamed(
                CommentScreen.route,
                arguments: CommentData(
                    feedId: moment.mediaId,
                    senderId: prefs.getString(PrefsKey.userId),
                    senderImage: user?.image,
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

  Container profileTopWidget() {
    return Container(
      height: 350,
      child: Stack(
        children: [
          (user?.image ?? '').isEmpty
              ? Container(
                  color: Colors.grey,
                  height: 300,
                  width: double.infinity,
                )
              : InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      NetworkImagePreviewFullScreen.route,
                      arguments: user?.image ?? ''),
                  child: CachedNetworkImage(
                    imageUrl: user?.image ?? '',
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
          SizedBox(
            height: 80,
            child: AppBar(
              toolbarHeight: 50,
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditProfile.route).then(
                      (value) {
                        loadUserData();
                      },
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/svg/edit__2___1_.svg',
                    width: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 250,
            left: 10,
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      NetworkImagePreviewFullScreen.route,
                      arguments: user?.image ?? ''),
                  child: BorderedCircularImage(
                    borderColor: Colors.white,
                    borderThickness: 1,
                    diameter: 75,
                    imagePath: user?.image ?? '',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Chip(
                            backgroundColor:
                                Colors.transparent.withOpacity(0.5),
                            label: Text(
                              user?.name ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          horizontalGap(10),
                          Container(
                            constraints: BoxConstraints(minWidth: 70),
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/image/level_1.png',
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
                                const Text(
                                  '22',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          horizontalGap(10),
                          Container(
                            constraints: BoxConstraints(minWidth: 70),
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/image/level_9.png',
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
                                const Text(
                                  '22',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          horizontalGap(5),
                          const Text('10188\nindia'),
                          horizontalGap(10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: const BoxDecoration(
                                color: Color(0xFF0FDEA5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.male,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                horizontalGap(5),
                                const Text(
                                  '22',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )
                              ],
                            ),
                          ),
                          horizontalGap(5),
                          Image.asset(
                            'assets/image/vip1img.png',
                            width: 40,
                          ),
                          horizontalGap(5),
                          Image.asset(
                            'assets/image/dollarrr.png',
                            width: 25,
                          ),
                          horizontalGap(10),
                          Image.asset(
                            'assets/image/microphoneicon.png',
                            width: 40,
                          ),
                          horizontalGap(10),
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
                                  user?.familyName ?? '',
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
                    )
                  ],
                )
              ],
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

  void loadUserData() async {
    await getCurrentUser().then(
      (value) {
        setState(() {
          user = value;
        });
      },
    );
  }

  void loadMoments() async {
    momentsList.clear();
    String? userId = await prefs.getString(PrefsKey.userId) ?? '0';
    Map<String, dynamic> reqBody = {'userId': userId, 'otherId': userId};
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

  void deletePost(FeedModel moment) {
    apiCallProvider.postRequest(API.removeUserPost,
        {'userId': user?.id ?? '0', 'id': moment.mediaId}).then(
      (value) {
        if (value['success'] == '1') {
          momentsList.remove(moment);
          setState(() {});
        }
      },
    );
  }

  void showDeleteMomentPopup(FeedModel moment) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Moment'),
          content: const Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () async {
                deletePost(moment);
                Navigator.of(context).pop();
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
