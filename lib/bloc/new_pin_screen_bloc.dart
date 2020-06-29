import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/model/pin_model.dart';
import 'package:mobile/repository/repositories.dart';

// Event
abstract class NewPinScreenEvent extends Equatable {
  const NewPinScreenEvent();

  @override
  List<Object> get props => [];
}

class ImageSelected extends NewPinScreenEvent {
  const ImageSelected({
    this.image,
  });

  final PickedFile image;

  @override
  List<Object> get props => [image?.path];
}

class SendRequest extends NewPinScreenEvent {
  const SendRequest({
    @required this.newPin,
    @required this.imageFile,
    @required this.board,
  });

  final NewPin newPin;
  final File imageFile;
  final Board board;

  @override
  List<Object> get props => [newPin, imageFile, board];
}

// State

abstract class NewPinScreenState extends Equatable {
  const NewPinScreenState();

  @override
  List<Object> get props => [];
}

class InitialState extends NewPinScreenState {}

class ImageUnaccepted extends NewPinScreenState {}

class ImageAccepted extends NewPinScreenState {
  const ImageAccepted({
    @required this.image,
  });

  final File image;

  @override
  List<Object> get props => [image.path];
}

class Sending extends NewPinScreenState {}

class Finished extends NewPinScreenState {}

class ErrorState extends NewPinScreenState {}

// Bloc
class NewPinScreenBloc extends Bloc<NewPinScreenEvent, NewPinScreenState> {
  NewPinScreenBloc({
    @required this.pinsRepository,
  });

  final PinsRepository pinsRepository;

  @override
  NewPinScreenState get initialState => InitialState();

  @override
  Stream<NewPinScreenState> mapEventToState(NewPinScreenEvent event) async* {
    if (event is ImageSelected) {
      yield* mapImageSelectedToState(event);
    }
    if (event is SendRequest) {
      yield* mapSendRequestToState(event);
    }
  }

  Stream<NewPinScreenState> mapImageSelectedToState(
      ImageSelected event) async* {
    if (event.image == null) {
      yield ImageUnaccepted();
    } else {
      // TODO: ファイル形式、ファイルサイズをチェックする #260
      // TODO: 画像を圧縮する
      yield ImageAccepted(image: File(event.image.path));
    }
  }

  Stream<NewPinScreenState> mapSendRequestToState(SendRequest event) async* {
    if (state is! Sending) {
      yield Sending();
      try {
        await pinsRepository.createPin(
            event.newPin, event.imageFile, event.board);
        yield Finished();
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState();
      }
    }
  }
}
