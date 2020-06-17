import 'package:flutter/material.dart';

class PinterestTextFieldProps {
  PinterestTextFieldProps({
    @required this.label,
    @required this.hintText,
    this.validator,
    this.obscure = false,
    this.onChanged,
    this.onSaved,
  });

  final FormFieldValidator<String> validator;
  final String label;
  final String hintText;
  final bool obscure;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSaved;
}

class PinterestTextField extends StatelessWidget {
  PinterestTextField({
    @required this.props,
  });

  final PinterestTextFieldProps props;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          props.label,
        ),
        TextFormField(
          obscureText: props.obscure,
          validator: props.validator,
          onChanged: props.onChanged,
          onSaved: props.onSaved,
          decoration: InputDecoration(
            hintText: props.hintText,
            border: InputBorder.none,
          ),
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
