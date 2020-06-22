import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mobile/data/account_repository.dart';
import 'package:mobile/view/onboarding/authentication_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  LoginFailure({
    this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return '(errorMessage: $errorMessage)';
  }
}

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequested extends LoginEvent {
  LoginRequested({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    @required this.accountRepository,
    @required this.authenticationBloc,
  });

  final AccountRepository accountRepository;
  final AuthenticationBloc authenticationBloc;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginRequested) {
      yield LoginLoading();
      try {
        final auth =
            await accountRepository.authenticate(event.email, event.password);
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
