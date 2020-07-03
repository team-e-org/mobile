import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/board_card.dart';

typedef BoardGridViewCallback = void Function(
    BuildContext context, Board board);

class BoardGridView extends StatefulWidget {
  const BoardGridView({
    this.itemBuilder,
    this.itemCount,
    this.layout = BoardGridViewLayout.large,
    this.shrinkWrap = false,
    this.primary = false,
    this.physics,
  });

  final int itemCount;
  final BoardCardProps Function(BuildContext, int) itemBuilder;

  final BoardGridViewLayout layout;
  final bool shrinkWrap, primary;
  final ScrollPhysics physics;

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
      shrinkWrap: widget.shrinkWrap,
      primary: widget.primary,
      physics: widget.physics,
      staggeredTileBuilder: (index) {
        return const StaggeredTile.fit(1);
      },
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return BoardCardLarge(
          props: widget.itemBuilder(context, index),
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
      shrinkWrap: widget.shrinkWrap,
      primary: widget.primary,
      physics: widget.physics,
      staggeredTileBuilder: (index) {
        return const StaggeredTile.fit(1);
      },
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return BoardCardCompact(
          props: widget.itemBuilder(context, index),
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
      shrinkWrap: widget.shrinkWrap,
      primary: widget.primary,
      physics: widget.physics,
      staggeredTileBuilder: (index) {
        return const StaggeredTile.fit(1);
      },
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return BoardCardSlim(
          props: widget.itemBuilder(context, index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount != 0) {
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
