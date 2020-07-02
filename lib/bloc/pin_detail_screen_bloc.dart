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
  const InitialState() : super(user: null, exception: null);
}

class DefaultState extends PinDetailScreenState {
  const DefaultState({
    User user,
  }) : super(user: user);
}

class Loading extends PinDetailScreenState {
  const Loading({
    User user,
  }) : super(user: user);
}

class ErrorState extends PinDetailScreenState {
  const ErrorState({
    User user,
    dynamic exception,
  }) : super(user: user, exception: exception);
}

class SavePinWaiting extends PinDetailScreenState {
  const SavePinWaiting({
    User user,
  }) : super(user: user);
}

class SavePinErrorState extends PinDetailScreenState {
  const SavePinErrorState({
    User user,
    dynamic exception,
  }) : super(user: user, exception: exception);
}

//////// Bloc ////////
class PinDetailScreenBloc
    extends Bloc<PinDetailScreenEvent, PinDetailScreenState> {
  PinDetailScreenBloc({
    @required this.usersRepository,
    @required this.pin,
  });

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
      try {
        yield Loading(user: state.user);
        final user = await usersRepository.getUser(pin.userId);
        yield DefaultState(user: user);
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(user: state.user, exception: e);
      }
    }
  }
}
