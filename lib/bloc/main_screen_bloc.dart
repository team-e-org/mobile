import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/model/models.dart';

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

class IsLoading extends MainScreenState {
  @override
  IsLoading({
    @required int page,
    @required List<Pin> pins,
  }) : super(page: page, pins: pins);
}

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  @override
  MainScreenState get initialState => null;

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {}
}
