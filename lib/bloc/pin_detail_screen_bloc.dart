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

class LoadInitial extends PinDetailScreenEvent {}

class SavePin extends PinDetailScreenEvent {}

//////// State ////////
abstract class PinDetailScreenState extends Equatable {
  const PinDetailScreenState({
    this.user,
    this.isSaved,
    this.exception,
  });

  final User user;
  final bool isSaved;
  final dynamic exception;

  @override
  List<Object> get props => [user, isSaved, exception];
}

class InitialState extends PinDetailScreenState {
  const InitialState() : super(user: null, isSaved: false, exception: null);
}

class DefaultState extends PinDetailScreenState {
  const DefaultState({
    User user,
    bool isSaved,
  }) : super(user: user, isSaved: isSaved);
}

class Loading extends PinDetailScreenState {
  const Loading({
    User user,
    bool isSaved,
  }) : super(user: user, isSaved: isSaved);
}

class ErrorState extends PinDetailScreenState {
  const ErrorState({
    User user,
    bool isSaved,
    dynamic exception,
  }) : super(user: user, isSaved: isSaved, exception: exception);
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
    } else if (event is SavePin) {
      yield* _mapSavePinToState(event);
    }
  }

  Stream<PinDetailScreenState> _mapLoadInitialToState(
      LoadInitial event) async* {
    if (state is! Loading) {
      try {
        yield Loading(user: state.user, isSaved: state.isSaved);
        final user = await usersRepository.getUser(pin.userId);
        yield DefaultState(user: user, isSaved: state.isSaved);
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(
            user: state.user, isSaved: state.isSaved, exception: e);
      }
    }
  }

  Stream<PinDetailScreenState> _mapSavePinToState(SavePin event) async* {
    if (state is! Loading) {
      try {
        yield Loading(user: state.user, isSaved: state.isSaved);
        final isSaved = true;
        yield DefaultState(user: state.user, isSaved: isSaved);
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(
            user: state.user, isSaved: state.isSaved, exception: e);
      }
    }
  }
}
