import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/users_repository.dart';

//////// Event ////////
abstract class PinDetailScreenEvent extends Equatable {
  const PinDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadInitial extends PinDetailScreenEvent {
  final Pin pin;
  const LoadInitial({this.pin});
}

//////// State ////////
abstract class PinDetailScreenState extends Equatable {
  const PinDetailScreenState({
    this.pin,
    this.user,
    this.exception,
  });

  final Pin pin;
  final User user;
  final dynamic exception;

  @override
  List<Object> get props => [pin, user, exception];
}

class InitialState extends PinDetailScreenState {
  const InitialState() : super();
}

class DefaultState extends PinDetailScreenState {
  final Pin pin;
  final User user;

  const DefaultState({
    @required this.pin,
    @required this.user,
  }) : super(pin: pin, user: user);
}

class Loading extends PinDetailScreenState {
  final Pin pin;
  final User user;

  const Loading({
    @required this.pin,
    @required this.user,
  }) : super(pin: pin, user: user);
}

class ErrorState extends PinDetailScreenState {
  final Pin pin;
  final User user;
  final dynamic exception;

  const ErrorState({
    this.pin,
    this.user,
    @required this.exception,
  }) : super(pin: pin, user: user, exception: exception);
}

//////// Bloc ////////
class PinDetailScreenBloc
    extends Bloc<PinDetailScreenEvent, PinDetailScreenState> {
  PinDetailScreenBloc({@required this.usersRepository});

  final UsersRepository usersRepository;

  @override
  PinDetailScreenState get initialState => const InitialState();

  @override
  Stream<PinDetailScreenState> mapEventToState(
      PinDetailScreenEvent event) async* {
    if (event is LoadInitial) {
      yield* _mapLoadInitialToState(event);
    }
  }

  Stream<PinDetailScreenState> _mapLoadInitialToState(
      LoadInitial event) async* {
    if (state is! Loading) {
      yield Loading(pin: event.pin, user: null);
      try {
        final user = await usersRepository.getUser(event.pin.userId);
        yield DefaultState(pin: event.pin, user: user);
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(pin: event.pin, user: state.user, exception: e);
      }
    }
  }
}
