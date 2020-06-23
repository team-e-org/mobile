import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/model/auth.dart';
import 'package:mobile/view/onboarding/authentication_bloc.dart';
import 'package:mobile/view/onboarding/login_bloc.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  group('LoginBloc test', () {
    AccountRepository accountRepository;
    LoginBloc bloc;

    setUp(() {
      accountRepository = MockAccountRepository();
      bloc = LoginBloc(
        accountRepository: accountRepository,
        authenticationBloc:
            AuthenticationBloc(accountRepository: accountRepository),
      );
    });

    test('Initial state is LoginInitial', () {
      expect(bloc.initialState, LoginInitial());
      expect(bloc.state, LoginInitial());
    });

    blocTest<LoginBloc, LoginEvent, LoginState>(
      'LoginInitial -> LoginLoading',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.authenticate(any, any))
            .thenAnswer((_) => Future.value(Auth(token: '', userId: 0)));
        bloc.add(LoginRequested(email: 'a@b.c', password: 'password'));
      },
      expect: <LoginState>[
        LoginLoading(),
      ],
    );

    blocTest<LoginBloc, LoginEvent, LoginState>(
      'LoginInitial -> LoginLoading -> LoginFailure -> LoginLoading',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.authenticate('a@b.c', '123'))
            .thenThrow(UnauthorizedError());
        when(accountRepository.authenticate('a@b.c', 'pass'))
            .thenAnswer((_) => Future.value(Auth(token: '', userId: 0)));
        bloc.add(LoginRequested(email: 'a@b.c', password: '123'));
        bloc.add(LoginRequested(email: 'a@b.c', password: 'pass'));
      },
      expect: <dynamic>[
        LoginLoading(),
        isA<LoginFailure>(),
        LoginLoading(),
      ],
    );
  });
}
