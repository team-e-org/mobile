import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class PinterestNotification {
  static void show({
    String title = 'Notification title',
    String subtitle = '',
    Duration duration = const Duration(seconds: 4),
  }) {
    showOverlayNotification(
      (context) => _PinterestNotificationWidget(
        title: title,
        subtitle: subtitle,
      ),
      duration: duration,
    );
  }

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
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: SafeArea(
        child: ListTile(
          leading: SizedBox.fromSize(
            size: const Size(40, 40),
            child: ClipOval(
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
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
