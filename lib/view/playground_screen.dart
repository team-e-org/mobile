import 'package:flutter/material.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/textfield_common.dart';
import 'package:mobile/view/components/common/typography_common.dart';

class PlaygroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PinterestButton.primary(text: 'Primary', onPressed: () {}),
                SizedBox(width: 20),
                PinterestButton.secondary(text: 'Primary', onPressed: () {}),
              ],
            ),
            PinterestTextField(
              label: 'Title',
              hintText: 'hint etxt',
            ),
            PinterestTextField(
              label: 'Name',
              hintText: 'Type your name',
            ),
            PinterestTypography.body1('body1'),
            PinterestTypography.body2('body2'),
            PinterestTypography.header('header'),
          ],
        ),
      ),
    );
  }
}
