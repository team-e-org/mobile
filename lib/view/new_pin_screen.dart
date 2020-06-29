import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/bloc/new_pin_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/new_pin_edit_screen.dart';

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
      child: BlocBuilder<NewPinScreenBloc, NewPinScreenState>(
        builder: (context, state) {
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
                      onPressed: () => _onCameraPressed(context)),
                  const SizedBox(width: 24),
                  PinterestButton.primary(
                      text: 'Library',
                      onPressed: () => _onLibraryPressed(context))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future _onCameraPressed(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return;
    }
    await startSequence(context, File(pickedFile.path));
  }

  Future _onLibraryPressed(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    await startSequence(context, File(pickedFile.path));
  }

  Future startSequence(BuildContext context, File imageFile) async {
    if (imageFile == null) {
      return;
    }

    result.imageFile = imageFile;
    bloc = BlocProvider.of<NewPinScreenBloc>(context);

    await Navigator.of(context).pushNamed(
      Routes.createNewPinEdit,
      arguments: NewPinEditScreenArguments(
        file: result.imageFile,
      ),
    );

    Navigator.of(context).pop();
  }
}
