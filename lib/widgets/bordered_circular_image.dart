import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BorderedCircularImage extends StatelessWidget {
  final String imagePath;
  final double diameter;
  final Color borderColor;
  final double borderThickness;
  const BorderedCircularImage({
    super.key,
    required this.imagePath,
    required this.diameter,
    required this.borderColor,
    required this.borderThickness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter + borderThickness,
      height: diameter + borderThickness,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderThickness),
      ),
      child: ClipOval(
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
                  backgroundImage: imageProvider,
                  radius: diameter / 2,
                ),
                width: diameter,
                height: diameter,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
