import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/sending_receiving_gifting_model.dart';
import 'package:worldsocialintegrationapp/screens/home_container/explore/gift_wall.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/api.dart';
import '../../../widgets/circular_image.dart';
import '../../../widgets/gaps.dart';

class GiftWallMore extends StatefulWidget {
  const GiftWallMore({super.key});
  static const String route = '/giftWallMore';

  @override
  State<GiftWallMore> createState() => _GiftWallMoreState();
}

class _GiftWallMoreState extends State<GiftWallMore> {
  late ApiCallProvider apiCallProvider;
  List<SenderReceiverGiftingModel> list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getGiftWall();
    });
  }

  getGiftWall() async {
    await apiCallProvider
        .getRequest(API.getSenderReceiverGifting)
        .then((value) {
      list.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          list.add(SenderReceiverGiftingModel.fromJson(item));
        }
        setState(() {});
      }
    });
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(GiftWall.route);
            },
            icon: const Icon(Icons.help_outline),
          ),
        ],
        title: const Text(
          'GiftWall',
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return apiCallProvider.status == ApiStatus.loading
        ? const DefaultPageLoader()
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.5,
            ),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return getProfileCouple(list.elementAt(index));
            },
          );
  }

  Column getProfileCouple(SenderReceiverGiftingModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: Stack(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularImage(
                        imagePath: item.senderImage ?? '', diameter: 60),
                    horizontalGap(10),
                    CircularImage(
                        imagePath: item.receiverImage ?? '', diameter: 60),
                  ],
                ),
              ),
              Container(
                width: 130,
                height: 60,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/image/lion.png',
                  width: 30,
                ),
              )
            ],
          ),
        ),
        verticalGap(5),
        Row(
          children: [
            horizontalGap(10),
            Expanded(
                child: Text(
              item.senderName ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            )),
            horizontalGap(10),
            Expanded(
                child: Text(
              item.receiverName ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            )),
            horizontalGap(10),
          ],
        ),
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Color(0xFFDFDFE1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/image/money.png',
                width: 12,
              ),
              horizontalGap(5),
              Text(
                item.diamond?.split('.').first ?? '',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
