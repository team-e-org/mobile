import 'package:flutter/material.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:overlay_support/overlay_support.dart';

class PinterestNotification {
  static void show({
    String title = 'Notification title',
    String subtitle = '',
    Duration duration = const Duration(seconds: 4),
    Color color,
    Widget leading,
  }) {
    showOverlayNotification(
      (context) => _PinterestNotificationWidget(
        title: title,
        subtitle: subtitle,
        leading: leading,
        color: color,
      ),
      duration: duration,
    );
  }

  static void showError({
    String title = 'Notification title',
    String subtitle = '',
    Duration duration = const Duration(seconds: 4),
  }) =>
      show(
        title: title,
        subtitle: subtitle,
        duration: duration,
        color: Colors.red[400],
      );

  static void showNotImplemented() {
    show(
      title: 'まだ実装してないねん。',
      subtitle: 'ほんまにごめんな...',
    );
  }
}

class _PinterestNotificationWidget extends StatelessWidget {
  _PinterestNotificationWidget({
    @required this.title,
    this.subtitle,
    this.color,
    this.textColor,
    this.leading,
  });

  final String title;
  final String subtitle;
  final Color color;
  final Color textColor;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: SafeArea(
        child: ListTile(
          leading: leading != null
              ? SizedBox.fromSize(
                  size: const Size(40, 40),
                  child: leading,
                )
              : null,
          title: PinterestTypography.body1(
            title,
            color: textColor,
          ),
          subtitle: PinterestTypography.body2(
            subtitle,
            color: textColor,
          ),
          trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                OverlaySupportEntry.of(context).dismiss();
              }),
        ),
      ),
    );
  }
}
