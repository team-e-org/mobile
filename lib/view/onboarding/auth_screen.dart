import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/data/user_repository.dart';
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

  final login = BlocProvider(
    create: (context) => LoginBloc(
      userRepository: context.repository<UserRepository>(),
      authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
    ),
    child: LoginWidget(),
  );
  final signup = BlocProvider(
    create: (context) => SignUpBloc(
      userRepository: context.repository<UserRepository>(),
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
            builder: (_, state) => state is SignInState ? login : signup),
      ),
    );
  }
}