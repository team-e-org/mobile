import 'package:flutter/material.dart';
import 'package:mobile/view/components/components.dart';

class WidgetPreview extends StatelessWidget {
  // Widget child = PinCard();
  Widget child = Container(
    child: Column(
      children: [BoardCardLarge(), BoardCardLarge()],
    ),
  );

  WidgetPreview();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
