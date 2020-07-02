import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/pin_grid_view.dart';

class ReloadablePinGridView extends StatelessWidget {
  const ReloadablePinGridView({
    this.isLoading = false,
    @required this.itemCount,
    @required this.itemBuilder,
    this.onScrollOut,
    this.enableScrollOut = true,
    this.isError = false,
    this.onReload,
    this.onRefresh,
  });

  final bool isLoading;

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  final VoidCallback onScrollOut;
  final bool enableScrollOut;
  final bool isError;
  final VoidCallback onReload;
  final RefreshCallback onRefresh;

  Widget _loadingWidget() {
    return Container(
      height: 160,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _errorWidget() {
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

  Widget _notFoundWidget() {
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

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      if (isLoading) {
        return _loadingWidget();
      } else if (isError) {
        return _errorWidget();
      }
      return _notFoundWidget();
    }
    final controller = ScrollController();
    if (enableScrollOut) {
      controller.addListener(() {
        if (controller.position.maxScrollExtent <= controller.position.pixels) {
          if (onScrollOut != null) {
            onScrollOut();
          }
        }
      });
    }

    Widget tailWidget;
    if (isLoading) {
      tailWidget = _loadingWidget();
    } else if (isError) {
      tailWidget = _errorWidget();
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              PinGridView(
                itemCount: itemCount,
                itemBuilder: itemBuilder,
                shrinkWrap: true,
                primary: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              tailWidget ?? Container()
            ],
          ),
          controller: controller,
        ),
      ),
    );
  }
}
