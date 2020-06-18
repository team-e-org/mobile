import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/routes.dart';

class PinEditScreenArguments {
  PinEditScreenArguments({this.file});

  File file;
}

class PinEditScreen extends StatelessWidget {
  const PinEditScreen({this.args});

  final PinEditScreenArguments args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create pin'),
      ),
      body: Container(
        child: Column(
          children: [
            Image.file(args.file),
            RaisedButton(
              child: Text('Next'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.createNewPinSelectPhoto);
              },
            )
          ],
        ),
      ),
    );
  }
}
