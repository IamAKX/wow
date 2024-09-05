import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/api.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../models/meet_model.dart';
import '../../../providers/api_call_provider.dart';

class MeetScreen extends StatefulWidget {
  const MeetScreen({super.key});

  @override
  State<MeetScreen> createState() => _MeetScreenState();
}

class _MeetScreenState extends State<MeetScreen> {
  List<MeetModel> list = [];
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  loadData() async {
    await apiCallProvider.getRequest(API.getTopGiftReceiver).then((value) {
      list.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(MeetModel.fromJson(item));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Top Trending Broadcasters',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.8),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showProfilePopup(context, list.elementAt(index));
                },
                child: getProfileItem(
                  list.elementAt(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column getProfileItem(MeetModel meet) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            CircularImage(imagePath: meet.image ?? '', diameter: 80),
            Positioned(
              right: -13,
              bottom: -13,
              child: Image.asset(
                'assets/image/ic_icon_check.png',
                width: 50,
              ),
            ),
          ],
        ),
        verticalGap(5),
        Text(
          meet.name ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.person,
              color: Colors.grey,
              size: 18,
            ),
            Text(
              meet.receiverId ?? '',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showProfilePopup(BuildContext context, MeetModel meet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero, // Removes padding inside the dialog
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl: meet.imageDp ?? '',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Text('Error ${error.toString()}'),
                  ),
                  fit: BoxFit.cover,
                  height: 300,
                  width: 300,
                ),
                verticalGap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(meet.name ?? ''),
                    horizontalGap(5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      decoration: const BoxDecoration(
                          color: Color(0xFFFF4492),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Icon(
                        meet.gender?.toLowerCase() == 'male'
                            ? Icons.male
                            : Icons.female,
                        size: 10,
                      ),
                    ),
                  ],
                ),
                verticalGap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'IN:   ${meet.myExp ?? 0}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        '💍 My❤️ ${meet.name ?? 0}💍',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF02D2D0),
                      shadowColor: const Color(0xFF02D2D0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('SAY HI'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
