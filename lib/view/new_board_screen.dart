import 'package:flutter/material.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

class NewBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a new board',
        ),
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ), // Hide back button
      ),
      body: MockScreenCommon(
        name: 'New board screen',
      ),
    );
  }
}
