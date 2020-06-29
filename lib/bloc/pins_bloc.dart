import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';

//////// Event ////////
enum PinsBlocEvent {
  loadNext,
}

//////// State ////////
abstract class PinsBlocState extends Equatable {
  const PinsBlocState({
    @required this.page,
    @required this.pins,
    this.isEndOfPins = false,
    this.exception,
  });

  final int page;
  final List<Pin> pins;
  final bool isEndOfPins;
  final Exception exception;

  @override
  List<Object> get props => [page, pins, isEndOfPins, exception];
}

class InitialState extends PinsBlocState {
  InitialState()
      : super(
          page: 0,
          pins: [],
          isEndOfPins: false,
        );
}

class DefaultState extends PinsBlocState {
  const DefaultState({
    @required int page,
    @required List<Pin> pins,
    bool isEndOfPins,
  }) : super(page: page, pins: pins, isEndOfPins: isEndOfPins);
}

class Loading extends PinsBlocState {
  const Loading({
    @required int page,
    @required List<Pin> pins,
    bool isEndOfPins,
  }) : super(page: page, pins: pins, isEndOfPins: isEndOfPins);
}

class ErrorState extends PinsBlocState {
  const ErrorState({
    int page = 0,
    List<Pin> pins = const [],
    bool isEndOfPins,
    @required Exception exception,
  }) : super(
          page: page,
          pins: pins,
          isEndOfPins: isEndOfPins,
          exception: exception,
        );
}

//////// Bloc ////////
abstract class PinsBloc extends Bloc<PinsBlocEvent, PinsBlocState> {
  Future<List<Pin>> getPins({int page});

  @override
  PinsBlocState get initialState => InitialState();

  @override
  Stream<PinsBlocState> mapEventToState(PinsBlocEvent event) async* {
    switch (event) {
      case PinsBlocEvent.loadNext:
        yield* mapLoadNextToState(event);
        break;
    }
  }

  Stream<PinsBlocState> mapLoadNextToState(PinsBlocEvent event) async* {
    if (state is! Loading) {
      yield Loading(
          page: state.page, pins: state.pins, isEndOfPins: state.isEndOfPins);
      try {
        final nextPage = state.page + 1;
        final additionalPins = await getPins(page: nextPage);
        final pins = List<Pin>.from(state.pins)..addAll(additionalPins);
        final isEndOfPins = additionalPins.isEmpty || state.isEndOfPins;
        yield DefaultState(
            page: nextPage, pins: pins, isEndOfPins: isEndOfPins);
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(
            page: state.page,
            pins: state.pins,
            isEndOfPins: false,
            exception: e);
      }
    }
  }
}
