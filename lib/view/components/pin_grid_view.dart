import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/components.dart';

typedef PinGridViewCallback = void Function(BuildContext context, Pin pin);

class PinGridView extends StatelessWidget {
  const PinGridView({
    this.itemCount = 0,
    this.itemBuilder,
    this.board,
    this.pins = const [],
    this.onTap,
    this.controller,
    this.shrinkWrap = false,
    this.primary = false,
    this.physics,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Board board;
  final List<Pin> pins;
  final PinGridViewCallback onTap;
  final ScrollController controller;
  final bool shrinkWrap, primary;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      staggeredTileBuilder: _staggeredTileBuilder,
      controller: controller,
      shrinkWrap: shrinkWrap,
      primary: primary,
      physics: physics,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return PinCard(
      board: board,
      pin: pins[index],
      onTap: () => onTap(context, pins[index]),
    );
  }

  StaggeredTile _staggeredTileBuilder(int index) {
    return const StaggeredTile.fit(2);
  }
}
