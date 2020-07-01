import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

// event
abstract class PinEditScreenEvent extends Equatable {
  const PinEditScreenEvent();

  @override
  List<Object> get props => [];
}

class RequestEditPin extends PinEditScreenEvent {
  RequestEditPin({
    @required this.pinId,
    @required this.editPin,
  });

  final int pinId;
  final EditPin editPin;

  List<Object> get props => [pinId, editPin];
}

// state
abstract class PinEditScreenState extends Equatable {
  const PinEditScreenState();

  @override
  List<Object> get props => [];
}

class InitialState extends PinEditScreenState {}

class EditPinWaiting extends PinEditScreenState {}

class EditPinFinished extends PinEditScreenState {}

class EditPinErrorState extends PinEditScreenState {
  EditPinErrorState({this.exception});

  final dynamic exception;
}

// bloc
class PinEditScreenBloc extends Bloc<PinEditScreenEvent, PinEditScreenState> {
  PinEditScreenBloc({this.pinsRepository});

  final PinsRepository pinsRepository;
  @override
  PinEditScreenState get initialState => InitialState();

  @override
  Stream<PinEditScreenState> mapEventToState(PinEditScreenEvent event) async* {
    if (event is RequestEditPin) {
      yield* mapUpdatePinToState(event);
    }
  }

  Stream<PinEditScreenState> mapUpdatePinToState(RequestEditPin event) async* {
    if (state is! EditPinWaiting) {
      yield EditPinWaiting();
      try {
        await pinsRepository.editPin(event.pinId, event.editPin);
        EditPinFinished();
      } on Exception catch (e) {
        Logger().e(e);
        yield EditPinErrorState(exception: e);
      }
    }
  }
}
