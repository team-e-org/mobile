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
    this.exception,
  });

  final int page;
  final List<Pin> pins;
  final Exception exception;

  @override
  List<Object> get props => [page, pins, exception];
}

class InitialState extends PinsBlocState {
  InitialState() : super(page: 0, pins: []);
}

class DefaultState extends PinsBlocState {
  const DefaultState({
    @required int page,
    @required List<Pin> pins,
  }) : super(page: page, pins: pins);
}

class Loading extends PinsBlocState {
  const Loading({
    @required int page,
    @required List<Pin> pins,
  }) : super(page: page, pins: pins);
}

class ErrorState extends PinsBlocState {
  const ErrorState({
    int page = 0,
    List<Pin> pins = const [],
    @required Exception exception,
  }) : super(page: page, pins: pins, exception: exception);
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
      yield Loading(page: state.page, pins: state.pins);
      try {
        final nextPage = state.page + 1;
        final additionalPins = await getPins(page: nextPage);
        final pins = List<Pin>.from(state.pins)..addAll(additionalPins);
        yield DefaultState(page: nextPage, pins: pins);
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(page: state.page, pins: state.pins, exception: e);
      }
    }
  }
}
