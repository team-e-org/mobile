import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/bloc/board_detail_screen_bloc.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/pins_repository.dart';
import 'package:mockito/mockito.dart';

class MockPinsRepository extends Mock implements PinsRepository {}

void main() {
  group('board detail screen bloc test', () {
    MockPinsRepository pinsRepository;
    BoardDetailScreenBloc bloc;

    setUp(() {
      pinsRepository = MockPinsRepository();
      bloc = BoardDetailScreenBloc(
        pinsRepository: pinsRepository,
        board: Board.fromMock(),
      );
    });

    test('initial state is InitialState', () {
      expect(bloc.initialState, isA<InitialState>());
      expect(bloc.state, isA<InitialState>());
    });

    blocTest<BoardDetailScreenBloc, BoardDetailScreenEvent,
        BoardDetailScreenState>(
      'when fetching board data succeeded, should be default state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.getBoardPins(
                boardId: anyNamed('boardId'), page: anyNamed('page')))
            .thenAnswer((_) => Future.value([Pin.fromMock()]));
        bloc.add(LoadPinsPage());
      },
      expect: <dynamic>[
        isA<Loading>(),
        equals(DefaultState(page: 1, pins: [Pin.fromMock()])),
      ],
    );

    blocTest<BoardDetailScreenBloc, BoardDetailScreenEvent,
        BoardDetailScreenState>(
      'when fetching board data failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.getBoardPins(
                boardId: anyNamed('boardId'), page: anyNamed('page')))
            .thenThrow(NetworkError());
        bloc.add(LoadPinsPage());
      },
      expect: <dynamic>[
        isA<Loading>(),
        isA<ErrorState>(),
      ],
    );
  });
}
