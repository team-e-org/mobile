import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/util/validator.dart';
import 'package:mobile/view/onboarding/auth_bloc.dart';
import 'package:mobile/view/onboarding/auth_common_widget.dart';
import 'package:mobile/view/onboarding/login_bloc.dart';
import 'package:mobile/view/onboarding/signup_bloc.dart';

class SignUpFormModel {
  SignUpFormModel({
    this.username,
    this.email,
    this.password,
  });

  String username;
  String email;
  String password;
}

class SignUpWidget extends StatelessWidget {
  SignUpFormModel _model = SignUpFormModel(
    username: '',
    email: '',
    password: '',
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthCommonWidget(
      formKey: _formKey,
      message: 'Welcome!',
      textFieldsProps: [
        TextFieldProps(
          label: 'User name',
          obscure: false,
          validator: (value) {
            if (value.isEmpty) {
              return 'Empty username is not allowed';
            }
            return null;
          },
          onSaved: (value) {
            _model.username = value;
          },
        ),
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
        message: 'Do you have an account?',
        buttonText: 'Login',
        onButtonPressed: () {
          BlocProvider.of<AuthNavigationBloc>(context)
              .add(AuthNavigationEvent.signIn);
        },
      ),
      action: BlocBuilder<SignUpBloc, LoginState>(
        builder: (context, state) => RaisedButton(
          child: state is LoginLoading
              ? CircularProgressIndicator()
              : Text('Sign Up'),
          onPressed: () {
            if (state is LoginLoading) {
              return;
            }
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              print(_model);
              BlocProvider.of<SignUpBloc>(context).add(
                SignupRequested(
                  username: _model.username,
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
