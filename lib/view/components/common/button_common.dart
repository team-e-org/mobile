import 'package:flutter/material.dart';

enum PinterestButtonVariant {
  primary,
  secondary,
}

class PinterestButton extends StatelessWidget {
  PinterestButton.primary({
    @required this.text,
    @required this.onPressed,
  }) : variant = PinterestButtonVariant.primary;

  PinterestButton.secondary({
    @required this.text,
    @required this.onPressed,
  }) : variant = PinterestButtonVariant.secondary;

  final String text;
  final VoidCallback onPressed;
  final PinterestButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        text,
        style: TextStyle(
          color: variant == PinterestButtonVariant.primary
              ? Colors.white
              : Colors.black,
        ),
      ),
      onPressed: onPressed,
      color: variant == PinterestButtonVariant.primary
          ? Theme.of(context).buttonColor
          : Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9999),
      ),
    );
  }
}
