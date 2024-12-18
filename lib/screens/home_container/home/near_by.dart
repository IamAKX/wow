import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/models/live_user.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';

import '../../../main.dart';
import '../../../models/country_continent.dart';
import '../../../models/joinable_live_room_model.dart';
import '../../../models/live_room_detail_model.dart';
import '../../../providers/api_call_provider.dart';
import '../../../services/location_service.dart';
import '../../../utils/api.dart';
import '../../../utils/helpers.dart';
import '../../../utils/prefs_key.dart';
import '../../live_room/live_room_screen.dart';

class NearBy extends StatefulWidget {
  const NearBy({super.key});

  @override
  State<NearBy> createState() => _NearByState();
}

class _NearByState extends State<NearBy> {
  late ApiCallProvider apiCallProvider;

  List<LiveUser> roomList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadLiveRoom();
    });
  }

  loadLiveRoom() async {
    CountryContinent? countryContinent =
        await LocationService().getCurrentLocation();
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'longitude': countryContinent?.position?.longitude,
      'latitude': countryContinent?.position?.latitude,
      'kickTo': prefs.getString(PrefsKey.userId),
    };
    apiCallProvider.postRequest(API.nearByUsers, reqBody).then((value) {
      roomList.clear();
      if (value['details'] != null) {
        for (var item in value['details']) {
          roomList.add(LiveUser.fromMap(item));
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      body: (apiCallProvider.status == ApiStatus.loading && roomList.isEmpty)
          ? DefaultPageLoader()
          : (roomList.isEmpty)
              ? Center(child: Text('No Live room near by'))
              : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      primary: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1),
      itemCount: roomList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            if (roomList.elementAt(index).password?.isNotEmpty ?? false) {
              String? isPasswordVerified = await showPasswordDialog(
                  context, roomList.elementAt(index).password!);
              if (isPasswordVerified != 'true') {
                return;
              }
            }
            LiveRoomDetailModel liveRoomDetailModel = LiveRoomDetailModel(
              channelName: roomList.elementAt(index).channelName,
              mainId: roomList.elementAt(index).userLiveId,
              token: roomList.elementAt(index).rtmToken,
              isSelfCreated: false,
              roomCreatedBy: roomList.elementAt(index).userId,
            );
            Navigator.of(context, rootNavigator: true)
                .pushNamed(LiveRoomScreen.route, arguments: liveRoomDetailModel)
                .then(
              (value) {
                loadLiveRoom();
              },
            );
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: roomList.elementAt(index).liveimage ??
                      'https://images.pexels.com/photos/129733/pexels-photo-129733.jpeg',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/image/wooden_bg.jpeg',
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: const [
                        Color(0xFFEC0DDC),
                        Color(0xFF8E18FE),
                      ],
                    ),
                  ),
                  child: Text(
                    roomList.elementAt(index).imageTitle ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 5,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: const [
                        Color(0xFFEB5716),
                        Color(0xFFECBC1E),
                      ],
                    ),
                  ),
                  child: Text(
                    roomList.elementAt(index).imageText ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    roomList.elementAt(index).liveCount ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Image.asset(
                  'assets/image/audio-8777_128.gif',
                  width: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> showPasswordDialog(
      BuildContext context, String roomPassword) async {
    TextEditingController passwordController = TextEditingController();

    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Room Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Room is locked, enter password to enter'),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                controller: passwordController,
                obscureText: true, // To hide the text for password input
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(); // Close dialog without returning a value
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (roomPassword == passwordController.text) {
                  Navigator.pop(context, 'true');
                } else {
                  showToastMessage('Incorrect password');
                  Navigator.pop(context, 'false');
                } // Return the password
              },
              child: const Text('Enter'),
            ),
          ],
        );
      },
    );
  }
}
