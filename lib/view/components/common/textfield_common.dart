import 'package:flutter/material.dart';

class PinterestTextField extends StatelessWidget {
  PinterestTextField({
    @required this.label,
    @required this.hintText,
    this.validator,
    this.obscure,
    this.onChanged,
    this.onSaved,
  });

  final FormFieldValidator<String> validator;
  final String label;
  final String hintText;
  final bool obscure;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
        ),
        TextFormField(
          obscureText: obscure,
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
          decoration: InputDecoration(
            hintText: hintText,
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
