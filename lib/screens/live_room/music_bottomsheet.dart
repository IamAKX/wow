import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/screens/live_room/load_music_bottomsheet.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class MusicBottomsheet extends StatefulWidget {
  const MusicBottomsheet({super.key});

  @override
  State<MusicBottomsheet> createState() => _MusicBottomsheetState();
}

class _MusicBottomsheetState extends State<MusicBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9, // Set height to 60% of screen height
      child: ClipRRect(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                    ),
                  ),
                  horizontalGap(10),
                  Text(
                    'Music',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // To enable custom height
                        builder: (context) => const LoadMusicBottomsheet(),
                      );
                    },
                    child: Text('Scan'),
                  )
                ],
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true, // To enable custom height
                          builder: (context) => const LoadMusicBottomsheet(),
                        );
                      },
                      child: Text('Scan and add from your phone'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
