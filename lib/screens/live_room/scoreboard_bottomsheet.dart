import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/widgets/circular_image.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

import '../../providers/api_call_provider.dart';

class ScoreboardBottomsheet extends StatefulWidget {
  const ScoreboardBottomsheet({super.key});

  @override
  State<ScoreboardBottomsheet> createState() => _ScoreboardBottomsheetState();
}

class _ScoreboardBottomsheetState extends State<ScoreboardBottomsheet> {
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);

    return FractionallySizedBox(
      heightFactor: 0.7, // Set height to 60% of screen height
      child: ClipRRect(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: const Color(0xFFC39955),
                child: const Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    Spacer(),
                    Text(
                      'History',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 20,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          const CircularImage(imagePath: '', diameter: 40),
                          horizontalGap(20),
                          const Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Image.asset('assets/image/diamond.png'),
                          const Text(
                            '700',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          horizontalGap(10),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
