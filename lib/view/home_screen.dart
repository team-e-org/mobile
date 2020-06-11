import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/components.dart';

class HomeScreen extends StatelessWidget {
  var pins = [Pin.fromMock(), Pin.fromMock(), Pin.fromMock(), Pin.fromMock()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: PinGridView(pins: pins),
      ),
    );
  }
}
