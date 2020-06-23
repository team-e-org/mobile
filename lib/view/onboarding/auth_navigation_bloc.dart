import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthNavigationEvent {
  signIn,
  signUp,
}

abstract class AuthNavigationState {}

class SignInState extends AuthNavigationState {}

class SignUpState extends AuthNavigationState {}

class AuthNavigationBloc
    extends Bloc<AuthNavigationEvent, AuthNavigationState> {
  @override
  AuthNavigationState get initialState => SignInState();

  @override
  Stream<AuthNavigationState> mapEventToState(
      AuthNavigationEvent event) async* {
    switch (event) {
      case AuthNavigationEvent.signIn:
        yield SignInState();
        break;
      case AuthNavigationEvent.signUp:
        yield SignUpState();
        break;
    }
  }
}
