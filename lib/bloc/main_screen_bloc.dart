import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object> get props => [];
}

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
