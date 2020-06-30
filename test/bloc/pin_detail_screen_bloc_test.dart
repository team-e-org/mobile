import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/bloc/pin_detail_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mockito/mockito.dart';

class MockUsersRepository extends Mock implements UsersRepository {}

void main() {
  group('pin detail screen bloc test', () {
    MockUsersRepository usersRepository;
    PinDetailScreenBloc bloc;

    setUp(() {
      usersRepository = MockUsersRepository();
      bloc = PinDetailScreenBloc(
        usersRepository: usersRepository,
        pin: Pin.fromMock(),
      );
    });

    test('initial state is InitialState', () {
      expect(bloc.initialState, isA<InitialState>());
      expect(bloc.state, isA<InitialState>());
    });

    blocTest<PinDetailScreenBloc, PinDetailScreenEvent, PinDetailScreenState>(
      'when fetching initial loading succeeded, should be default state',
      build: () async => bloc,
      act: (bloc) async {
        when(usersRepository.getUser(
          bloc.pin.userId,
        )).thenAnswer((_) => Future.value(User.fromMock()));
        bloc.add(const LoadInitial());
      },
      expect: <dynamic>[
        const Loading(),
        DefaultState(user: User.fromMock()),
      ],
    );

    final error = NetworkError();
    blocTest<PinDetailScreenBloc, PinDetailScreenEvent, PinDetailScreenState>(
      'when fetching board pins failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(usersRepository.getUser(
          bloc.pin.userId,
        )).thenThrow(error);
        bloc.add(const LoadInitial());
      },
      expect: <dynamic>[
        const Loading(),
        ErrorState(user: null, exception: error),
      ],
    );
  });
}
