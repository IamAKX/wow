import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedVideoPlayer extends StatefulWidget {
  final String url;
  final bool play;

  const FeedVideoPlayer({super.key, required this.url, required this.play});
  @override
  FeedVideoPlayerState createState() => FeedVideoPlayerState();
}

class FeedVideoPlayerState extends State<FeedVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isPlaying = false;
  bool _showControls = true;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    if (widget.play) {
      _controller.play();
      _controller.setLooping(true);
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
        _controller.setLooping(true);
      }
      isPlaying = !isPlaying;
    });
    _resetHideControlsTimer();
  }

  void _resetHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  @override
  void didUpdateWidget(FeedVideoPlayer oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.setLooping(true);
      } else {
        _controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // _togglePlayPause();
        setState(() {
          _showControls = !_showControls;
        });
        _resetHideControlsTimer();
      },
      child:

          // constraints: BoxConstraints(maxHeight: 200),
          // height: 250,
          Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text('Error loading video: ${snapshot.error}'));
                }
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          if (_controller.value.isInitialized && _showControls)
            Positioned.fill(
              child: Center(
                child: InkWell(
                  onTap: _togglePlayPause,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 20,
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
