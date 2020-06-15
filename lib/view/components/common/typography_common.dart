import 'package:flutter/material.dart';

class Typography extends Text {
  Typography.body1(String data) : super(data, style: TextStyle(fontSize: 20));

  Typography.body2(String data) : super(data, style: TextStyle(fontSize: 16));

  Typography.header(String data) : super(data, style: TextStyle(fontSize: 24));
}
