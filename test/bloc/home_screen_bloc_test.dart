import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/bloc/home_screen_bloc.dart';
import 'package:mobile/bloc/pins_bloc.dart';
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
      bloc = HomeScreenBloc(pinsRepository);
    });

    test('initial state is InitialState', () {
      expect(bloc.initialState, isA<InitialState>());
      expect(bloc.state, isA<InitialState>());
    });

    blocTest<HomeScreenBloc, PinsBlocEvent, PinsBlocState>(
      'when fetching home sceen pins succeeded, should be default state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.getHomePagePins(page: anyNamed('page')))
            .thenAnswer((_) => Future.value([Pin.fromMock()]));
        bloc.add(PinsBlocEvent.loadNext);
      },
      expect: <dynamic>[
        isA<Loading>(),
        equals(DefaultState(page: 1, pins: [Pin.fromMock()])),
      ],
    );

    blocTest<HomeScreenBloc, PinsBlocEvent, PinsBlocState>(
      'when fetching home screen pins failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.getHomePagePins(page: anyNamed('page')))
            .thenThrow(NetworkError());
        bloc.add(PinsBlocEvent.loadNext);
      },
      expect: <dynamic>[
        isA<Loading>(),
        isA<ErrorState>(),
      ],
    );
  });
}
