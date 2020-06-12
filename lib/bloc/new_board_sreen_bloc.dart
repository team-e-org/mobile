import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NewBoardScreenBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BoardNameChanged extends NewBoardScreenBlocEvent {
  BoardNameChanged({
    @required this.value,
  });

  final String value;

  @override
  List<Object> get props => [value];
}

abstract class IsPrivateChanged extends NewBoardScreenBlocEvent {}

abstract class NewBoardScreenBlocState extends Equatable {
  NewBoardScreenBlocState({
    @required this.boardName,
    @required this.isPrivate,
  });

  final String boardName;
  final bool isPrivate;

  @override
  List<Object> get props => [boardName, isPrivate];
}

class DefaultState extends NewBoardScreenBlocState {
  DefaultState({
    @required String boardName,
    @required bool isPrivate,
  }) : super(
          boardName: boardName,
          isPrivate: isPrivate,
        );
}

class NewBoardScreenBloc
    extends Bloc<NewBoardScreenBlocEvent, NewBoardScreenBlocState> {
  @override
  NewBoardScreenBlocState get initialState => DefaultState(
        boardName: '',
        isPrivate: false,
      );

  @override
  Stream<NewBoardScreenBlocState> mapEventToState(
      NewBoardScreenBlocEvent event) async* {
    if (event is BoardNameChanged) {
      yield DefaultState(
        boardName: event.value,
        isPrivate: state.isPrivate,
      );
    }

    if (event is IsPrivateChanged) {
      yield DefaultState(
        boardName: state.boardName,
        isPrivate: !state.isPrivate,
      );
    }
  }
}
