import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/api/pins_api.dart';
import 'package:mobile/bloc/pins_api_stream.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

//////// Event ////////
abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadPinsPage extends MainScreenEvent {
  LoadPinsPage({
    @required this.page,
  });

  final int page;
  @override
  List<Object> get props => [page];
}

class FinishLoading extends MainScreenEvent {
  FinishLoading({
    @required this.page,
    @required this.additionalPins,
  });

  final int page;
  final List<Pin> additionalPins;
  @override
  List<Object> get props => [page, additionalPins];
}

//////// State ////////
abstract class MainScreenState extends Equatable {
  const MainScreenState({
    @required this.page,
    @required this.pins,
  });

  final int page;
  final List<Pin> pins;

  @override
  List<Object> get props => [page, pins];
}

class InitialState extends MainScreenState {
  @override
  InitialState() : super(page: 0, pins: []);
}

class DefaultState extends MainScreenState {
  @override
  DefaultState({
    @required int page,
    @required List<Pin> pins,
  }) : super(page: page, pins: pins);
}

class Loading extends MainScreenState {
  @override
  Loading({
    @required int page,
    @required List<Pin> pins,
  }) : super(page: page, pins: pins);
}

//////// Bloc ////////
class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() {
    _apiClient = ApiClient(Client(), apiEndpoint: _apiEndpoint);
    _pinsRepository = PinsRepository(DefaultPinsApi(_apiClient));
    _apiStreams = PinsApiStreams(_pinsRepository);
  }

  static const String _apiEndpoint = 'http://localhost:8080';
  ApiClient _apiClient;
  PinsRepository _pinsRepository;
  StreamSubscription<dynamic> _apiSubscription;
  PinsApiStreams _apiStreams;

  @override
  MainScreenState get initialState => InitialState();

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {
    if (event is LoadPinsPage) {
      mapLoadPinsPageToState(event);
    } else if (event is FinishLoading) {
      mapFinishLoadingToState(event);
    }
  }

  Stream<MainScreenState> mapLoadPinsPageToState(LoadPinsPage event) async* {
    if (state is Loading) {
      return;
    } else if (state is InitialState || state is DefaultState) {
      await _apiSubscription.cancel();
      _apiSubscription = _apiStreams.getHomePagePins(page: event.page).listen(
          (pins) => add(FinishLoading(page: state.page, additionalPins: pins)));
      yield Loading(page: state.page, pins: state.pins);
    }
  }

  Stream<MainScreenState> mapFinishLoadingToState(FinishLoading event) async* {
    if (state is Loading) {
      await _apiSubscription.cancel();
      final _pins = List<Pin>.from(state.pins)..addAll(event.additionalPins);
      yield DefaultState(page: state.page, pins: _pins);
    }
    return;
  }
}
