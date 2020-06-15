import 'package:flutter/material.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

class SelectBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select board'),
      ),
      body: Container(
        child: RaisedButton(
          child: Text('Select board'),
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          },
        ),
      ),
    );
  }
}
