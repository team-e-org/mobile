import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

// TODO
// 切り分け
// UIの作り込み

class PinDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO
    // いちいちここで読み込むん非効率では
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Pin pin = args['pin'] as Pin;

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              // TODO
              // 切り出し
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
              // TODO
              // 切り出し
              Container(
                margin: const EdgeInsets.all(8),
                child: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ),
              // TODO
              // 切り出し
              Positioned(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
