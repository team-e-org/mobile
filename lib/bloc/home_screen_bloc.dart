import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/api/pins_api.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

//////// Event ////////
abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadPinsPage extends HomeScreenEvent {}

//////// State ////////
abstract class HomeScreenState extends Equatable {
  const HomeScreenState({
    @required this.page,
    @required this.pins,
  });

  final int page;
  final List<Pin> pins;

  @override
  List<Object> get props => [page, pins];
}

class InitialState extends HomeScreenState {
  @override
  InitialState() : super(page: 0, pins: []);
}

class DefaultState extends HomeScreenState {
  @override
  const DefaultState({
    @required int page,
    @required List<Pin> pins,
  }) : super(page: page, pins: pins);
}

class Loading extends HomeScreenState {
  @override
  const Loading({
    @required int page,
    @required List<Pin> pins,
  }) : super(page: page, pins: pins);
}

//////// Bloc ////////
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc(this._pinsRepository);

  final PinsRepository _pinsRepository;

  @override
  HomeScreenState get initialState => InitialState();

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is LoadPinsPage) {
      yield* mapLoadPinsPageToState(event);
    }
  }

  Stream<HomeScreenState> mapLoadPinsPageToState(LoadPinsPage event) async* {
    if (state is InitialState || state is DefaultState) {
      yield Loading(page: state.page, pins: state.pins);
      try {
        final _additionalPins =
            await _pinsRepository.getHomePagePins(page: state.page + 1);
        final _pins = List<Pin>.from(state.pins)..addAll(_additionalPins);
        yield DefaultState(page: state.page + 1, pins: _pins);
      } catch (e) {
        print(e);
        yield DefaultState(page: state.page, pins: state.pins);
      }
    }
    return;
  }
}
