import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/api/pins_api.dart';
import 'package:mobile/bloc/home_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/pins_repository.dart';
import 'package:mockito/mockito.dart';

class MockPinsRepository extends Mock implements PinsRepository {}

void main() {
  group('home screen bloc test', () {
    MockPinsRepository pinsRepository;
    HomeScreenBloc bloc;

    setUp(() {
      pinsRepository = MockPinsRepository();
      bloc = HomeScreenBloc(
        pinsRepository: pinsRepository,
      );
    });

    test('initial state is InitialState', () {
      expect(bloc.initialState, isA<InitialState>());
      expect(bloc.state, isA<InitialState>());
    });

    blocTest<HomeScreenBloc, HomeScreenEvent, HomeScreenState>(
      'when fetching home sceen pins succeeded, should be default state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.getReccomendPins(pagingKey: anyNamed('pagingKey')))
            .thenAnswer((_) => Future.value(RecommendPinResponse(
                  pins: [Pin.fromMock()],
                  pagingKey: 'pagingKey',
                )));
        bloc.add(HomeScreenEvent.loadNext);
      },
      expect: <dynamic>[
        isA<Loading>(),
        equals(DefaultState(
          pagingKey: 'pagingKey',
          pins: [Pin.fromMock()],
          isEndOfPins: false,
        )),
      ],
    );

    blocTest<HomeScreenBloc, HomeScreenEvent, HomeScreenState>(
      'when fetching home screen pins failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.getReccomendPins(pagingKey: anyNamed('pagingKey')))
            .thenThrow(NetworkError());
        bloc.add(HomeScreenEvent.loadNext);
      },
      expect: <dynamic>[
        isA<Loading>(),
        isA<ErrorState>(),
      ],
    );

    blocTest<HomeScreenBloc, HomeScreenEvent, HomeScreenState>(
      'when refreshing home sceen pins succeeded, should be default state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.getReccomendPins(pagingKey: anyNamed('pagingKey')))
            .thenAnswer((_) => Future.value(RecommendPinResponse(
                  pins: [Pin.fromMock()],
                  pagingKey: 'pagingKey',
                )));
        bloc.add(HomeScreenEvent.refresh);
      },
      expect: <dynamic>[
        isA<Loading>(),
        equals(DefaultState(
          pagingKey: 'pagingKey',
          pins: [Pin.fromMock()],
          isEndOfPins: false,
        )),
      ],
    );

    blocTest<HomeScreenBloc, HomeScreenEvent, HomeScreenState>(
      'when refreshing home screen pins failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.getReccomendPins(pagingKey: anyNamed('pagingKey')))
            .thenThrow(NetworkError());
        bloc.add(HomeScreenEvent.refresh);
      },
      expect: <dynamic>[
        isA<Loading>(),
        isA<ErrorState>(),
      ],
    );
  });
}
