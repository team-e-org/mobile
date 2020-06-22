import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:mobile/data/account_repository.dart';
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
    @required this.accountRepository,
    @required this.authenticationBloc,
  });

  final AccountRepository accountRepository;
  final AuthenticationBloc authenticationBloc;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(SignUpEvent event) async* {
    if (event is SignupRequested) {
      yield LoginLoading();

      try {
        final auth = await accountRepository.register(
          event.username,
          event.email,
          event.password,
        );
        print('Token: ${auth.token}');
        print('User ID: ${auth.userId}');
        authenticationBloc.add(LoggedIn(auth: auth));
      } on Exception catch (e) {
        Logger().e(e);
        yield LoginFailure(errorMessage: e.toString());
      }
    }
  }
}
