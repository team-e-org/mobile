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
      final expected = DefaultState();
      expect(bloc.initialState, equals(expected));
      expect(bloc.state, equals(expected));
    });

    blocTest<NewBoardScreenBloc, NewBoardScreenBlocEvent,
        NewBoardScreenBlocState>(
      'when creating new board succeeded, should be success state',
      build: () async => bloc,
      act: (bloc) async {
        when(boardRepository.createBoard(any))
            .thenAnswer((_) => Future.value(Board.fromMock()));
        bloc.add(CreateBoardRequest(
            newBoard: NewBoard(name: 'test', isPrivate: false)));
      },
      expect: <dynamic>[
        isA<BoardCreatingState>(),
        isA<BoardCreateSuccessState>(),
      ],
    );
  });
}
