import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/pages/pin_edit_page.dart';
import 'package:mobile/view/select_board_screen.dart';

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

  void _onSubmit(BuildContext context, NewPin newPin) {
    Navigator.of(context).pushNamed(
      Routes.createNewPinSelectBoard,
      arguments: SelectBoardScreenArguments(),
    );
  }
}
