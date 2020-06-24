import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/pin_edit_screen.dart';
import 'package:mobile/view/select_board_screen.dart';

class NewPinResult {
  NewPinResult({this.newPin, this.board});

  NewPin newPin;
  Board board;
}

class NewPinScreen extends StatefulWidget {
  @override
  _NewPinScreenState createState() => _NewPinScreenState();
}

class _NewPinScreenState extends State<NewPinScreen> {
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    main();
  }

  Future main() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final result = await Navigator.of(context).pushNamed(
        Routes.createNewPinEdit,
        arguments: PinEditScreenArguments(
          file: file,
          onNextPressed: (context, newPin) async {
            // get board which the new pin will be added, from select board screen
            final board = await Navigator.of(context).pushNamed(
              Routes.createNewPinSelectBoard,
              arguments: SelectBoardScreenArguments(
                onBoardPressed: (context, board) {
                  Navigator.of(context).pop(board);
                },
              ),
            );

            Navigator.of(context)
                .pop(NewPinResult(newPin: newPin, board: board as Board));
          },
        ),
      );

      // request api
    }

    // pop
    Navigator.of(context).popUntil(ModalRoute.withName(Routes.root));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
