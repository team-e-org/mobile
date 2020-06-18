import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/repository/boards_repository.dart';
import 'package:logger/logger.dart';

abstract class NewBoardScreenBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BoardNameChanged extends NewBoardScreenBlocEvent {
  BoardNameChanged({
    @required this.value,
  });

  final String value;

  @override
  List<Object> get props => [value];
}

class IsPrivateChanged extends NewBoardScreenBlocEvent {}

class CreateBoardRequested extends NewBoardScreenBlocEvent {}

abstract class NewBoardScreenBlocState extends Equatable {
  NewBoardScreenBlocState({
    this.boardName,
    this.isPrivate,
  });

  final String boardName;
  final bool isPrivate;

  @override
  List<Object> get props => [
        boardName,
        isPrivate,
      ];
}

class DefaultState extends NewBoardScreenBlocState {
  DefaultState({
    @required String boardName,
    @required bool isPrivate,
  }) : super(boardName: boardName, isPrivate: isPrivate);
}

class BoardCreateSuccessState extends DefaultState {
  BoardCreateSuccessState({
    @required String boardName,
    @required bool isPrivate,
    @required this.createdBoard,
  }) : super(boardName: boardName, isPrivate: isPrivate);

  final Board createdBoard;
}

class BoardCreateErrorState extends DefaultState {
  BoardCreateErrorState({
    @required String boardName,
    @required bool isPrivate,
    @required this.errorMessage,
  }) : super(boardName: boardName, isPrivate: isPrivate);

  final String errorMessage;
}

class NewBoardScreenBloc
    extends Bloc<NewBoardScreenBlocEvent, NewBoardScreenBlocState> {
  NewBoardScreenBloc({
    this.boardRepo,
  });

  final BoardsRepository boardRepo;

  @override
  NewBoardScreenBlocState get initialState => DefaultState(
        boardName: '',
        isPrivate: false,
      );

  @override
  Stream<NewBoardScreenBlocState> mapEventToState(
      NewBoardScreenBlocEvent event) async* {
    if (event is BoardNameChanged) {
      yield DefaultState(
        boardName: event.value,
        isPrivate: state.isPrivate,
      );
    }

    if (event is IsPrivateChanged) {
      yield DefaultState(
        boardName: state.boardName,
        isPrivate: !state.isPrivate,
      );
    }

    if (event is CreateBoardRequested) {
      final newBoard = NewBoard(
        name: state.boardName,
        isPrivate: state.isPrivate,
      );

      Logger().d('board: $newBoard');

      try {
        final createdBoard = await boardRepo.createBoard(newBoard);
        yield BoardCreateSuccessState(
          boardName: state.boardName,
          isPrivate: state.isPrivate,
          createdBoard: createdBoard,
        );
      } catch (e) {
        yield BoardCreateErrorState(
          boardName: state.boardName,
          isPrivate: state.isPrivate,
          errorMessage: e.toString(),
        );
      }
    }
  }
}
