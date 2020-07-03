import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PinImage extends StatelessWidget {
  const PinImage(this.url);

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) {
        return _placeholder(
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (context, url, dynamic error) {
        return _placeholder(
            child: const Icon(
          Icons.error_outline,
        ));
      },
    );
  }

  Widget _placeholder({Widget child}) {
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Container(
        child: Center(child: child),
      ),
    );
  }
}
