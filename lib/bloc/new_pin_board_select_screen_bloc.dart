import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

//////// Event ////////
abstract class NewPinBoardSelectScreenEvent extends Equatable {
  const NewPinBoardSelectScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadBoardList extends NewPinBoardSelectScreenEvent {
  const LoadBoardList();
}

class RefreshBoardList extends NewPinBoardSelectScreenEvent {
  const RefreshBoardList();
}

class CreatePin extends NewPinBoardSelectScreenEvent {
  const CreatePin({
    @required this.newPin,
    @required this.imageFile,
    @required this.board,
    this.onSuccess,
    this.onError,
  });

  final NewPin newPin;
  final File imageFile;
  final Board board;
  final VoidCallback onSuccess;
  final VoidCallback onError;

  List<Object> get props => [newPin, imageFile, board];
}

//////// State ////////
abstract class NewPinBoardSelectScreenState extends Equatable {
  const NewPinBoardSelectScreenState({
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

class InitialState extends NewPinBoardSelectScreenState {
  @override
  const InitialState() : super(boards: const [], boardPinMap: const {});
}

class DefaultState extends NewPinBoardSelectScreenState {
  @override
  const DefaultState({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
  }) : super(boards: boards, boardPinMap: boardPinMap);
}

class LoadBoardListWaiting extends NewPinBoardSelectScreenState {
  @override
  const LoadBoardListWaiting({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
  }) : super(boards: boards, boardPinMap: boardPinMap);
}

class LoadBoardListErrorState extends NewPinBoardSelectScreenState {
  @override
  const LoadBoardListErrorState({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
    @required dynamic error,
  }) : super(boards: boards, boardPinMap: boardPinMap, error: error);
}

class CreatePinWaiting extends NewPinBoardSelectScreenState {
  @override
  const CreatePinWaiting({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
  }) : super(boards: boards, boardPinMap: boardPinMap);
}

class CreatePinFinished extends NewPinBoardSelectScreenState {
  @override
  const CreatePinFinished({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
  }) : super(boards: boards, boardPinMap: boardPinMap);
}

class CreatePinErrorState extends NewPinBoardSelectScreenState {
  @override
  const CreatePinErrorState({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
    @required dynamic error,
  }) : super(boards: boards, boardPinMap: boardPinMap, error: error);
}

//////// Bloc ////////
class NewPinBoardSelectScreenBloc
    extends Bloc<NewPinBoardSelectScreenEvent, NewPinBoardSelectScreenState> {
  NewPinBoardSelectScreenBloc({
    @required this.accountRepository,
    @required this.usersRepository,
    @required this.boardsRepository,
    @required this.pinsRepository,
  });

  final AccountRepository accountRepository;
  final UsersRepository usersRepository;
  final BoardsRepository boardsRepository;
  final PinsRepository pinsRepository;

  @override
  NewPinBoardSelectScreenState get initialState => const InitialState();

  @override
  Stream<NewPinBoardSelectScreenState> mapEventToState(
      NewPinBoardSelectScreenEvent event) async* {
    if (event is LoadBoardList) {
      yield* mapLoadInitialToState(event);
    } else if (event is RefreshBoardList) {
      yield* mapRefreshToState(event);
    } else if (event is CreatePin) {
      yield* mapCreatePinToState(event);
    }
  }

  Stream<NewPinBoardSelectScreenState> mapLoadInitialToState(
      LoadBoardList event) async* {
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
        yield LoadBoardListErrorState(
          boards: state.boards,
          boardPinMap: state.boardPinMap,
          error: e,
        );
      }
    }
  }

  Stream<NewPinBoardSelectScreenState> mapRefreshToState(
      RefreshBoardList event) async* {
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
      yield LoadBoardListErrorState(
        boards: state.boards,
        boardPinMap: state.boardPinMap,
        error: e,
      );
    }
  }

  Stream<NewPinBoardSelectScreenState> mapCreatePinToState(
      CreatePin event) async* {
    if (state is DefaultState || state is CreatePinErrorState) {
      try {
        yield CreatePinWaiting(
            boards: state.boards, boardPinMap: state.boardPinMap);
        await pinsRepository.createPin(
            event.newPin, event.imageFile, event.board);
        yield CreatePinFinished(
            boards: state.boards, boardPinMap: state.boardPinMap);

        if (event.onSuccess != null) {
          event.onSuccess();
        }
      } on Exception catch (e) {
        Logger().e(e);
        yield CreatePinErrorState(
            boards: state.boards, boardPinMap: state.boardPinMap, error: e);
        if (event.onError != null) {
          event.onError();
        }
      }
    }
  }
}
