import 'package:flutter/material.dart';

class MockScreenCommon extends StatelessWidget {
  MockScreenCommon({
    this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(name),
      ),
    );
  }
}
