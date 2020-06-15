import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/util/validator.dart';
import 'package:mobile/view/onboarding/auth_bloc.dart';
import 'package:mobile/view/onboarding/auth_common_widget.dart';
import 'package:mobile/view/onboarding/login_bloc.dart';

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
  LoginFormModel _model = LoginFormModel(
    email: '',
    password: '',
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthCommonWidget(
      formKey: _formKey,
      message: 'Welcome back!',
      textFieldsProps: [
        TextFieldProps(
          label: 'Email',
          obscure: false,
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
        TextFieldProps(
          label: 'Password',
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
      action: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => RaisedButton(
          child: state is LoginLoading
              ? CircularProgressIndicator()
              : Text('Login'),
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
      ),
    );
  }
}
