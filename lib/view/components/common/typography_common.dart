import 'package:flutter/material.dart';

class PinterestTypography extends Text {
  PinterestTypography.body1(
    String data, {
    TextOverflow overflow,
    int maxLines,
  }) : super(
          data,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 18,
          ),
        );

  PinterestTypography.body2(
    String data, {
    TextOverflow overflow,
    int maxLines,
  }) : super(
          data,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(fontSize: 14),
        );

  PinterestTypography.header(
    String data, {
    TextOverflow overflow,
    int maxLines,
  }) : super(
          data,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(fontSize: 32),
        );
}
