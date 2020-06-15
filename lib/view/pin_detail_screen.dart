import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

class PinDetailScreenArguments {
  const PinDetailScreenArguments({this.pin});

  final Pin pin;
}

class PinDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as PinDetailScreenArguments;
    final pin = args.pin;

    if (pin == null) {
      throw Exception('arguments is invalid');
    }

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(pin.imageUrl),
                    // TODO
                    // UserCard()
                    Text(pin.title),
                    Text(pin.description),
                  ],
                ),
              ),
              _backButton(context),
              _floatingButtomActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () => {Navigator.of(context).pop()},
      ),
    );
  }

  Widget _floatingButtomActionButtons() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: アクションボタンの共通コンポーネント化
            FlatButton(
              child: Text("Access"),
              color: Colors.grey,
              onPressed: () {},
            ),
            FlatButton(
              child: Text("Save"),
              color: Colors.red,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
