import 'package:equatable/equatable.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

// event
abstract class PinEditScreenEvent extends Equatable {
  const PinEditScreenEvent();

  @override
  List<Object> get props => [];
}

class UpdatePin extends PinEditScreenEvent {}

// state
abstract class PinEditScreenState extends Equatable {
  const PinEditScreenState();

  @override
  List<Object> get props => [];
}

class InitialState extends PinEditScreenState {}

class UpdatePinWaiting extends PinEditScreenState {}

class UpdatePinFinished extends PinEditScreenState {}

class UpdatePinErrorState extends PinEditScreenState {}

// bloc
class PinEditScreenBloc extends Bloc<PinEditScreenEvent, PinEditScreenState> {
  @override
  PinEditScreenState get initialState => null;

  @override
  Stream<PinEditScreenState> mapEventToState(PinEditScreenEvent event) async* {}
}
