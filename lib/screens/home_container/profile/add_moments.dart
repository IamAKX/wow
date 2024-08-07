import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class AddMoments extends StatefulWidget {
  static const String route = '/addMoments';

  const AddMoments({super.key});

  @override
  State<AddMoments> createState() => _AddMomentsState();
}

class _AddMomentsState extends State<AddMoments> {
  final TextEditingController _descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add Moment'),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        Card(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: TextField(
                      controller: _descCtrl,
                      keyboardType: TextInputType.text,
                      maxLines: 20,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        hintText: 'Description here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 5,
                  height: double.infinity,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        verticalGap(pagePadding),
        getCancelUploadButton(),
      ],
    );
  }

  Padding getCancelUploadButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: const Color(0xFFFE6E49),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Cancle',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          horizontalGap(10),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3488D5),
                      Color(0xFFEA0A8A),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Upload',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
