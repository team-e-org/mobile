import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/bloc/new_pin_board_select_screen_bloc.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

class MockUserRepository extends Mock implements UsersRepository {}

class MockBoardRepository extends Mock implements BoardsRepository {}

class MockPinRepository extends Mock implements PinsRepository {}

void main() {
  group('NewPinBoardSelectScreenBloc test', () {
    MockAccountRepository accountRepository;
    MockUserRepository userRepository;
    MockBoardRepository boardRepository;
    MockPinRepository pinRepository;

    NewPinBoardSelectScreenBloc bloc;

    setUp(() {
      accountRepository = MockAccountRepository();
      userRepository = MockUserRepository();
      boardRepository = MockBoardRepository();
      pinRepository = MockPinRepository();
      bloc = NewPinBoardSelectScreenBloc(
        accountRepository: accountRepository,
        usersRepository: userRepository,
        boardsRepository: boardRepository,
        pinsRepository: pinRepository,
      );
    });

    test('Initial state is InitialState', () {
      expect(bloc.initialState, equals(const InitialState()));
      expect(bloc.state, equals(const InitialState()));
    });

    final user = User.fromMock();
    final board = Board.fromMock();
    final pin = Pin.fromMock();
    final error = NetworkError();

    blocTest<NewPinBoardSelectScreenBloc, NewPinBoardSelectScreenEvent,
        NewPinBoardSelectScreenState>(
      'when fetching board data succeeded, should be default state',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.getPersistUserId()).thenAnswer((_) => 1);
        when(userRepository.getUser(any)).thenAnswer((_) => Future.value(user));
        when(userRepository.getUserBoards(any))
            .thenAnswer((_) => Future.value([board]));
        when(boardRepository.getBoardPins(
          id: anyNamed('id'),
          page: anyNamed('page'),
        )).thenAnswer((_) => Future.value([pin]));
        bloc.add(const LoadBoardList());
      },
      expect: <dynamic>[
        LoadBoardListWaiting(boards: [board], boardPinMap: const {}),
        DefaultState(
          boards: [board],
          boardPinMap: {
            board.id: [pin],
          },
        ),
      ],
    );

    blocTest<NewPinBoardSelectScreenBloc, NewPinBoardSelectScreenEvent,
        NewPinBoardSelectScreenState>(
      'when fetching board data failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.getPersistUserId()).thenThrow(error);
        bloc.add(const LoadBoardList());
      },
      expect: <dynamic>[
        const LoadBoardListWaiting(boards: [], boardPinMap: {}),
        LoadBoardListErrorState(
            boards: const [], boardPinMap: const {}, error: error),
      ],
    );

    blocTest<NewPinBoardSelectScreenBloc, NewPinBoardSelectScreenEvent,
        NewPinBoardSelectScreenState>(
      'when creating new pin succeeded, should be finished state',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.getPersistUserId()).thenAnswer((_) => 1);
        when(userRepository.getUser(any)).thenAnswer((_) => Future.value(user));
        when(userRepository.getUserBoards(any))
            .thenAnswer((_) => Future.value([board]));
        when(boardRepository.getBoardPins(
          id: anyNamed('id'),
          page: anyNamed('page'),
        )).thenAnswer((_) => Future.value([pin]));
        bloc
          ..add(const LoadBoardList())
          ..add(const CreatePin(newPin: null, imageFile: null, board: null));
      },
      expect: <dynamic>[
        LoadBoardListWaiting(boards: [board], boardPinMap: const {}),
        DefaultState(
          boards: [board],
          boardPinMap: {
            board.id: [pin],
          },
        ),
        CreatePinWaiting(boards: [
          board
        ], boardPinMap: {
          board.id: [pin]
        }),
        CreatePinFinished(boards: [
          board
        ], boardPinMap: {
          board.id: [pin]
        }),
      ],
    );

    blocTest<NewPinBoardSelectScreenBloc, NewPinBoardSelectScreenEvent,
        NewPinBoardSelectScreenState>(
      'when request to create pin failed, should be error state',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.getPersistUserId()).thenAnswer((_) => 1);
        when(userRepository.getUser(any)).thenAnswer((_) => Future.value(user));
        when(userRepository.getUserBoards(any))
            .thenAnswer((_) => Future.value([board]));
        when(boardRepository.getBoardPins(
          id: anyNamed('id'),
          page: anyNamed('page'),
        )).thenAnswer((_) => Future.value([pin]));
        when(pinRepository.createPin(any, any, any)).thenThrow(error);
        bloc
          ..add(const LoadBoardList())
          ..add(const CreatePin(newPin: null, imageFile: null, board: null));
      },
      expect: <dynamic>[
        LoadBoardListWaiting(boards: [board], boardPinMap: const {}),
        DefaultState(
          boards: [board],
          boardPinMap: {
            board.id: [pin],
          },
        ),
        CreatePinWaiting(boards: [
          board
        ], boardPinMap: {
          board.id: [pin]
        }),
        CreatePinErrorState(boards: [
          board
        ], boardPinMap: {
          board.id: [pin]
        }, error: error),
      ],
    );
  });
}
