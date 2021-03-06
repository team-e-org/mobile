import 'package:flutter/material.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

class PinSelectPhotoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select photo'),
      ),
      body: Container(
        child: RaisedButton(
          child: Text('Next'),
          onPressed: () {
            Navigator.pushNamed(context, Routes.createNewPinEdit);
          },
        ),
      ),
    );
  }
}
