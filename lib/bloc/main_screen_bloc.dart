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

class InitialLoad extends MainScreenEvent {}

class LoadAdditionalPage extends MainScreenEvent {}

abstract class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object> get props => [];
}

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  @override
  MainScreenState get initialState => null;

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {}
}
