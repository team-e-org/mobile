import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/view/onboarding/auth_navigation_bloc.dart';

void main() {
  group('AuthNavigationBloc test', () {
    AuthNavigationBloc bloc;
    setUp(() {
      bloc = AuthNavigationBloc();
    });

    test('Initial state is SignInState', () {
      expect(bloc.initialState, isA<SignInState>());
      expect(bloc.state, isA<SignInState>());
    });

    blocTest<AuthNavigationBloc, AuthNavigationEvent, AuthNavigationState>(
        'Navigation test',
        build: () async => bloc,
        act: (bloc) async {
          bloc
            ..add(AuthNavigationEvent.signIn)
            ..add(AuthNavigationEvent.signUp)
            ..add(AuthNavigationEvent.signUp)
            ..add(AuthNavigationEvent.signIn);
        },
        expect: <AuthNavigationState>[
          SignUpState(),
          SignInState(),
        ]);
  });
}
