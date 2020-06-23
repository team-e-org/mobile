import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

//////// Event ////////
abstract class AccountScreenEvent extends Equatable {
  const AccountScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadInitial extends AccountScreenEvent {
  const LoadInitial();
}

//////// State ////////
abstract class AccountScreenState extends Equatable {
  const AccountScreenState({
    @required this.user,
    @required this.boards,
    @required this.boardPinMap,
    this.error,
  });

  final User user;
  final List<Board> boards;
  final Map<int, List<Pin>> boardPinMap;
  final dynamic error;

  @override
  List<Object> get props => [user, boardPinMap, error];
}

class InitialState extends AccountScreenState {
  @override
  const InitialState()
      : super(user: null, boards: const [], boardPinMap: const {});
}

class DefaultState extends AccountScreenState {
  @override
  const DefaultState({
    @required User user,
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
  }) : super(user: user, boards: boards, boardPinMap: boardPinMap);
}

class Loading extends AccountScreenState {
  @override
  const Loading({
    @required User user,
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
  }) : super(user: user, boards: boards, boardPinMap: boardPinMap);
}

class ErrorState extends AccountScreenState {
  @override
  const ErrorState(
      {@required User user,
      @required List<Board> boards,
      @required Map<int, List<Pin>> boardPinMap,
      @required dynamic error})
      : super(
            user: user, boards: boards, boardPinMap: boardPinMap, error: error);
}

//////// Bloc ////////
class AccountScreenBloc extends Bloc<AccountScreenEvent, AccountScreenState> {
  AccountScreenBloc({
    @required this.accountRepository,
    @required this.usersRepository,
    @required this.boardsRepository,
  });

  final AccountRepository accountRepository;
  final UsersRepository usersRepository;
  final BoardsRepository boardsRepository;

  @override
  AccountScreenState get initialState => const InitialState();

  @override
  Stream<AccountScreenState> mapEventToState(AccountScreenEvent event) async* {
    if (event is LoadInitial) {
      yield* mapLoadInitialToState(event);
    }
  }

  Stream<AccountScreenState> mapLoadInitialToState(LoadInitial event) async* {
    if (state is InitialState) {
      yield const Loading(user: null, boards: [], boardPinMap: {});
      try {
        final userId = accountRepository.getPersistUserId();
        final user = await usersRepository.getUser(userId);
        yield Loading(user: user, boards: const [], boardPinMap: const {});

        final boards = await usersRepository.getUserBoards(userId);
        yield Loading(user: user, boards: boards, boardPinMap: const {});

        final boardPinMap = <int, List<Pin>>{};
        for (var i = 0; i < boards.length; i++) {
          final pins =
              await boardsRepository.getBoardPins(id: boards[i].id, page: 1);
          boardPinMap.putIfAbsent(boards[i].id, () => pins);
        }
        yield DefaultState(
            user: user, boards: boards, boardPinMap: boardPinMap);
      } on Exception catch (e) {
        yield ErrorState(
          user: state.user,
          boards: state.boards,
          boardPinMap: state.boardPinMap,
          error: e,
        );
      }
    }
    return;
  }
}
