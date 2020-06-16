import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PinDetailScreenArguments {
  const PinDetailScreenArguments({this.pin});

  final Pin pin;
}

class PinDetailScreen extends StatelessWidget {
  const PinDetailScreen({this.args});

  final PinDetailScreenArguments args;

  @override
  Widget build(BuildContext context) {
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
                    _pinImage(pin.imageUrl),
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

  Widget _pinImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Container(
        height: 200,
        width: 200,
      ),
      errorWidget: (context, url, dynamic error) => const Placeholder(
        fallbackHeight: 200,
        fallbackWidth: 200,
        color: Colors.grey,
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
