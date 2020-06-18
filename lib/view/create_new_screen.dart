import 'package:flutter/material.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/notification.dart';

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
                onPressed: () async {
                  final result = await Navigator.of(context)
                      .pushReplacementNamed(Routes.createNewBoard);

                  if (result is Board) {
                    PinterestNotification.show(
                      title: 'New board created',
                      subtitle: result.name,
                    );
                  }
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
