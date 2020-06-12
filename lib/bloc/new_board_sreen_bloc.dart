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

class IsPrivateChanged extends NewBoardScreenBlocEvent {}

class CreateBoardRequested extends NewBoardScreenBlocEvent {}

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

    if (event is CreateBoardRequested) {
      // TODO: 実際にBoardを作成する処理に差し替え
      print('board name: ${state.boardName}, isPrivate: ${state.isPrivate}');
    }

    // state:
    // initial
    // loading
    // default

    // event:
    // load_pins_page
    // (finish_loading)

    if (event is load_pins_page) {
      yield loading_state()
          try {
            data = await repo.fetch_data()
            yield default_state(data)
          }catch {
           yield error_state()
          }
    }

  }
}
