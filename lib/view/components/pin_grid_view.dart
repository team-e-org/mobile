import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/components.dart';

typedef PinGridViewCallback = void Function(BuildContext context, Pin pin);

class PinGridView extends StatelessWidget {
  const PinGridView({
    this.pins = const [],
    this.onTap,
    this.controller,
  });

  final List<Pin> pins;
  final PinGridViewCallback onTap;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: pins.length,
      itemBuilder: _itemBuilder,
      staggeredTileBuilder: _staggeredTileBuilder,
      controller: controller,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return PinCard(
      pin: pins[index],
      onTap: () => onTap(context, pins[index]),
    );
  }

  // TODO(dh9489): 高さをPinCardの高さに変更する
  StaggeredTile _staggeredTileBuilder(int index) {
    return const StaggeredTile.count(1, 1);
  }
}
