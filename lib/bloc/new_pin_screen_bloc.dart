import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class SendRequest extends NewPinScreenEvent {
  const SendRequest({this.newPin, this.board});

  final NewPin newPin;
  final Board board;

  @override
  List<Object> get props => [newPin, board];
}

// State

abstract class NewPinScreenState extends Equatable {
  const NewPinScreenState();

  @override
  List<Object> get props => [];
}

class InitialState extends NewPinScreenState {}

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
    if (event is SendRequest) {
      yield* mapSendRequestToState(event);
    }
  }

  Stream<NewPinScreenState> mapSendRequestToState(SendRequest event) async* {
    if (state is InitialState) {
      yield Sending();
      try {
        await pinsRepository.createPin(event.newPin, event.board);
        yield Finished();
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState();
      }
    }
  }
}
