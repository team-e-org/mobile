import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile/data/user_repository.dart';
import 'package:mobile/view/onboarding/authentication_bloc.dart';
import 'package:mobile/view/onboarding/login_bloc.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignupRequested extends SignUpEvent {
  SignupRequested({
    @required this.username,
    @required this.email,
    @required this.password,
  });

  final String username;
  final String email;
  final String password;

  @override
  List<Object> get props => [
    username,
    email,
    password,
  ];
}

class SignUpBloc extends Bloc<SignUpEvent, LoginState> {
  SignUpBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  });

  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(SignUpEvent event) async* {
    if (event is SignupRequested) {
      yield LoginLoading();

      try {
        final token = await userRepository.register(
          event.username,
          event.email,
          event.password,
        );
        print('Token: $token');
        authenticationBloc.add(LoggedIn(token: token));
      } catch (e) {
        yield LoginFailure(errorMessage: e.toString());
      }
    }
  }
}
