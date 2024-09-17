import 'dart:developer';
import 'dart:io';

import 'package:files_scanner_android/files_scanner_android.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';
import 'package:path_provider/path_provider.dart';

class LoadMusicBottomsheet extends StatefulWidget {
  const LoadMusicBottomsheet({super.key});

  @override
  State<LoadMusicBottomsheet> createState() => _LoadMusicBottomsheetState();
}

class _LoadMusicBottomsheetState extends State<LoadMusicBottomsheet> {
  List<File> list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAudioFile();
    });
  }

  Future<List<File>> getMp3FilesFromStorage() async {
    List<File> mp3Files = [];

    // Request storage permission
    if (await Permission.storage.request().isGranted) {
      // Get the external storage directory
      Directory? externalDir = await getExternalStorageDirectory();

      if (externalDir != null) {
        // Recursively scan the storage for mp3 files
        log('calling scan');
        mp3Files = await _scanDirectory(externalDir);
      }
    }

    return mp3Files;
  }

  Future<List<File>> _scanDirectory(Directory directory) async {
    List<File> mp3Files = [];
    log('scanning : ${directory}');
    try {
      List<FileSystemEntity> entities = directory.listSync(recursive: true);
      log('entities : $entities - ${entities.length}');
      for (FileSystemEntity entity in entities) {
        if (entity is File && entity.path.endsWith(".mp3")) {
          mp3Files.add(entity);
        }
      }
    } catch (e) {
      print("Error scanning directory: $e");
    }

    return mp3Files;
  }

  loadAudioFile() async {
    list = await getMp3FilesFromStorage();
    setState(() {});
    log('list : ${list.length}');
  }

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
                  const Text(
                    'Local Added',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Save'),
                  )
                ],
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => ListTile(),
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
                        ),
                    itemCount: list.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
