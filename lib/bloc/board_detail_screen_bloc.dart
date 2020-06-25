import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

//////// Event ////////
abstract class BoardDetailScreenEvent extends Equatable {
  const BoardDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadPinsPage extends BoardDetailScreenEvent {}

//////// State ////////
abstract class BoardDetailScreenState extends Equatable {
  const BoardDetailScreenState({
    @required this.page,
    @required this.pins,
    this.exception,
  });

  final int page;
  final List<Pin> pins;
  final Exception exception;

  @override
  List<Object> get props => [page, pins, exception];
}

class InitialState extends BoardDetailScreenState {
  @override
  InitialState() : super(page: 0, pins: []);
}

class DefaultState extends BoardDetailScreenState {
  @override
  const DefaultState({
    @required int page,
    @required List<Pin> pins,
  }) : super(page: page, pins: pins);
}

class Loading extends BoardDetailScreenState {
  @override
  const Loading({
    @required int page,
    @required List<Pin> pins,
  }) : super(page: page, pins: pins);
}

class ErrorState extends BoardDetailScreenState {
  @override
  const ErrorState({
    @required int page,
    @required List<Pin> pins,
    @required Exception exception,
  }) : super(page: page, pins: pins, exception: exception);
}

//////// Bloc ////////
class BoardDetailScreenBloc
    extends Bloc<BoardDetailScreenEvent, BoardDetailScreenState> {
  BoardDetailScreenBloc({
    this.pinsRepository,
    this.board,
  });

  final PinsRepository pinsRepository;
  final Board board;

  @override
  BoardDetailScreenState get initialState => InitialState();

  @override
  Stream<BoardDetailScreenState> mapEventToState(
      BoardDetailScreenEvent event) async* {
    if (event is LoadPinsPage) {
      yield* mapLoadPinsPageToState(event);
    }
  }

  Stream<BoardDetailScreenState> mapLoadPinsPageToState(
      LoadPinsPage event) async* {
    if (state is! Loading) {
      yield Loading(page: state.page, pins: state.pins);
      try {
        final _additionalPins = await pinsRepository.getBoardPins(
            boardId: board.id, page: state.page + 1);
        final _pins = List<Pin>.from(state.pins)..addAll(_additionalPins);
        yield DefaultState(page: state.page + 1, pins: _pins);
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(page: state.page, pins: state.pins, exception: e);
      }
    }
    return;
  }
}
