import 'package:flutter/material.dart';
import 'package:mobile/routes.dart';

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
                  Navigator.of(context).pushNamed(Routes.createNewBoard);
                },
              ),
              SizedBox(width: 20),
              RaisedButton(
                child: Text('Pin'),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.createNewPinSelectPhoto);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
