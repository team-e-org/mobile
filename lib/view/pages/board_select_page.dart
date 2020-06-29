import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/board_grid_view.dart';
import 'package:mobile/view/components/components.dart';
import 'package:mobile/view/components/reloadable_board_grid_view.dart';

class BoardSelectPage extends StatelessWidget {
  BoardSelectPage({
    this.boards,
    this.isLoading,
    this.boardPinMap,
    this.onSelected,
    this.isError,
    this.onReload,
    this.onRefresh,
    this.enableAddBoard,
  });

  List<Board> boards;
  bool isLoading;
  Map<int, List<Pin>> boardPinMap;
  void Function(BuildContext, Board) onSelected;
  bool isError;
  VoidCallback onReload;
  RefreshCallback onRefresh;
  bool enableAddBoard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select board'),
      ),
      body: Container(
        child: Column(
          children: [
            enableAddBoard ? _addBoardCard(context) : null,
            Expanded(
              child: ReloadableBoardGridView(
                layout: BoardGridViewLayout.slim,
                isLoading: isLoading,
                boards: boards,
                boardPinMap: boardPinMap,
                onBoardTap: onSelected,
                isError: isError,
                onReload: onReload,
                onRefresh: onRefresh,
              ),
            ),
          ]..remove(null),
        ),
      ),
    );
  }

  Widget _addBoardCard(BuildContext context) {
    @override
    Widget build(BuildContext context) {
      return ActionCardSlim(
        text: 'Add Board',
        icon: Icon(Icons.add),
        onTap: () async {
          await Navigator.of(context).pushNamed(Routes.createNewBoard);
          if (onReload != null) {
            onReload();
          }
        },
      );
    }
  }
}
