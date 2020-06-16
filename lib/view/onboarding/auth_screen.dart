import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/data/account_repository.dart';
import 'package:mobile/view/onboarding/auth_bloc.dart';
import 'package:mobile/view/onboarding/authentication_bloc.dart';
import 'package:mobile/view/onboarding/login_bloc.dart';
import 'package:mobile/view/onboarding/login_screen.dart';
import 'package:mobile/view/onboarding/signup_bloc.dart';
import 'package:mobile/view/onboarding/signup_screen.dart';

class AuthWidget extends StatelessWidget {
  static Widget newInstance() {
    return BlocProvider(
      create: (context) => AuthNavigationBloc(),
      child: AuthWidget(),
    );
  }

  final _login = BlocProvider(
    create: (context) => LoginBloc(
      accountRepository: context.repository<AccountRepository>(),
      authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
    ),
    child: LoginWidget(),
  );

  final _signUp = BlocProvider(
    create: (context) => SignUpBloc(
      accountRepository: context.repository<AccountRepository>(),
      authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
    ),
    child: SignUpWidget(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<AuthNavigationBloc, AuthNavigationState>(
            builder: (_, state) => state is SignInState ? _login : _signUp),
      ),
    );
  }
}
