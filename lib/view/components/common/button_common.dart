import 'package:flutter/material.dart';
import 'package:mobile/theme.dart';

enum PinterestButtonVariant {
  primary,
  secondary,
}

enum PinterestButtonSize {
  normal,
  big,
}

class PinterestButton extends StatelessWidget {
  const PinterestButton.primary({
    @required this.text,
    @required this.onPressed,
    this.loading = false,
    this.size = PinterestButtonSize.normal,
  }) : variant = PinterestButtonVariant.primary;

  const PinterestButton.secondary({
    @required this.text,
    @required this.onPressed,
    bool this.loading = false,
    this.size = PinterestButtonSize.normal,
  }) : variant = PinterestButtonVariant.secondary;

  final String text;
  final VoidCallback onPressed;
  final PinterestButtonVariant variant;
  final bool loading;
  final PinterestButtonSize size;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: loading
          ? _loadingIndicator()
          : Text(text,
              style: TextStyle(
                color: variant == PinterestButtonVariant.primary
                    ? ColorPalettes.defaultPalette.thirdText
                    : ColorPalettes.defaultPalette.primaryText,
              )),
      onPressed: onPressed,
      padding: size == PinterestButtonSize.big
          ? const EdgeInsets.symmetric(vertical: 16)
          : const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9999),
      ),
      color: variant == PinterestButtonVariant.primary
          ? ColorPalettes.defaultPalette.primary
          : ColorPalettes.defaultPalette.secondary,
    );
  }

  Widget _loadingIndicator() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(),
    );
  }
}
