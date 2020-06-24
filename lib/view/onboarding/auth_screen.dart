import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/flavors.dart';
import 'package:mobile/view/onboarding/auth_navigation_bloc.dart';
import 'package:mobile/view/onboarding/login_screen.dart';
import 'package:mobile/view/onboarding/signup_screen.dart';

class AuthWidget extends StatelessWidget {
  static Widget newInstance() {
    return BlocProvider(
      create: (context) => AuthNavigationBloc(),
      child: AuthWidget(),
    );
  }

  final _login = LoginWidget();
  final _signUp = SignUpWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Text(F.title),
              Expanded(
                child: BlocBuilder<AuthNavigationBloc, AuthNavigationState>(
                    builder: (_, state) =>
                        state is SignInState ? _login : _signUp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
