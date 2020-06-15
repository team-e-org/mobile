import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/data/user_repository.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class Authenticating extends AuthenticationState {}

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppInitialized extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  LoggedIn({
    @required this.token,
  });

  final String token;

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthenticationEvent {}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  AuthenticationState get initialState => Unauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppInitialized) {
      final hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield Authenticating();
      await userRepository.persistToken(event.token);
      yield Authenticated();
    }

    if (event is LoggedOut) {
      await userRepository.deleteToken();
      yield Unauthenticated();
    }
  }
}
