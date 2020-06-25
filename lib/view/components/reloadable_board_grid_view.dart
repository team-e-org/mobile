import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/board_grid_view.dart';
import 'package:mobile/view/components/common/button_common.dart';

class ReloadableBoardGridView extends StatelessWidget {
  const ReloadableBoardGridView({
    this.layout = BoardGridViewLayout.large,
    this.isLoading = false,
    this.boards = const [],
    this.boardPinMap = const {},
    this.onBoardTap,
    this.onScrollOut,
    this.isError = false,
    this.onReload,
    this.onRefresh,
  });

  final bool isLoading;

  final BoardGridViewLayout layout;
  final List<Board> boards;
  final Map<int, List<Pin>> boardPinMap;
  final BoardGridViewCallback onBoardTap;
  final VoidCallback onScrollOut;
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
          const Text('ボードの読み込みに失敗しました'),
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
          Text('ボードが見つかりませんでした'),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (boards.isEmpty) {
      if (isLoading) {
        return _loadingWidget();
      } else if (isError) {
        return _errorWidget();
      }
      return _notFoundWidget();
    }

    final controller = ScrollController();
    controller.addListener(() {
      if (controller.position.maxScrollExtent <= controller.position.pixels) {
        onScrollOut();
      }
    });

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
                BoardGridView(
                  boards: boards,
                  boardPinMap: boardPinMap,
                  onTap: onBoardTap,
                  shrinkWrap: true,
                  primary: true,
                  physics: const NeverScrollableScrollPhysics(),
                  layout: layout,
                ),
                tailWidget ?? Container()
              ],
            ),
            controller: controller,
          ),
        ));
  }
}
