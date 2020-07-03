import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/board_grid_view.dart';
import 'package:mobile/view/components/components.dart';
import 'package:mobile/view/components/reloadable_board_grid_view.dart';

class BoardSelectPage extends StatelessWidget {
  BoardSelectPage({
    this.boards = const [],
    this.isLoading = true,
    this.boardPinMap = const {},
    this.onSelected,
    this.isError = false,
    this.onReload,
    this.onRefresh,
    this.enableAddBoard = true,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            enableAddBoard ? _addBoardCard(context) : null,
            ReloadableBoardGridView(
              itemCount: boards.length,
              itemBuilder: (context, index) {
                return BoardCardProps(
                  board: boards[index],
                  pins: boardPinMap[boards[index].id],
                  onTap: () => onSelected(context, boards[index]),
                );
              },
              layout: BoardGridViewLayout.slim,
              isLoading: isLoading,
              isError: isError,
              onReload: onReload,
              onRefresh: onRefresh,
            ),
          ]..removeWhere((e) => e == null),
        ),
      ),
    );
  }

  Widget _addBoardCard(BuildContext context) {
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
