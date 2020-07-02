import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

// event
abstract class BoardEditScreenEvent extends Equatable {
  const BoardEditScreenEvent();

  @override
  List<Object> get props => [];
}

class RequestEditBoard extends BoardEditScreenEvent {
  RequestEditBoard({
    @required this.boardId,
    @required this.editBoard,
  });

  final int boardId;
  final EditBoard editBoard;

  List<Object> get props => [boardId, editBoard];
}

// state
abstract class BoardEditScreenState extends Equatable {
  const BoardEditScreenState();

  @override
  List<Object> get props => [];
}

class InitialState extends BoardEditScreenState {}

class EditBoardWaiting extends BoardEditScreenState {}

class EditBoardFinished extends BoardEditScreenState {}

class EditBoardErrorState extends BoardEditScreenState {
  EditBoardErrorState({this.exception});

  final dynamic exception;
}

// bloc
class BoardEditScreenBloc
    extends Bloc<BoardEditScreenEvent, BoardEditScreenState> {
  BoardEditScreenBloc({this.boardsRepository});

  final BoardsRepository boardsRepository;
  @override
  BoardEditScreenState get initialState => InitialState();

  @override
  Stream<BoardEditScreenState> mapEventToState(
      BoardEditScreenEvent event) async* {
    if (event is RequestEditBoard) {
      yield* mapUpdateBoardToState(event);
    }
  }

  Stream<BoardEditScreenState> mapUpdateBoardToState(
      RequestEditBoard event) async* {
    if (state is! EditBoardWaiting) {
      yield EditBoardWaiting();
      try {
        await boardsRepository.editBoard(event.boardId, event.editBoard);
        yield EditBoardFinished();
      } on Exception catch (e) {
        Logger().e(e);
        yield EditBoardErrorState(exception: e);
      }
    }
  }
}
