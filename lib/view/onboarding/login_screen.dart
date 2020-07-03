import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/util/validator.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/textfield_common.dart';
import 'package:mobile/view/components/notification.dart';
import 'package:mobile/bloc/onborading/auth_navigation_bloc.dart';
import 'package:mobile/view/onboarding/auth_common_widget.dart';
import 'package:mobile/bloc/onborading/authentication_bloc.dart';
import 'package:mobile/bloc/onborading/login_bloc.dart';

class LoginFormModel {
  LoginFormModel({
    this.email,
    this.password,
  });

  String email;
  String password;

  @override
  String toString() {
    return 'Email: $email, Password: $password';
  }
}

class LoginWidget extends StatelessWidget {
  final LoginFormModel _model = LoginFormModel(
    email: '',
    password: '',
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        accountRepository: RepositoryProvider.of<AccountRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: _listener,
        builder: _buildContent,
      ),
    );
  }

  void _listener(BuildContext context, LoginState state) {
    if (state is LoginFailure) {
      PinterestNotification.showError(
        title: 'Failed to login.',
        subtitle: state.errorMessage,
      );
    }
  }

  Widget _buildContent(BuildContext context, LoginState state) {
    return AuthCommonWidget(
      formKey: _formKey,
      textFieldsProps: [
        PinterestTextFieldProps(
          label: 'Email',
          hintText: 'Your Email',
          obscure: false,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (!Validator.isValidEmail(value)) {
              return 'Invalid email format.';
            }
            return null;
          },
          onSaved: (value) {
            _model.email = value;
          },
        ),
        PinterestTextFieldProps(
          label: 'Password',
          hintText: 'Your password',
          obscure: true,
          validator: (value) {
            if (!Validator.isValidPassword(value)) {
              return 'Invalid password format.';
            }
            return null;
          },
          onSaved: (value) {
            _model.password = value;
          },
        ),
      ],
      calloutProps: AuthCalloutProps(
        message: "Don't have an account?",
        buttonText: 'Create new one',
        onButtonPressed: () {
          BlocProvider.of<AuthNavigationBloc>(context)
              .add(AuthNavigationEvent.signUp);
          // Switch page
        },
      ),
      action: PinterestButton.primary(
        loading: state is LoginLoading,
        size: PinterestButtonSize.big,
        text: 'Login',
        onPressed: () {
          if (state is LoginLoading) {
            return;
          }
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            print(_model);
            BlocProvider.of<LoginBloc>(context).add(
              LoginRequested(
                email: _model.email,
                password: _model.password,
              ),
            );
          }
        },
      ),
    );
  }
}
