import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String imagePath;
  final double diameter;
  const CircularImage({
    super.key,
    required this.imagePath,
    required this.diameter,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(diameter),
      child: imagePath.isEmpty
          ? Image.asset(
              'assets/dummy/demo_user_profile.png',
              width: diameter,
              height: diameter,
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
                backgroundColor: Colors.transparent,
                backgroundImage: imageProvider,
                radius: diameter / 2,
              ),
              width: diameter,
              height: diameter,
              fit: BoxFit.cover,
            ),
    );
  }
}
