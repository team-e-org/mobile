import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

//////// Event ////////
abstract class AccountScreenEvent extends Equatable {
  const AccountScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadInitial extends AccountScreenEvent {
  const LoadInitial(this.userId);
  final int userId;
}

//////// State ////////
abstract class AccountScreenState extends Equatable {
  const AccountScreenState({
    @required this.boardMap,
    this.error,
  });

  final Map<Board, List<Pin>> boardMap;
  final dynamic error;

  @override
  List<Object> get props => [boardMap];
}

class InitialState extends AccountScreenState {
  @override
  InitialState() : super(boardMap: null);
}

class DefaultState extends AccountScreenState {
  @override
  const DefaultState({
    @required Map<Board, List<Pin>> boardMap,
  }) : super(boardMap: boardMap);
}

class Loading extends AccountScreenState {
  @override
  const Loading({
    @required Map<Board, List<Pin>> boardMap,
  }) : super(boardMap: boardMap);
}

class ErrorState extends AccountScreenState {
  @override
  const ErrorState({
    @required Map<Board, List<Pin>> boardMap,
    @required dynamic error,
  }) : super(boardMap: boardMap, error: error);
}

//////// Bloc ////////
class AccountScreenBloc extends Bloc<AccountScreenEvent, AccountScreenState> {
  AccountScreenBloc({this.usersRepository, this.boardsRepository});

  final UsersRepository usersRepository;
  final BoardsRepository boardsRepository;

  @override
  AccountScreenState get initialState => InitialState();

  @override
  Stream<AccountScreenState> mapEventToState(AccountScreenEvent event) async* {
    if (event is LoadInitial) {
      yield* mapLoadInitialToState(event);
    }
  }

  Stream<AccountScreenState> mapLoadInitialToState(LoadInitial event) async* {
    if (state is InitialState) {
      yield const Loading(boardMap: null);
      try {
        final user = await usersRepository.getUser(event.userId);
        yield Loading(boardMap: null);
        final boardMap = await boardsRepository.getBoardMapByUser(event.userId);
        yield DefaultState(boardMap: boardMap);
      } on Exception catch (e) {
        yield ErrorState(boardMap: state.boardMap, error: e);
      }
    }
    return;
  }
}
