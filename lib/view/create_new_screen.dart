import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/notification.dart';
import 'package:image_picker/image_picker.dart';
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
              PinterestButton.primary(
                text: 'Board',
                onPressed: () async {
                  await Navigator.of(context).pushNamed(Routes.createNewBoard);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 20),
              PinterestButton.primary(
                text: 'Pin',
                onPressed: () => _onPinPressed(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _onPinPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.createNewPin);
    Navigator.pop(context);
  }
}
