import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategorizedCircularImage extends StatelessWidget {
  final String imagePath;
  final double imageSize;
  final String categoryPath;

  const CategorizedCircularImage({
    super.key,
    required this.imagePath,
    required this.imageSize,
    required this.categoryPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
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
          Positioned(
            bottom: 2,
            right: 2,
            child: Image.asset(
              categoryPath,
              width: 15,
              height: 15,
            ),
          ),
        ],
      ),
    );
  }
}
