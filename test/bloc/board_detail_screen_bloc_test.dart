import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/bloc/board_detail_screen_bloc.dart';
import 'package:mobile/bloc/pins_bloc.dart';
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
      bloc = BoardDetailScreenBloc(pinsRepository, Board.fromMock());
    });

    test('initial state is InitialState', () {
      expect(bloc.initialState, isA<InitialState>());
      expect(bloc.state, isA<InitialState>());
    });

    blocTest<BoardDetailScreenBloc, PinsBlocEvent, PinsBlocState>(
      'when fetching board pins succeeded, should be default state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.getBoardPins(
          boardId: Board.fromMock().id,
          page: anyNamed('page'),
        )).thenAnswer((_) => Future.value([Pin.fromMock()]));
        bloc.add(PinsBlocEvent.loadNext);
      },
      expect: <dynamic>[
        isA<Loading>(),
        equals(DefaultState(page: 1, pins: [Pin.fromMock()])),
      ],
    );

    blocTest<BoardDetailScreenBloc, PinsBlocEvent, PinsBlocState>(
      'when fetching board pins failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(
          pinsRepository.getBoardPins(
              boardId: Board.fromMock().id, page: anyNamed('page')),
        ).thenThrow(NetworkError());
        bloc.add(PinsBlocEvent.loadNext);
      },
      expect: <dynamic>[
        isA<Loading>(),
        isA<ErrorState>(),
      ],
    );

    blocTest<BoardDetailScreenBloc, PinsBlocEvent, PinsBlocState>(
      'when refreshing board pins succeeded, should be default state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.getBoardPins(
          boardId: Board.fromMock().id,
          page: anyNamed('page'),
        )).thenAnswer((_) => Future.value([Pin.fromMock()]));
        bloc
          ..add(PinsBlocEvent.loadNext)
          ..add(PinsBlocEvent.loadNext)
          ..add(PinsBlocEvent.refresh);
      },
      expect: <dynamic>[
        isA<Loading>(),
        equals(DefaultState(page: 1, pins: [Pin.fromMock()])),
        isA<Loading>(),
        equals(DefaultState(page: 2, pins: [Pin.fromMock(), Pin.fromMock()])),
        isA<Loading>(),
        equals(DefaultState(page: 1, pins: [Pin.fromMock()])),
      ],
    );

    blocTest<BoardDetailScreenBloc, PinsBlocEvent, PinsBlocState>(
      'when refreshing board pins failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(
          pinsRepository.getBoardPins(
              boardId: Board.fromMock().id, page: anyNamed('page')),
        ).thenThrow(NetworkError());
        bloc.add(PinsBlocEvent.refresh);
      },
      expect: <dynamic>[
        isA<Loading>(),
        isA<ErrorState>(),
      ],
    );
  });
}
