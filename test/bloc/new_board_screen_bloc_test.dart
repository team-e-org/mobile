import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/bloc/new_board_sreen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/boards_repository.dart';
import 'package:mockito/mockito.dart';

class MockBoardRepository extends Mock implements BoardsRepository {}

void main() {
  group('NewBoardScreenBlocTest', () {
    MockBoardRepository boardRepository;
    NewBoardScreenBloc bloc;

    setUp(() {
      boardRepository = MockBoardRepository();
      bloc = NewBoardScreenBloc(
        boardRepo: boardRepository,
      );
    });

    test('Initial state is DefaultState', () {
      final expected = DefaultState(boardName: '', isPrivate: false);
      expect(bloc.initialState, equals(expected));
      expect(bloc.state, equals(expected));
    });

    blocTest<NewBoardScreenBloc, NewBoardScreenBlocEvent,
        NewBoardScreenBlocState>(
      'isPrivate should be updated',
      build: () async => bloc,
      act: (bloc) async {
        bloc..add(IsPrivateChanged())..add(IsPrivateChanged());
      },
      expect: <NewBoardScreenBlocState>[
        DefaultState(boardName: '', isPrivate: true),
        DefaultState(boardName: '', isPrivate: false),
      ],
    );

    blocTest<NewBoardScreenBloc, NewBoardScreenBlocEvent,
        NewBoardScreenBlocState>(
      'boardName should be updated',
      build: () async => bloc,
      act: (bloc) async {
        bloc.add(BoardNameChanged(value: 'my board'));
      },
      expect: <NewBoardScreenBlocState>[
        DefaultState(boardName: 'my board', isPrivate: false),
      ],
    );

    blocTest<NewBoardScreenBloc, NewBoardScreenBlocEvent,
        NewBoardScreenBlocState>(
      'when creating new board failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(boardRepository.createBoard(any)).thenThrow(NetworkError());
        bloc.add(CreateBoardRequested());
      },
      expect: <dynamic>[
        isA<BoardCreatingState>(),
        isA<BoardCreateErrorState>(),
      ],
    );

    blocTest<NewBoardScreenBloc, NewBoardScreenBlocEvent,
        NewBoardScreenBlocState>(
      'when creating new board succeeded, should be success state',
      build: () async => bloc,
      act: (bloc) async {
        when(boardRepository.createBoard(any))
            .thenAnswer((_) => Future.value(Board.fromMock()));
        bloc.add(CreateBoardRequested());
      },
      expect: <dynamic>[
        isA<BoardCreatingState>(),
        isA<BoardCreateSuccessState>(),
      ],
    );
  });
}
