import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/bloc/new_pin_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/pin_edit_screen.dart';
import 'package:mobile/view/select_board_screen.dart';

class NewPinResult {
  NewPinResult({this.newPin, this.imageFile, this.board});

  NewPin newPin;
  File imageFile;
  Board board;
}

class NewPinScreen extends StatelessWidget {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final _pinsRepository = RepositoryProvider.of<PinsRepository>(context);
    return BlocProvider(
      create: (context) => NewPinScreenBloc(pinsRepository: _pinsRepository),
      child: BlocBuilder<NewPinScreenBloc, NewPinScreenState>(
        builder: (context, state) {
          if (state is InitialState) {
            main(context);
          }
          return const Scaffold();
        },
      ),
    );
  }

  Future main(BuildContext context) async {
    var result = NewPinResult();

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    result.imageFile = File(pickedFile.path);

    await Navigator.of(context).pushNamed(
      Routes.createNewPinEdit,
      arguments: PinEditScreenArguments(
        file: result.imageFile,
        onNextPressed: (context, newPin) async {
          result.newPin = newPin;

          // get board which the new pin will be added, from select board screen
          await Navigator.of(context).pushNamed(
            Routes.createNewPinSelectBoard,
            arguments: SelectBoardScreenArguments(
              onBoardPressed: (context, board) {
                result.board = board;
                Navigator.of(context).pop();
              },
            ),
          );

          Navigator.of(context).pop();
        },
      ),
    ) as NewPinResult;

    Navigator.of(context).pop();

    // request api
    // TODO(): callbackの追加
    BlocProvider.of<NewPinScreenBloc>(context)
      ..add(SendRequest(
        newPin: result.newPin,
        imageFile: result.imageFile,
        board: result.board,
      ));
  }
}
