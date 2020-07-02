import 'package:flutter/material.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/view/components/bottom_sheet_menu.dart';

class CreateNewScreen extends StatelessWidget {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PinterestButton.primary(
                text: 'Board',
                onPressed: () async {
                  await Navigator.of(context).pushNamed(Routes.createNewBoard);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 20),
              PinterestButton.primary(
                text: 'Pin',
                onPressed: () => _onPinPressed(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _onPinPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.createNewPin);
    Navigator.pop(context);
  }
}

class CreateNewMenu {
  static Future show({@required BuildContext context}) async {
    return BottomSheetMenu.show(context: context, children: [
      BottomSheetMenuItem(
        title: const Text('ボードの作成'),
        onTap: () async {
          await Navigator.of(context).pushNamed(Routes.createNewBoard);
          Navigator.pop(context);
        },
      ),
      BottomSheetMenuItem(
        title: const Text('ピンの作成'),
        onTap: () async {
          await Navigator.of(context).pushNamed(Routes.createNewPin);
          Navigator.pop(context);
        },
      ),
    ]);
  }
}
