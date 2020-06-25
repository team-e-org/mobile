import 'package:flutter/material.dart';
import 'package:mobile/model/pin_model.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/pin_grid_view.dart';

class ReloadablePinGridView extends StatelessWidget {
  const ReloadablePinGridView({
    this.isLoading = false,
    this.pins = const [],
    this.onPinTap,
    this.onScrollOut,
    this.isError = false,
    this.onReload,
  });

  final bool isLoading;

  final List<Pin> pins;
  final PinGridViewCallback onPinTap;
  final VoidCallback onScrollOut;
  final bool isError;
  final VoidCallback onReload;

  @override
  Widget build(BuildContext context) {
    if (pins.isEmpty) {
      if (isLoading) {
        return Container(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (isError) {
        return Container(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('画像の読み込みに失敗しました'),
              PinterestButton.primary(text: 'Reload', onPressed: onReload)
            ],
          )),
        );
      }

      return Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('画像が見つかりませんでした'),
          ],
        )),
      );
    }

    final controller = ScrollController();
    controller.addListener(() {
      if (controller.position.maxScrollExtent <= controller.position.pixels) {
        onScrollOut();
      }
    });

    Widget tailWidget;
    if (isLoading) {
      tailWidget = Container(
        height: 120,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (isError) {
      tailWidget = Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('画像の読み込みに失敗しました'),
            PinterestButton.primary(text: 'Reload', onPressed: onReload)
          ],
        ),
      );
    }

    return Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PinGridView(
                pins: pins,
                onTap: onPinTap,
                shrinkWrap: true,
                primary: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              tailWidget ?? Container()
            ],
          ),
          controller: controller,
        ));
  }
}
