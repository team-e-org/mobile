import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

//////// Event ////////

enum HomeScreenEvent {
  loadNext,
  refresh,
}

//////// State ////////
abstract class HomeScreenState extends Equatable {
  const HomeScreenState({
    this.pins,
    this.pagingKey,
    this.isEndOfPins,
    this.exception,
  });

  final List<Pin> pins;
  final String pagingKey;
  final bool isEndOfPins;
  final dynamic exception;

  @override
  List<Object> get props => [pins, pagingKey, exception, isEndOfPins];
}

class InitialState extends HomeScreenState {
  InitialState()
      : super(
          pins: [],
          pagingKey: '',
          isEndOfPins: false,
        );
}

class DefaultState extends HomeScreenState {
  const DefaultState({
    @required List<Pin> pins,
    String pagingKey,
    bool isEndOfPins,
  }) : super(
          pins: pins,
          pagingKey: pagingKey,
          isEndOfPins: isEndOfPins,
        );
}

class Loading extends HomeScreenState {
  const Loading({
    @required List<Pin> pins,
    String pagingKey,
    bool isEndOfPins,
  }) : super(
          pins: pins,
          pagingKey: pagingKey,
          isEndOfPins: isEndOfPins,
        );
}

class ErrorState extends HomeScreenState {
  const ErrorState({
    @required List<Pin> pins,
    String pagingKey,
    bool isEndOfPins,
    @required dynamic exception,
  }) : super(
          pins: pins,
          pagingKey: pagingKey,
          isEndOfPins: isEndOfPins,
          exception: exception,
        );
}

//////// Bloc ////////
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc({this.pinsRepository});

  final PinsRepository pinsRepository;

  @override
  HomeScreenState get initialState => InitialState();

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    switch (event) {
      case HomeScreenEvent.loadNext:
        yield* mapLoadNextToState(event);
        break;
      case HomeScreenEvent.refresh:
        yield* mapRefreshToState(event);
        break;
    }
  }

  Stream<HomeScreenState> mapLoadNextToState(HomeScreenEvent event) async* {
    if (state is! Loading && !state.isEndOfPins) {
      try {
        yield Loading(
          pins: state.pins,
          pagingKey: state.pagingKey,
          isEndOfPins: state.isEndOfPins,
        );
        final res =
            await pinsRepository.getReccomendPins(pagingKey: state.pagingKey);
        yield DefaultState(
          pins: state.pins..addAll(res.pins),
          pagingKey: res.pagingKey,
          isEndOfPins: res.pagingKey == 'null',
        );
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(
          pins: state.pins,
          pagingKey: state.pagingKey,
          isEndOfPins: state.isEndOfPins,
          exception: e,
        );
      }
    }
  }

  Stream<HomeScreenState> mapRefreshToState(HomeScreenEvent event) async* {
    if (state is! Loading) {
      try {
        yield Loading(
          pins: state.pins,
          pagingKey: state.pagingKey,
          isEndOfPins: state.isEndOfPins,
        );
        final res = await pinsRepository.getReccomendPins();
        yield DefaultState(
          pins: res.pins,
          pagingKey: res.pagingKey,
          isEndOfPins: res.pagingKey == 'null',
        );
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(
          pins: state.pins,
          pagingKey: state.pagingKey,
          isEndOfPins: state.isEndOfPins,
          exception: e,
        );
      }
    }
  }
}
