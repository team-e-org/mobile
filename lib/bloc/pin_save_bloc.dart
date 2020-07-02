import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mobile/repository/repositories.dart';

// event
abstract class PinSaveEvent extends Equatable {
  const PinSaveEvent();

  @override
  List<Object> get props => [];
}

class SavePin extends PinSaveEvent {
  const SavePin({this.boardId, this.pinId});

  final int boardId, pinId;
}

// state
abstract class PinSaveState extends Equatable {
  const PinSaveState({
    this.isSaved,
    this.exception,
  });

  final bool isSaved;
  final dynamic exception;

  @override
  List<Object> get props => [isSaved, exception];
}

class InitialState extends PinSaveState {
  const InitialState() : super(isSaved: false, exception: null);
}

class SavePinWaiting extends PinSaveState {
  const SavePinWaiting({
    bool isSaved,
  }) : super(isSaved: isSaved);
}

class SavePinFinished extends PinSaveState {
  const SavePinFinished({
    bool isSaved,
  }) : super(isSaved: isSaved);
}

class SavePinErrorState extends PinSaveState {
  const SavePinErrorState({
    bool isSaved,
    dynamic exception,
  }) : super(isSaved: isSaved, exception: exception);
}

// bloc
class PinSaveBloc extends Bloc<PinSaveEvent, PinSaveState> {
  PinSaveBloc({this.pinsRepository});

  final PinsRepository pinsRepository;
  @override
  PinSaveState get initialState => const InitialState();

  @override
  Stream<PinSaveState> mapEventToState(PinSaveEvent event) async* {
    if (event is SavePin) {
      yield* _mapSavePinToState(event);
    }
  }

  Stream<PinSaveState> _mapSavePinToState(SavePin event) async* {
    if (state is! SavePinWaiting) {
      try {
        yield SavePinWaiting(isSaved: state.isSaved);
        final isSaved = await pinsRepository.savePin(
            boardId: event.boardId, pinId: event.pinId);
        yield SavePinFinished(isSaved: isSaved);
      } on Exception catch (e) {
        Logger().e(e);
        yield SavePinErrorState(isSaved: state.isSaved, exception: e);
      }
    }
  }
}
