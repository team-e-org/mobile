import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/bloc/new_pin_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/notification.dart';
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

  NewPinResult result = NewPinResult();
  NewPinScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    final _pinsRepository = RepositoryProvider.of<PinsRepository>(context);

    return BlocProvider(
      create: (context) => NewPinScreenBloc(pinsRepository: _pinsRepository),
      child: BlocConsumer<NewPinScreenBloc, NewPinScreenState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  Future _listener(BuildContext context, NewPinScreenState state) async {
    if (state is ImageConfirmed) {
      await startSequence(context, state.image);
    }

    if (state is Finished) {
      _onSuccess(context);
    }

    if (state is ErrorState) {
      _onError(context);
    }
  }

  Widget _builder(BuildContext context, NewPinScreenState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Pin'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinterestButton.primary(
                text: 'Camera',
                onPressed: () {
                  _onImageSourcePressed(context, ImageSource.camera);
                }),
            const SizedBox(width: 24),
            PinterestButton.primary(
                text: 'Library',
                onPressed: () {
                  _onImageSourcePressed(context, ImageSource.gallery);
                })
          ],
        ),
      ),
    );
  }

  Future _onImageSourcePressed(BuildContext context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    BlocProvider.of<NewPinScreenBloc>(context).add(ImageSelected(
      image: pickedFile,
    ));
  }

  Future startSequence(BuildContext context, File imageFile) async {
    if (imageFile == null) {
      return;
    }

    result.imageFile = imageFile;
    bloc = BlocProvider.of<NewPinScreenBloc>(context);

    final res = await Navigator.of(context).pushNamed(
      Routes.createNewPinEdit,
      arguments: PinEditScreenArguments(
        file: result.imageFile,
        onNextPressed: (context, newPin) async {
          result.newPin = newPin;

          // get board which the new pin will be added, from select board screen
          final res = await Navigator.of(context).pushNamed(
            Routes.createNewPinSelectBoard,
            arguments: SelectBoardScreenArguments(
              onBoardPressed: (context, board) {
                result.board = board;

                bloc.add(SendRequest(
                  newPin: result.newPin,
                  imageFile: result.imageFile,
                  board: result.board,
                ));
              },
            ),
          );

          if (res != null && res as bool) {
            Navigator.of(context).pop(true);
          }
        },
      ),
    );

    if (res != null && res as bool) {
      Navigator.of(context).pop();
    }
  }

  void _onSuccess(BuildContext context) {
    PinterestNotification.show(title: '新しいピンを作成しました');
    Navigator.of(context).pop(true);
  }

  void _onError(BuildContext context) {
    PinterestNotification.showError(title: 'ピンの作成に失敗しました');
  }
}
