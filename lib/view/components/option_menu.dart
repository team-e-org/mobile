import 'package:flutter/material.dart';

class BottomSheetMenu {
  Future show(BuildContext context, {List<BottomSheetMenuItem> children}) {
    return showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        );
      },
    );
  }
}

class BottomSheetMenuItem extends StatelessWidget {
  const BottomSheetMenuItem({
    this.leading,
    this.title,
    this.onTap,
  });

  final Widget leading;
  final Widget title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      onTap: onTap,
    );
  }
}
