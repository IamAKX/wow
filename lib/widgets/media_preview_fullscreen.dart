import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaPreviewFullScreen extends StatelessWidget {
  final String filePathOrUrl;
  static const String route = '/mediaPreviewFullScreen';

  const MediaPreviewFullScreen({super.key, required this.filePathOrUrl});

  bool isImage(String path) {
    final imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'webp',
      'heic',
      'heif'
    ];
    return imageExtensions.contains(path.split('.').last.toLowerCase());
  }

  bool isVideo(String path) {
    final videoExtensions = ['mp4', 'mov', 'avi', 'webm', 'mkv'];
    return videoExtensions.contains(path.split('.').last.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: (isImage(filePathOrUrl))
                ? Image.file(
                    File(filePathOrUrl),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, size: 50);
                    },
                  )
                : (isVideo(filePathOrUrl))
                    ? VideoPlayerPreview(filePathOrUrl: filePathOrUrl)
                    : const Center(
                        child: Text('Unsupported media type'),
                      ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerPreview extends StatefulWidget {
  final String filePathOrUrl;

  const VideoPlayerPreview({super.key, required this.filePathOrUrl});

  @override
  VideoPlayerPreviewState createState() => VideoPlayerPreviewState();
}

class VideoPlayerPreviewState extends State<VideoPlayerPreview> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePathOrUrl))
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: true,
        );
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Chewie(
              controller: _chewieController,
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
