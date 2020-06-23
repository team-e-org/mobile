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
  NewPinResult({this.newPin, this.board});

  NewPin newPin;
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
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
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
    ) as NewPinResult;

    Navigator.of(context).pop();

    // request api
    // TODO(): callbackの追加
    BlocProvider.of<NewPinScreenBloc>(context)
      ..add(SendRequest(newPin: result.newPin, board: result.board));
  }
}
