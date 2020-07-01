import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/model/models.dart';

// event
abstract class PinEditScreenEvent extends Equatable {
  const PinEditScreenEvent();

  @override
  List<Object> get props => [];
}

class UpdatePin extends PinEditScreenEvent {
  UpdatePin({
    @required this.newPin,
    @required this.imageFile,
  });

  final NewPin newPin;
  final File imageFile;

  List<Object> get props => [newPin, imageFile];
}

// state
abstract class PinEditScreenState extends Equatable {
  const PinEditScreenState();

  @override
  List<Object> get props => [];
}

class InitialState extends PinEditScreenState {}

class UpdatePinWaiting extends PinEditScreenState {}

class UpdatePinFinished extends PinEditScreenState {}

class UpdatePinErrorState extends PinEditScreenState {}

// bloc
class PinEditScreenBloc extends Bloc<PinEditScreenEvent, PinEditScreenState> {
  @override
  PinEditScreenState get initialState => InitialState();

  @override
  Stream<PinEditScreenState> mapEventToState(PinEditScreenEvent event) async* {
    if (event is UpdatePin) {
      yield* mapUpdatePinToState(event);
    }
  }

  Stream<PinEditScreenState> mapUpdatePinToState(UpdatePin event) async* {
    if (state is! UpdatePinWaiting) {
      yield UpdatePinWaiting();
      try {
        UpdatePinFinished();
      } on Exception catch (e) {
        yield UpdatePinErrorState();
      }
    }
  }
}
