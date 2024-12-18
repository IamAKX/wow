import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:worldsocialintegrationapp/models/vip_model.dart';
import 'package:worldsocialintegrationapp/screens/vip/send_vip_to_friend.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../main.dart';
import '../../providers/api_call_provider.dart';
import '../../utils/api.dart';
import '../../utils/helpers.dart';
import '../../utils/prefs_key.dart';

class VipOptions extends StatefulWidget {
  const VipOptions({super.key, required this.vipModel});
  final VipModel vipModel;

  @override
  State<VipOptions> createState() => _VipOptionsState();
}

class _VipOptionsState extends State<VipOptions> {
  late ApiCallProvider apiCallProvider;

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://c4.wallpaperflare.com/wallpaper/620/81/253/pattern-design-dark-texture-wallpaper-preview.jpg',
          errorWidget: (context, url, error) => Center(
            child: Text('Error ${error.toString()}'),
          ),
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShapeOfView(
                elevation: 0,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                shape: ArcShape(
                    direction: ArcDirection.Outside,
                    height: 30,
                    position: ArcPosition.Top),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 80,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/image/vip_privileges.png'),
                              fit: BoxFit.fill),
                        ),
                        child: const Text(
                          'Privileges',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      verticalGap(10),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 1.8),
                          itemCount: widget.vipModel.privilegs?.length ?? 0,
                          itemBuilder: (context, index) {
                            Privilegs privilegs =
                                widget.vipModel.privilegs!.elementAt(index);
                            return Container(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  showPrivilegePopup(
                                      privilegs.alertBoxDetails, context);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: privilegs.icon ?? '',
                                      color: privilegs.isHighlight == '1'
                                          ? const Color(0xFFC5A36C)
                                          : Colors.grey,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child:
                                            Text('Error ${error.toString()}'),
                                      ),
                                      fit: BoxFit.fitWidth,
                                      width: 25,
                                    ),
                                    verticalGap(10),
                                    Text(
                                      privilegs.label ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: privilegs.isHighlight == '1'
                                              ? const Color(0xFFC5A36C)
                                              : Colors.grey,
                                          fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${widget.vipModel.coins ?? ''} coins / ${widget.vipModel.days ?? ''} days',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.vipModel.message ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              SendVipToFriendScreen.route,
                              arguments: widget.vipModel.vipLevel);
                        },
                        child: const Text('SEND'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFC5A36C)),
                          foregroundColor: const Color(0xFFC5A36C),
                        ),
                      ),
                      horizontalGap(10),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Purchase Confirmation'),
                                content: const Text('Do you want to purchase?'),
                                actions: [
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      buy();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('BUY'),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xFFC5A36C)),
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void showPrivilegePopup(
      AlertBoxDetails? alertBoxDetails, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (alertBoxDetails?.topButton?.isNotEmpty ?? false) ...{
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    alertBoxDetails?.topButton ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                verticalGap(10),
              },
              if (alertBoxDetails?.icon?.isNotEmpty ?? false) ...{
                CachedNetworkImage(
                  imageUrl: alertBoxDetails?.icon ?? '',
                  errorWidget: (context, url, error) => Center(
                    child: Text('Error ${error.toString()}'),
                  ),
                  fit: BoxFit.fitWidth,
                  width: 50,
                ),
                verticalGap(10),
              },
              if (alertBoxDetails?.title?.isNotEmpty ?? false) ...{
                Text(
                  alertBoxDetails?.title ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                verticalGap(10),
              },
              if (alertBoxDetails?.subtitle?.isNotEmpty ?? false) ...{
                Text(
                  alertBoxDetails?.subtitle ?? '',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              },
              if (alertBoxDetails?.secondary?.isNotEmpty ?? false) ...{
                Text(
                  alertBoxDetails?.secondary ?? '',
                  style: const TextStyle(
                      color: Color(0xFFC6B06C),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              },
              verticalGap(10),
              if (alertBoxDetails?.buttonText?.isNotEmpty ?? false) ...{
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0xFFA08327),
                      ), // background color
                    ),
                    child: Text(
                      alertBoxDetails?.buttonText ?? '',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              }
            ],
          ),
        );
      },
    );
  }

  void buy() async {
    Map<String, dynamic> reqBody = {
      'userId': prefs.getString(PrefsKey.userId),
      'vipId': widget.vipModel.vipLevel
    };
    await apiCallProvider.postRequest(API.buyVip, reqBody).then((value) {
      showToastMessage(value['message']);
      Navigator.pop(context);
    });
  }
}
