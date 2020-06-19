import 'package:flutter/material.dart';

class PinterestTypography extends Text {
  PinterestTypography.body1(
    String data, {
    TextOverflow overflow,
    int maxLines,
    Color color,
  }) : super(
          data,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 18,
            color: color,
          ),
        );

  PinterestTypography.body2(
    String data, {
    TextOverflow overflow,
    int maxLines,
    Color color,
  }) : super(
          data,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 14,
            color: color,
          ),
        );

  PinterestTypography.header(
    String data, {
    TextOverflow overflow,
    int maxLines,
    Color color,
  }) : super(
          data,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 32,
            color: color,
          ),
        );
}
