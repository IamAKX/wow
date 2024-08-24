import 'package:flutter/material.dart';

import '../../../widgets/circular_image.dart';
import '../../../widgets/gaps.dart';

class SendFriendScreen extends StatefulWidget {
  const SendFriendScreen({super.key});
  static const String route = '/sendFriendScreen';

  @override
  State<SendFriendScreen> createState() => _SendFriendScreenState();
}

class _SendFriendScreenState extends State<SendFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircularImage(
            imagePath: 'someimgae.com',
            diameter: 50,
          ),
          title: Text(
            'Test $index',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: InkWell(
            onTap: () {
              showSendUp();
            },
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3488D5),
                    Color(0xFFEA0A8A),
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Send',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          subtitle: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: const BoxDecoration(
                    color: Color(0xFF0FDEA5),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      true ? Icons.male : Icons.female,
                      color: Colors.white,
                      size: 12,
                    ),
                    Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(10),
              Container(
                constraints: const BoxConstraints(minWidth: 50),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFEE9DA8),
                      const Color(0xFFEE9DA8).withOpacity(0.5),
                      const Color(0xFFEE9DA8).withOpacity(0.2)
                    ],
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/image/starlevel.png',
                      width: 10,
                    ),
                    horizontalGap(5),
                    const Text(
                      '2',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              horizontalGap(5),
              Image.asset(
                'assets/image/money.png',
                width: 15,
              ),
            ],
          ),
        );
      },
    );
  }

  void showSendUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled_sharp,
                      size: 20,
                      color: Color(0xFF7A7A7A),
                    ),
                    horizontalGap(5),
                    const Text(
                      '30',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              verticalGap(20),
              CircularImage(imagePath: 'cdsd', diameter: 100),
              verticalGap(20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/image/coins_img.png',
                    width: 20,
                  ),
                  const Text(
                    '4000',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              verticalGap(20),
              const Text(
                'Are you sure you want to send this car to your friend Test 2?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              verticalGap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  horizontalGap(20),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFF73201),
                      ),
                      child: const Text(
                        'Send',
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
