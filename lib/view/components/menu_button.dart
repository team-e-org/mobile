import 'package:flutter/material.dart';
import 'package:mobile/view/components/bottom_sheet_menu.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    this.size = 16,
    this.items,
  });

  final double size;
  final List<BottomSheetMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(
          Icons.more_horiz,
          size: size,
        ),
        onPressed: () async {
          await BottomSheetMenu.show(
            context: context,
            items: items,
          );
        },
        iconSize: size,
      ),
    );
  }
}
