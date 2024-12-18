import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaPreview extends StatelessWidget {
  final String filePathOrUrl;
  static const String route = '/mediaPreview';

  const MediaPreview({super.key, required this.filePathOrUrl});

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
    if (isImage(filePathOrUrl)) {
      return Image.file(
        File(filePathOrUrl),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 50);
        },
      );
    } else if (isVideo(filePathOrUrl)) {
      return VideoPlayerPreview(filePathOrUrl: filePathOrUrl);
    } else {
      return const Center(child: Text('Unsupported media type'));
    }
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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePathOrUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
