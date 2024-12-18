import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FramedCircularImage extends StatelessWidget {
  final String imagePath;
  final double imageSize;
  final String framePath;
  final double frameSize;
  const FramedCircularImage({
    super.key,
    required this.imagePath,
    required this.imageSize,
    required this.framePath,
    required this.frameSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: frameSize,
      height: frameSize,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipOval(
              child: imagePath.isEmpty
                  ? Image.asset(
                      'assets/dummy/demo_user_profile.png',
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: imagePath,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/dummy/demo_user_profile.png'),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                        radius: imageSize / 2,
                      ),
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(framePath),
          ),
        ],
      ),
    );
  }
}
