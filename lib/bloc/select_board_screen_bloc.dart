import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

//////// Event ////////
abstract class SelectBoardScreenEvent extends Equatable {
  const SelectBoardScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadInitial extends SelectBoardScreenEvent {
  const LoadInitial();
}

//////// State ////////
abstract class SelectBoardScreenState extends Equatable {
  const SelectBoardScreenState({
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

class InitialState extends SelectBoardScreenState {
  @override
  const InitialState() : super(boards: const [], boardPinMap: const {});
}

class DefaultState extends SelectBoardScreenState {
  @override
  const DefaultState({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
  }) : super(boards: boards, boardPinMap: boardPinMap);
}

class Loading extends SelectBoardScreenState {
  @override
  const Loading({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
  }) : super(boards: boards, boardPinMap: boardPinMap);
}

class ErrorState extends SelectBoardScreenState {
  @override
  const ErrorState({
    @required List<Board> boards,
    @required Map<int, List<Pin>> boardPinMap,
    @required dynamic error,
  }) : super(boards: boards, boardPinMap: boardPinMap, error: error);
}

//////// Bloc ////////
class SelectBoardScreenBloc
    extends Bloc<SelectBoardScreenEvent, SelectBoardScreenState> {
  SelectBoardScreenBloc({
    @required this.accountRepository,
    @required this.usersRepository,
    @required this.boardsRepository,
  });

  final AccountRepository accountRepository;
  final UsersRepository usersRepository;
  final BoardsRepository boardsRepository;

  @override
  SelectBoardScreenState get initialState => const InitialState();

  @override
  Stream<SelectBoardScreenState> mapEventToState(
      SelectBoardScreenEvent event) async* {
    if (event is LoadInitial) {
      yield* mapLoadInitialToState(event);
    }
  }

  Stream<SelectBoardScreenState> mapLoadInitialToState(
      LoadInitial event) async* {
    if (state is InitialState) {
      yield const Loading(boards: [], boardPinMap: {});
      try {
        final userId = accountRepository.getPersistUserId();
        yield const Loading(boards: [], boardPinMap: {});

        final boards = await usersRepository.getUserBoards(userId);
        yield Loading(boards: boards, boardPinMap: const {});

        final boardPinMap = <int, List<Pin>>{};
        for (var i = 0; i < boards.length; i++) {
          final pins =
              await boardsRepository.getBoardPins(id: boards[i].id, page: 1);
          boardPinMap.putIfAbsent(boards[i].id, () => pins);
        }
        yield DefaultState(boards: boards, boardPinMap: boardPinMap);
      } on Exception catch (e) {
        yield ErrorState(
          boards: state.boards,
          boardPinMap: state.boardPinMap,
          error: e,
        );
      }
    }
    return;
  }
}
