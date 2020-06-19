import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

class SelectBoardScreenArguments {
  SelectBoardScreenArguments({
    this.newPin,
  });

  final NewPin newPin;
}

class SelectBoardScreen extends StatelessWidget {
  SelectBoardScreen({this.args});

  final SelectBoardScreenArguments args;

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
