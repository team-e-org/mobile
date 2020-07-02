import 'package:flutter/material.dart';
import 'package:mobile/flavors.dart';

class FlavorTitleBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      color: Colors.yellow,
      child: Text(
        F.title,
        textAlign: TextAlign.center,
      ),
    );
  }
}
