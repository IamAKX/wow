import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class LiveEndPopup extends StatefulWidget {
  const LiveEndPopup({super.key, required this.roomId, required this.userId});
  final String roomId;
  final String userId;

  @override
  State<LiveEndPopup> createState() => _LiveEndPopupState();
}

class _LiveEndPopupState extends State<LiveEndPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalGap(80),
            Text(
              'Live End',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalGap(40),
            GridView(
              padding: const EdgeInsets.all(10),
              primary: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 50,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              children: [
                getGridItems('00:00:05', 'Live Duration'),
                getGridItems('4', 'Diamond'),
                getGridItems('1', 'Total Audience'),
                getGridItems('0', 'Minimum Audience'),
                getGridItems('0', 'New Follows'),
                getGridItems('8', 'Share Number'),
              ],
            ),
            verticalGap(20),
            Text(
              'This live is over. Share your live\nwith others.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            verticalGap(20),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purpleAccent,
                      Colors.deepPurpleAccent,
                    ],
                  ),
                ),
                child: Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getGridItems(String heading, String subheading) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          heading,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        verticalGap(10),
        Text(
          subheading,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
        )
      ],
    );
  }
}
