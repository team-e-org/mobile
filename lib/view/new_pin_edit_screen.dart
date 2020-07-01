import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/new_pin_board_select_screen.dart';
import 'package:mobile/view/pages/pin_edit_page.dart';

class NewPinEditScreenArguments {
  NewPinEditScreenArguments({this.file});

  File file;
}

class NewPinEditScreen extends StatelessWidget {
  NewPinEditScreen({this.args});

  NewPinEditScreenArguments args;

  @override
  Widget build(BuildContext context) {
    return PinEditPage(
      image: FileImage(args.file),
      onSubmit: _onSubmit,
    );
  }

  void _onSubmit(BuildContext context, PinFormData formdata) async {
    final newPin = formdata.toNewPin();
    await Navigator.of(context).pushNamed(
      Routes.createNewPinSelectBoard,
      arguments: NewPinBoardSelectScreenArguments(
        file: args.file,
        newPin: newPin,
      ),
    );

    Navigator.of(context).pop();
  }
}
