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

class CreateBoardRequest extends NewBoardScreenBlocEvent {
  CreateBoardRequest({
    @required this.newBoard,
  });

  final NewBoard newBoard;

  @override
  List<Object> get props => [newBoard];
}

abstract class NewBoardScreenBlocState extends Equatable {
  NewBoardScreenBlocState({this.newBoard, this.createdBoard});

  NewBoard newBoard;
  Board createdBoard;

  @override
  List<Object> get props => [];
}

class DefaultState extends NewBoardScreenBlocState {}

class BoardCreatingState extends NewBoardScreenBlocState {
  BoardCreatingState({
    NewBoard newBoard,
    Board createdBoard,
  }) : super(newBoard: newBoard, createdBoard: createdBoard);
}

class BoardCreateSuccessState extends NewBoardScreenBlocState {
  BoardCreateSuccessState({
    NewBoard newBoard,
    Board createdBoard,
  }) : super(newBoard: newBoard, createdBoard: createdBoard);
}

class BoardCreateErrorState extends NewBoardScreenBlocState {
  BoardCreateErrorState({
    NewBoard newBoard,
    Board createdBoard,
    @required this.errorMessage,
  }) : super(newBoard: newBoard, createdBoard: createdBoard);

  final String errorMessage;
}

class NewBoardScreenBloc
    extends Bloc<NewBoardScreenBlocEvent, NewBoardScreenBlocState> {
  NewBoardScreenBloc({
    @required this.boardRepo,
  });

  final BoardsRepository boardRepo;

  @override
  NewBoardScreenBlocState get initialState => DefaultState();

  @override
  Stream<NewBoardScreenBlocState> mapEventToState(
      NewBoardScreenBlocEvent event) async* {
    if (event is CreateBoardRequest) {
      yield* mapToCreateBoardRequestState(event);
    }
  }

  Stream<NewBoardScreenBlocState> mapToCreateBoardRequestState(
      CreateBoardRequest event) async* {
    yield BoardCreatingState(newBoard: event.newBoard);

    Logger().d('board: ${event.newBoard}');

    try {
      final createdBoard = await boardRepo.createBoard(event.newBoard);
      yield BoardCreateSuccessState(
        newBoard: event.newBoard,
        createdBoard: createdBoard,
      );
    } on Exception catch (e) {
      Logger().e(e);
      yield BoardCreateErrorState(
        newBoard: event.newBoard,
        errorMessage: e.toString(),
      );
    }
  }
}
