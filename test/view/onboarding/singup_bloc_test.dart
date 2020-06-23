import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/data/account_repository.dart';
import 'package:mobile/model/auth.dart';
import 'package:mobile/view/onboarding/authentication_bloc.dart';
import 'package:mobile/view/onboarding/login_bloc.dart';
import 'package:mobile/view/onboarding/signup_bloc.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  group('SignUpBloc test', () {
    AccountRepository accountRepository;
    SignUpBloc bloc;

    setUp(() {
      accountRepository = MockAccountRepository();

      bloc = SignUpBloc(
        accountRepository: accountRepository,
        authenticationBloc:
            AuthenticationBloc(accountRepository: accountRepository),
      );
    });

    test('Initial state is LoginInitial', () {
      expect(bloc.initialState, LoginInitial());
      expect(bloc.state, LoginInitial());
    });

    blocTest<SignUpBloc, SignUpEvent, LoginState>(
      'LoginInitial -> LoginLoading',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.register(any, any, any))
            .thenAnswer((_) => Future.value(Auth(token: '', userId: 0)));
        bloc.add(SignupRequested(
            username: 'user', email: 'a@b.c', password: 'password'));
      },
      expect: <LoginState>[
        LoginLoading(),
      ],
    );

    blocTest<SignUpBloc, SignUpEvent, LoginState>(
      'LoginInitial -> LoginLoading -> LoginFailure -> LoginLoading',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.register('user', 'a@b.c', 'password'))
            .thenThrow(UnauthorizedError());
        when(accountRepository.register('bob', any, any))
            .thenAnswer((_) => Future.value(Auth(token: '', userId: 0)));
        bloc
          ..add(SignupRequested(
              username: 'user', email: 'a@b.c', password: 'password'))
          ..add(SignupRequested(
              username: 'bob', email: 'a@b.c', password: 'password'));
      },
      expect: <dynamic>[
        LoginLoading(),
        isA<LoginFailure>(),
        LoginLoading(),
      ],
    );
  });
}
