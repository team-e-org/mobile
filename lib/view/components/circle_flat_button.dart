import 'package:flutter/material.dart';

class CircleFlatButton extends StatelessWidget {
  CircleFlatButton({
    this.icon,
    this.onTap,
    Color backgroundColor,
  }) {
    this.backgroundColor = backgroundColor ?? Colors.black.withOpacity(0.3);
  }

  final IconData icon;
  final VoidCallback onTap;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: backgroundColor, // button color
        child: InkWell(
          child: SizedBox(
            width: 42,
            height: 42,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
