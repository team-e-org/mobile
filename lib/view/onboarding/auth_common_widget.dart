import 'package:flutter/material.dart';
import 'package:mobile/view/components/common/textfield_common.dart';

class AuthCommonWidget extends StatelessWidget {
  AuthCommonWidget({
    @required this.message,
    @required this.textFieldsProps,
    this.calloutProps,
    @required this.formKey,
    @required this.action,
  });

  final String message;
  final List<PinterestTextFieldProps> textFieldsProps;
  final AuthCalloutProps calloutProps;
  final GlobalKey<FormState> formKey;
  final Widget action;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 24),
            _BigText('Pinterest'),
            SizedBox(height: 24),
            _BigText(message),
            SizedBox(height: 24),
            Form(
              key: formKey,
              child: _TextFieldList(
                textFieldProps: textFieldsProps,
              ),
            ),
            Spacer(),
            _Callout(
              message: calloutProps.message,
              buttonText: calloutProps.buttonText,
              onButtonPressed: calloutProps.onButtonPressed,
            ),
            SizedBox(height: 24),
            action,
          ],
        ),
      ),
    );
  }
}

class _TextFieldList extends StatelessWidget {
  _TextFieldList({
    @required this.textFieldProps,
  });

  final List<PinterestTextFieldProps> textFieldProps;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final props = textFieldProps[index];
        return PinterestTextField(
          props: props,
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 24),
      itemCount: textFieldProps.length,
    );
  }
}

class _Callout extends StatelessWidget {
  _Callout({
    @required this.message,
    @required this.buttonText,
    @required this.onButtonPressed,
  });

  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(message),
          FlatButton(
            textColor: Theme.of(context).buttonColor,
            child: Text(buttonText),
            onPressed: onButtonPressed,
          )
        ],
      ),
    );
  }
}

class _BigText extends StatelessWidget {
  _BigText(
    this.text,
  );

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class AuthCalloutProps {
  AuthCalloutProps({
    @required this.message,
    @required this.buttonText,
    @required this.onButtonPressed,
  });

  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;
}
