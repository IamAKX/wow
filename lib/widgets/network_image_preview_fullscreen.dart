import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:worldsocialintegrationapp/utils/dimensions.dart';

class NetworkImagePreviewFullScreen extends StatelessWidget {
  final String filePathOrUrl;
  static const String route = '/networkImagePreviewFullScreen';

  const NetworkImagePreviewFullScreen({super.key, required this.filePathOrUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: filePathOrUrl,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Container(
              padding: const EdgeInsets.all(pagePadding),
              child: Text(
                'Error : ${error.toString()}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            fit: BoxFit.fitWidth,
          ),
        ));
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
