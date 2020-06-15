import 'package:flutter/material.dart';

class PinterestTypography extends Text {
  PinterestTypography.body1(String data)
      : super(data, style: TextStyle(fontSize: 18));

  PinterestTypography.body2(String data)
      : super(data, style: TextStyle(fontSize: 14));

  PinterestTypography.header(String data)
      : super(data, style: TextStyle(fontSize: 32));
}
