import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/pages/pin_edit_page.dart';
import 'package:mobile/view/select_board_screen.dart';

class PinEditScreenArguments {
  PinEditScreenArguments({this.file});

  File file;
}

class PinEditScreen extends StatelessWidget {
  PinEditScreen({this.args});

  PinEditScreenArguments args;

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
