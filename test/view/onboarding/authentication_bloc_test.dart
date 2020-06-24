import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/model/auth.dart';
import 'package:mobile/view/onboarding/authentication_bloc.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  group('AuthenticationBloc test', () {
    AccountRepository accountRepository;
    AuthenticationBloc bloc;

    setUp(() {
      accountRepository = MockAccountRepository();
      bloc = AuthenticationBloc(
        accountRepository: accountRepository,
      );
    });

    test('Initial state is Unauthenticated', () {
      expect(bloc.initialState, Unauthenticated());
      expect(bloc.state, Unauthenticated());
    });

    blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
      'Unauthenticated user: Unauthenticated -> Authenticating -> Authenticated',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.hasToken())
            .thenAnswer((_) => Future.value(false));
        bloc..add(AppInitialized())..add(LoggedIn(auth: Auth()));
      },
      expect: <AuthenticationState>[
        Authenticating(),
        Authenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
      'Authenticated user: Unauthenticated -> Authenticated',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.hasToken())
            .thenAnswer((_) => Future.value(true));
        bloc.add(AppInitialized());
      },
      expect: <AuthenticationState>[
        Authenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
      'Logout',
      build: () async => bloc,
      act: (bloc) async {
        when(accountRepository.hasToken())
            .thenAnswer((_) => Future.value(true));
        bloc..add(AppInitialized())..add(LoggedOut());
      },
      expect: <AuthenticationState>[
        Authenticated(),
        UnAuthenticating(),
        Unauthenticated(),
      ],
    );
  });
}
