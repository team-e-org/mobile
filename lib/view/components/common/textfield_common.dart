import 'package:flutter/material.dart';

class PinterestTextFieldProps {
  PinterestTextFieldProps({
    @required this.label,
    @required this.hintText,
    this.initialValue,
    this.validator,
    this.obscure = false,
    this.onChanged,
    this.onSaved,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.maxLength = null,
    this.maxLengthEnforced = false,
  });

  final String initialValue;
  final FormFieldValidator<String> validator;
  final String label;
  final String hintText;
  final bool obscure;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSaved;
  final int maxLines, minLines;
  final TextInputType keyboardType;
  final int maxLength;
  final bool maxLengthEnforced;
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
          initialValue: props.initialValue,
          obscureText: props.obscure,
          validator: props.validator,
          onChanged: props.onChanged,
          onSaved: props.onSaved,
          maxLines: props.obscure ? 1 : props.maxLines,
          minLines: props.minLines,
          keyboardType: props.keyboardType,
          maxLength: props.maxLength,
          maxLengthEnforced: props.maxLengthEnforced,
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
