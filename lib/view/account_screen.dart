import 'package:flutter/material.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MockScreenCommon(
        name: 'Account screen',
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/new');
        },
      ),
    );
  }
}
