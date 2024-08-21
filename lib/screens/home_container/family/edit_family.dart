import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../providers/api_call_provider.dart';

class EditFamily extends StatefulWidget {
  const EditFamily({super.key});
  static const String route = '/editFamily';

  @override
  State<EditFamily> createState() => _EditFamilyState();
}

class _EditFamilyState extends State<EditFamily> {
  late ApiCallProvider apiCallProvider;
  final TextEditingController familyNameCtrl = TextEditingController();
  final TextEditingController familyDescCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Todo: call api after screen load
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text('Edit Family Profile'),
          actions: [],
        ),
        body: getBody(context));
  }

  getBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(pagePadding),
      children: [
        verticalGap(pagePadding),
        const CircularImage(
          imagePath:
              'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg',
          diameter: 80,
        ),
        verticalGap(pagePadding),
        TextField(
          controller: familyNameCtrl,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: pagePadding, vertical: 0),
            hintText: 'Enter family name',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFB76C52),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFB76C52),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        verticalGap(pagePadding),
        TextField(
          controller: familyDescCtrl,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: pagePadding, vertical: 0),
            hintText: 'Description',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFB76C52),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFB76C52),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        verticalGap(pagePadding),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xffFE3400),
                Color(0xffFBC108),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent, // Text color
              shadowColor: Colors.transparent, // No shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        )
      ],
    );
  }
}
