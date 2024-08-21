import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/family/create_family.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../../providers/api_call_provider.dart';

class PromptCreateFamily extends StatefulWidget {
  const PromptCreateFamily({super.key});
  static const String route = '/promptCreateFamily';

  @override
  State<PromptCreateFamily> createState() => _PromptCreateFamilyState();
}

class _PromptCreateFamilyState extends State<PromptCreateFamily> {
  late ApiCallProvider apiCallProvider;

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
      backgroundColor: const Color(0xFFF6F7F9),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF7DED84),
            Color(0xFF08A9A5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'Family',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(80, 70, 80, 10),
            child: Image.asset(
                'assets/image/createFamilyScreenImageBackgroundRemoved.png'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: pagePadding),
            child: Text(
              'What is a family',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          verticalGap(pagePadding),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: pagePadding),
            child: Text(
              'A family is an organization created by users on their own Users apply to join the family and work together with like _ minded partners to keep the family growing',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          verticalGap(pagePadding * 1.5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: pagePadding),
            child: Text(
              'Create conditions',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          verticalGap(pagePadding),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: pagePadding),
            child: Text(
              'Wealth level >=30',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(CreateFamily.route),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 15),
              margin: EdgeInsets.all(pagePadding),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFF714926),
                  )),
              child: const Text(
                'Create a Family',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6C6C6C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
