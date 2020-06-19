import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/board_card.dart';

typedef BoardGridViewCallback = void Function(
    BuildContext context, Board board);

class BoardGridView extends StatefulWidget {
  const BoardGridView({
    this.boards,
    this.boardPinMap,
    this.layout = BoardGridViewLayout.large,
    this.onTap,
  });

  final List<Board> boards;
  final Map<int, List<Pin>> boardPinMap;
  final BoardGridViewLayout layout;
  final BoardGridViewCallback onTap;

  @override
  _BoardGridViewState createState() => _BoardGridViewState();
}

enum BoardGridViewLayout {
  large,
  compact,
  slim,
}

class _BoardGridViewState extends State<BoardGridView> {
  StaggeredGridView _styleLarge(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      crossAxisCount: 1,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      staggeredTileBuilder: (index) {
        return const StaggeredTile.fit(1);
      },
      itemCount: widget.boards.length,
      itemBuilder: (context, index) {
        return BoardCardLarge(
          board: widget.boards[index],
          pins: widget.boardPinMap[widget.boards[index].id],
          onTap: () => widget.onTap(context, widget.boards[index]),
        );
      },
    );
  }

  StaggeredGridView _styleCompact(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      staggeredTileBuilder: (index) {
        return const StaggeredTile.fit(1);
      },
      itemCount: widget.boards.length,
      itemBuilder: (context, index) {
        return BoardCardCompact(
          board: widget.boards[index],
          pins: widget.boardPinMap[widget.boards[index].id],
          onTap: () => widget.onTap(context, widget.boards[index]),
        );
      },
    );
  }

  StaggeredGridView _styleSlim(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      crossAxisCount: 1,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      staggeredTileBuilder: (index) {
        return const StaggeredTile.fit(1);
      },
      itemCount: widget.boards.length,
      itemBuilder: (context, index) {
        return BoardCardSlim(
          board: widget.boards[index],
          pins: widget.boardPinMap[widget.boards[index].id],
          onTap: () => widget.onTap(context, widget.boards[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.boards.isNotEmpty) {
      switch (widget.layout) {
        case BoardGridViewLayout.large:
          return _styleLarge(context);
          break;
        case BoardGridViewLayout.compact:
          return _styleCompact(context);
          break;
        case BoardGridViewLayout.slim:
          return _styleSlim(context);
        default:
          throw Exception();
      }
    } else {
      return Container(
        child: const Center(
          child: Text('ボードがありませんでした'),
        ),
      );
    }
  }
}
