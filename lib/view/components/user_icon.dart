import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({
    this.imageUrl = '',
    this.onPressed,
    this.radius = 16,
    this.margin = const EdgeInsets.all(0),
  });

  final String imageUrl;
  final VoidCallback onPressed;
  final double radius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: RawMaterialButton(
        onPressed: onPressed,
        child: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(imageUrl),
          radius: radius,
        ),
      ),
    );
  }
}
