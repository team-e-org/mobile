import 'package:flutter/material.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

class NewBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MockScreenCommon(
        name: 'New board screen',
      ),
    );
  }
}
