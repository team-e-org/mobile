import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/theme.dart';

class PinImage extends StatelessWidget {
  const PinImage(
    this.url, {
    this.fit = BoxFit.contain,
  });

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
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
        color: ColorPalettes.defaultPalette.divider,
        child: Center(child: child),
      ),
    );
  }
}
