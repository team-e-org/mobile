import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/bloc/account_screen_bloc.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

class MockUserRepository extends Mock implements UsersRepository {}

class MockBoardRepository extends Mock implements BoardsRepository {}

void main() {
  group('AccountScreenBloc test', () {
    MockAccountRepository accountRepository;
    MockUserRepository userRepository;
    MockBoardRepository boardRepository;
    AccountScreenBloc bloc;

    setUp(() {
      accountRepository = MockAccountRepository();
      userRepository = MockUserRepository();
      boardRepository = MockBoardRepository();
      bloc = AccountScreenBloc(
        accountRepository: accountRepository,
        usersRepository: userRepository,
        boardsRepository: boardRepository,
      );
    });

    test('Initial state is InitialState', () {
      expect(bloc.initialState, equals(const InitialState()));
      expect(bloc.state, equals(const InitialState()));
    });

    blocTest<AccountScreenBloc, AccountScreenEvent, AccountScreenState>(
      'when fetching board data succeeded, should be default state',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.getPersistUserId()).thenAnswer((_) => 1);
        when(userRepository.getUser(any))
            .thenAnswer((_) => Future.value(User.fromMock()));
        when(userRepository.getUserBoards(any))
            .thenAnswer((_) => Future.value([Board.fromMock()]));
        when(boardRepository.getBoardPins(
          id: anyNamed('id'),
          page: anyNamed('page'),
        )).thenAnswer((_) => Future.value([Pin.fromMock()]));
        bloc.add(const LoadInitial());
      },
      expect: <dynamic>[
        isA<Loading>(),
        Loading(
          user: User.fromMock(),
          boards: const [],
          boardPinMap: const {},
        ),
        DefaultState(
          user: User.fromMock(),
          boards: [Board.fromMock()],
          boardPinMap: {
            Board.fromMock().id: [Pin.fromMock()],
          },
        ),
      ],
    );

    blocTest<AccountScreenBloc, AccountScreenEvent, AccountScreenState>(
      'when fetching board data failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.getPersistUserId()).thenThrow(NetworkError());
        bloc.add(const LoadInitial());
      },
      expect: <dynamic>[
        isA<Loading>(),
        isA<ErrorState>(),
      ],
    );
  });
}
