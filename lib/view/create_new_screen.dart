import 'package:flutter/material.dart';

class CreateNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Board'),
                onPressed: () {
                  // TODO do navigation
                },
              ),
              SizedBox(width: 20),
              RaisedButton(
                child: Text('Pin'),
                onPressed: () {
                  // TODO do navigation
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
