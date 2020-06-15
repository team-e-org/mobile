import 'package:flutter/material.dart';

class PinterestTextField extends StatelessWidget {
  PinterestTextField({
    @required this.label,
    @required this.hintText,
    this.validator,
    this.onChanged,
  });

  final FormFieldValidator validator;
  final String label;
  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
        ),
        TextFormField(
          validator: validator,
          onChanged: onChanged,
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
