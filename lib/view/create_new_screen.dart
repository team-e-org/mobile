import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/pin_edit_screen.dart';

class CreateNewScreen extends StatelessWidget {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: const Text('Board'),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.createNewBoard);
                },
              ),
              const SizedBox(width: 20),
              RaisedButton(
                child: const Text('Pin'),
                onPressed: () => _onPinPressed(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _onPinPressed(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final file = File(pickedFile.path);
    Navigator.of(context).pushReplacementNamed(
      Routes.createNewPinEdit,
      arguments: PinEditScreenArguments(file: file),
    );
  }
}
