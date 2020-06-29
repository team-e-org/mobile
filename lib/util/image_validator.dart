import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mime/mime.dart' as m;

class ImageValidator {
  ImageValidator({
    @required this.maxSizeInBytes,
    this.acceptedMimeTypes = const [
      'image/jpeg',
      'image/jpg',
      'image/png',
      'image/heic',
    ],
  }) {
    resolver = m.MimeTypeResolver()
      ..addExtension('heic', 'image/heic')
      // heic header: ftyp
      // https://github.com/strukturag/libheif/issues/83
      ..addMagicNumber([
        0x00,
        0x00,
        0x00,
        0x18,
        0x66, // f
        0x74, // t
        0x79, // y
        0x70, // p
      ], 'image/heic');
  }

  final int maxSizeInBytes;
  final List<String> acceptedMimeTypes;
  m.MimeTypeResolver resolver;

  Future<bool> validate(File image) async {
    final byteLength = await image.length();
    if (byteLength > maxSizeInBytes) {
      return false;
    }

    final mt = _getMymeType(image);
    if (!acceptedMimeTypes.contains(mt)) {
      return false;
    }

    return true;
  }

  String _getMymeType(File file) {
    return resolver.lookup(file.path);
  }
}
