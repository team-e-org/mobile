import 'package:flutter/material.dart';

class BottomSheetMenu {
  static Future show({
    @required BuildContext context,
    List<BottomSheetMenuItem> items = const [],
  }) async {
    return showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
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
