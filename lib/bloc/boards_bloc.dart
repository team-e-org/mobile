import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

//////// Event ////////
abstract class BoardsBlocEvent extends Equatable {
  const BoardsBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadBoardList extends BoardsBlocEvent {
  const LoadBoardList();
}

class RefreshBoardList extends BoardsBlocEvent {
  const RefreshBoardList();
}

//////// State ////////
abstract class BoardsBlocState extends Equatable {
  const BoardsBlocState({
    @required this.boards,
    @required this.boardPinMap,
    this.error,
  });

  final List<Board> boards;
  final Map<int, List<Pin>> boardPinMap;
  final dynamic error;

  @override
  List<Object> get props => [boardPinMap, error];
}

class InitialState extends BoardsBlocState {
  @override
  const InitialState() : super(boards: const [], boardPinMap: const {});
}

class DefaultState extends BoardsBlocState {
  @override
  const DefaultState({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
  }) : super(boards: boards, boardPinMap: boardPinMap);
}

class LoadBoardListWaiting extends BoardsBlocState {
  @override
  const LoadBoardListWaiting({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
  }) : super(boards: boards, boardPinMap: boardPinMap);
}

class LoadBoardListErrorState extends BoardsBlocState {
  @override
  const LoadBoardListErrorState({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
    @required dynamic error,
  }) : super(boards: boards, boardPinMap: boardPinMap, error: error);
}

//////// Bloc ////////
class BoardsBloc extends Bloc<BoardsBlocEvent, BoardsBlocState> {
  BoardsBloc({
    @required this.accountRepository,
    @required this.usersRepository,
    @required this.boardsRepository,
  });

  final AccountRepository accountRepository;
  final UsersRepository usersRepository;
  final BoardsRepository boardsRepository;

  @override
  BoardsBlocState get initialState => const InitialState();

  @override
  Stream<BoardsBlocState> mapEventToState(BoardsBlocEvent event) async* {
    if (event is LoadBoardList) {
      yield* mapLoadInitialToState(event);
    } else if (event is RefreshBoardList) {
      yield* mapRefreshToState(event);
    }
  }

  Stream<BoardsBlocState> mapLoadInitialToState(LoadBoardList event) async* {
    if (state is InitialState) {
      yield const LoadBoardListWaiting(boards: [], boardPinMap: {});
      try {
        final userId = accountRepository.getPersistUserId();
        yield const LoadBoardListWaiting(boards: [], boardPinMap: {});

        final boards = await usersRepository.getUserBoards(userId);
        yield LoadBoardListWaiting(boards: boards, boardPinMap: const {});

        final boardPinMap = <int, List<Pin>>{};
        for (var i = 0; i < boards.length; i++) {
          final pins =
              await boardsRepository.getBoardPins(id: boards[i].id, page: 1);
          boardPinMap.putIfAbsent(boards[i].id, () => pins);
        }
        yield DefaultState(boards: boards, boardPinMap: boardPinMap);
      } on Exception catch (e) {
        Logger().e(e);
        yield LoadBoardListErrorState(
          boards: state.boards,
          boardPinMap: state.boardPinMap,
          error: e,
        );
      }
    }
  }

  Stream<BoardsBlocState> mapRefreshToState(RefreshBoardList event) async* {
    yield LoadBoardListWaiting(
        boards: state.boards, boardPinMap: state.boardPinMap);
    try {
      final userId = accountRepository.getPersistUserId();
      final boards = await usersRepository.getUserBoards(userId);
      yield LoadBoardListWaiting(
          boards: boards, boardPinMap: state.boardPinMap);

      final boardPinMap = <int, List<Pin>>{};
      for (var i = 0; i < boards.length; i++) {
        final pins =
            await boardsRepository.getBoardPins(id: boards[i].id, page: 1);
        boardPinMap.putIfAbsent(boards[i].id, () => pins);
      }
      yield DefaultState(boards: boards, boardPinMap: boardPinMap);
    } on Exception catch (e) {
      Logger().e(e);
      yield LoadBoardListErrorState(
        boards: state.boards,
        boardPinMap: state.boardPinMap,
        error: e,
      );
    }
  }
}
