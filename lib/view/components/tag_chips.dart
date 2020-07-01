import 'package:flutter/material.dart';

class TagChips extends StatelessWidget {
  TagChips({this.tags = const []});

  final List<String> tags;
  @override
  Widget build(BuildContext context) {
    if (tags == null) {
      return Container();
    }

    final tagWidgets = tags
        .map((tag) => Chip(
              key: Key(tag),
              label: Text(
                tag,
                style: TextStyle(fontSize: 12),
              ),
            ))
        .toList();

    return Container(
      child: tagWidgets.isNotEmpty
          ? Wrap(
              spacing: 4,
              alignment: WrapAlignment.center,
              children: tagWidgets,
            )
          : Container(),
    );
  }
}
