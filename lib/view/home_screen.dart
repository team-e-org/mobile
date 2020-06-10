import 'package:flutter/material.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MockScreenCommon(
        name: 'Home screen',
      ),
    );
  }
}
