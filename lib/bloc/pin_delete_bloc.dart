import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

// Event
abstract class PinDeleteEvent extends Equatable {
  const PinDeleteEvent();

  @override
  List<Object> get props => [];
}

class DeletePin extends PinDeleteEvent {
  const DeletePin({this.pin});
  final Pin pin;
}

// State
abstract class PinDeleteState extends Equatable {
  const PinDeleteState({
    this.exception,
  });

  final dynamic exception;

  @override
  List<Object> get props => [exception];
}

class InitialState extends PinDeleteState {}

class DeletePinWaiting extends PinDeleteState {}

class DeletePinFinished extends PinDeleteState {}

class ErrorState extends PinDeleteState {
  const ErrorState({
    dynamic exception,
  }) : super(exception: exception);
}

// Bloc
class PinDeleteBloc extends Bloc<PinDeleteEvent, PinDeleteState> {
  PinDeleteBloc({this.pinsRepository});

  final PinsRepository pinsRepository;

  @override
  PinDeleteState get initialState => InitialState();

  @override
  Stream<PinDeleteState> mapEventToState(PinDeleteEvent event) async* {
    if (event is DeletePin) {
      yield* _mapDeletePinToState(event);
    }
  }

  Stream<PinDeleteState> _mapDeletePinToState(DeletePin event) async* {
    if (state is! DeletePinWaiting) {
      try {
        yield DeletePinWaiting();
        print('pins id: ${event.pin.id}');
        await pinsRepository.deletePin(event.pin.id);
        yield DeletePinFinished();
      } on Exception catch (e) {
        Logger().e(e);
        yield ErrorState(exception: e);
      }
    }
  }
}
