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
  const LoadInitial();
}

//////// State ////////
abstract class PinDetailScreenState extends Equatable {
  const PinDetailScreenState({
    this.user,
    this.exception,
  });

  final User user;
  final dynamic exception;

  @override
  List<Object> get props => [user, exception];
}

class InitialState extends PinDetailScreenState {
  const InitialState() : super();
}

class DefaultState extends PinDetailScreenState {
  final User user;

  const DefaultState({
    @required this.user,
  }) : super(user: user);
}

class Loading extends PinDetailScreenState {
  final User user;

  const Loading({
    @required this.user,
  }) : super(user: user);
}

class ErrorState extends PinDetailScreenState {
  final User user;
  final dynamic exception;

  const ErrorState({
    this.user,
    @required this.exception,
  }) : super(user: user, exception: exception);
}

//////// Bloc ////////
class PinDetailScreenBloc
    extends Bloc<PinDetailScreenEvent, PinDetailScreenState> {
  PinDetailScreenBloc({@required this.usersRepository, this.pin});

  final UsersRepository usersRepository;
  final Pin pin;

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
      yield const Loading(user: null);
      try {
        final user = await usersRepository.getUser(pin.userId);
        yield DefaultState(user: user);
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(user: state.user, exception: e);
      }
    }
  }
}
