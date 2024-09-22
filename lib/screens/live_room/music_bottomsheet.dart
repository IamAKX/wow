import 'dart:io';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/screens/live_room/load_music_bottomsheet.dart';
import 'package:worldsocialintegrationapp/services/live_room_firebase.dart';
import 'package:worldsocialintegrationapp/services/storage_service.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/button_loader.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class MusicBottomsheet extends StatefulWidget {
  const MusicBottomsheet({super.key, required this.roomId});

  final String roomId;
  @override
  State<MusicBottomsheet> createState() => _MusicBottomsheetState();
}

class _MusicBottomsheetState extends State<MusicBottomsheet> {
  Set<String> fileList = {};
  int playingIndex = -1;
  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  bool _isPlaying = false;
  bool isUploading = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Listen to the player's duration and position updates
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMusicFile();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9, // Set height to 60% of screen height
      child: ClipRRect(
        child: Container(
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
                    onPressed: isUploading
                        ? null
                        : () {
                            _pauseAudio();
                            Navigator.pop(context);
                          },
                    icon: const Icon(
                      Icons.chevron_left,
                    ),
                  ),
                  horizontalGap(10),
                  const Text(
                    'Music',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        isUploading = true;
                      });
                      _pauseAudio();
                      Navigator.pop(context);
                      String downloadUrl = await StorageService.uploadFile(
                          File(fileList.elementAt(playingIndex)),
                          'liveRoomAudio/${widget.roomId}/${basename(fileList.elementAt(playingIndex))}');
                      await LiveRoomFirebase.updateLiveRoomMusic(
                          widget.roomId, downloadUrl);
                    },
                    child: isUploading
                        ? ButtonLoader(
                            color: Colors.black,
                          )
                        : const Text('SET'),
                  ),
                  TextButton(
                    onPressed: isUploading
                        ? null
                        : () async {
                            if (Platform.isAndroid) {
                              // await loadForAndroid(context);
                              await loadForIos();
                            } else if (Platform.isIOS) {
                              await loadForIos();
                            }
                          },
                    child: const Text('Add'),
                  )
                ],
              ),
              Expanded(
                child: fileList.isEmpty
                    ? Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (Platform.isAndroid) {
                                // await loadForAndroid(context);
                                await loadForIos();
                              } else if (Platform.isIOS) {
                                await loadForIos();
                              }
                            },
                            child: const Text('Add from your phone'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white)),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                log('Play');

                                playingIndex = index;
                                _playAudio(fileList.elementAt(index));
                                // if (_isPlaying && playingIndex == index) {
                                //   _pauseAudio();
                                // } else {
                                //   _playAudio(fileList.elementAt(index));
                                // }
                                setState(() {});
                              },
                              title: Text(
                                basename(
                                  fileList.elementAt(index),
                                ),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: (_isPlaying && playingIndex == index)
                                        ? Colors.green
                                        : Colors.black),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  _audioPlayer.stop();
                                  fileList.remove(fileList.elementAt(index));
                                  saveFile();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => const Divider(
                              color: Colors.grey,
                            ),
                        itemCount: fileList.length),
              ),
              if (playingIndex != -1) ...[
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.black,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause_circle : Icons.play_circle,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          if (_isPlaying) {
                            _pauseAudio();
                          } else {
                            _resumeAudio();
                          }
                        },
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                basename(fileList.elementAt(playingIndex)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Slider(
                              value: _currentPosition.inSeconds.toDouble(),
                              min: 0,
                              thumbColor: Colors.teal,
                              activeColor: Colors.teal,
                              inactiveColor: Colors.teal.shade100,
                              max: _totalDuration.inSeconds.toDouble(),
                              onChanged: (value) {
                                final newPosition =
                                    Duration(seconds: value.toInt());
                                _seekAudio(newPosition);
                              },
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    _formatDuration(_currentPosition),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    ' ${_formatDuration(_totalDuration)}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadForIos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'aac'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      fileList.add(result.files.single.path!);
      saveFile();
    } else {
      // User canceled the picker
    }
  }

  Future<void> loadForAndroid(BuildContext context) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;
    if (storageStatus == PermissionStatus.granted) {
      log("granted");
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // To enable custom height
        builder: (context) => const LoadMusicBottomsheet(),
      );
    }
    if (storageStatus == PermissionStatus.denied) {
      log("denied");
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  void loadMusicFile() {
    fileList = (prefs.getStringList(PrefsKey.localMusic) ?? []).toSet();
    setState(() {});
  }

  Future<void> saveFile() async {
    await prefs.setStringList(PrefsKey.localMusic, fileList.toList());
    loadMusicFile();
  }

  Future<void> _playAudio(String filePath) async {
    await _audioPlayer.play(DeviceFileSource(filePath));
    prefs.setString(PrefsKey.musicPlaying, filePath);
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    prefs.remove(PrefsKey.musicPlaying);
  }

  Future<void> _resumeAudio() async {
    await _audioPlayer.resume();
    prefs.remove(PrefsKey.musicPlaying);
  }

  Future<void> _seekAudio(Duration position) async {
    await _audioPlayer.seek(position);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}
