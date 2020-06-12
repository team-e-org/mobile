import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/components.dart';

class PinGridView extends StatelessWidget {
  final List<Pin> pins;
  PinGridView({
    this.pins = const [],
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      itemCount: pins.length,
      itemBuilder: _itemBuilder,
      staggeredTileBuilder: _staggeredTileBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return new PinCard(
      pin: pins[index],
      onTap: () => _onPinCardTap(context, pins[index]),
    );
  }

  // TODO
  // 高さをPinCardの高さに変更する
  StaggeredTile _staggeredTileBuilder(int index) {
    return StaggeredTile.count(1, 1);
  }

  void _onPinCardTap(BuildContext context, Pin pin) {
    Navigator.of(context).pushNamed(
      '/pin/detail',
      arguments: {
        "pin": pin,
      },
    );
  }
}
