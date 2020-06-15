import 'package:flutter/material.dart';

enum PinterestButtonVariant {
  primary,
  secondary,
}

class PinterestButton extends StatelessWidget {
  PinterestButton.primary({
    @required this.text,
    @required this.onPressed,
    bool this.loading = false,
  }) : variant = PinterestButtonVariant.primary;

  PinterestButton.secondary({
    @required this.text,
    @required this.onPressed,
    bool this.loading = false,
  }) : variant = PinterestButtonVariant.secondary;

  final String text;
  final VoidCallback onPressed;
  final PinterestButtonVariant variant;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: loading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
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
