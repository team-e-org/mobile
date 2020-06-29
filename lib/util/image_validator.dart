import 'dart:io';

import 'package:flutter/material.dart';

class ImageValidator {
  ImageValidator({
    @required this.maxSizeInBytes,
  });

  final int maxSizeInBytes;

  Future<bool> validate(File image) async {
    final byteLength = await image.length();
    if (byteLength > maxSizeInBytes) {
      return false;
    }

    // TODO: ファイル形式をチェックする
    return true;
  }
}
