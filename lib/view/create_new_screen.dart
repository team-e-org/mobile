import 'package:flutter/material.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

class CreateNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Container(
        child: MockScreenCommon(
          name: 'Create new screen',
        ),
      ),
    );
  }
}
