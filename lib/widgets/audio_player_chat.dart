import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class ChatAudioPlayer extends StatefulWidget {
  const ChatAudioPlayer({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  State<ChatAudioPlayer> createState() => _ChatAudioPlayerState();
}

class _ChatAudioPlayerState extends State<ChatAudioPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Listen for audio duration and position changes
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    // Handle completion event
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  // Play or pause the audio
  Future<void> _togglePlayPause() async {
    log('$_isPlaying');
    if (_isPlaying) {
      await _audioPlayer.pause();
      _isPlaying = false;
    } else {
      await _audioPlayer.play(UrlSource(widget.url));
      _isPlaying = true;
    }
    setState(() {});
  }

  // Seek to a specific position
  Future<void> _seekTo(double seconds) async {
    final position = Duration(seconds: seconds.toInt());
    await _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(
        children: [
          InkWell(
            onTap: () => _togglePlayPause(),
            child: Icon(
              _isPlaying
                  ? Icons.pause_circle_filled_outlined
                  : Icons.play_circle_fill_outlined,
              size: 35,
            ),
          ),
          Expanded(
            child: Slider(
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds.toDouble(),
              onChanged: (value) {
                _seekTo(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
