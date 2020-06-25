import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile/view/components/notification.dart';
import 'package:url_launcher/url_launcher.dart';

class PinDetailScreenArguments {
  const PinDetailScreenArguments({this.pin});

  final Pin pin;
}

class PinDetailScreen extends StatelessWidget {
  const PinDetailScreen({this.args});

  final PinDetailScreenArguments args;

  @override
  Widget build(BuildContext context) {
    final pin = args.pin;

    if (pin == null) {
      throw Exception('arguments is invalid');
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(child: _buildContent(context, pin)),
          Positioned(
            left: 12,
            top: 16,
            child: _backButton(context),
          ),
        ]),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Pin pin) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _pinImage(pin.imageUrl),
          // TODO 投稿者情報を入れる
          SizedBox(height: 32),
          _buildPinInfo(
            title: pin.title,
            description: pin.description,
          ),
          SizedBox(height: 32),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _pinImage(String imageUrl) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 500), // FIXME 決め打ちにしない
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: 200,
          width: 200,
        ),
        errorWidget: (_, __, dynamic err) => const Placeholder(
          fallbackHeight: 200,
          fallbackWidth: 200,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.black.withOpacity(0.3), // button color
        child: InkWell(
          child: SizedBox(
            width: 42,
            height: 42,
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _buildPinInfo({String title, String description}) {
    if (title == null && String == null) {
      return Container();
    }

    final list = <Widget>[];

    if (title != null) {
      list.add(PinterestTypography.body1(title));
    }
    if (title != null && description != null) {
      list.add(const SizedBox(height: 8));
    }
    if (description != null) {
      list.add(PinterestTypography.body2(description));
    }

    return Column(children: list);
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PinterestButton.secondary(
          text: 'Access',
          onPressed: () => _onAccessPressed(context),
        ),
        const SizedBox(width: 20),
        PinterestButton.primary(
          text: 'Save',
          onPressed: () {
            // TODO
            PinterestNotification.showNotImplemented();
          },
        ),
      ],
    );
  }

  Future _onAccessPressed(BuildContext context) async {
    Logger().d('Open URL: ${args.pin.url}');
    if (await canLaunch(args.pin.url)) {
      await launch(args.pin.url);
    } else {
      PinterestNotification.showError(title: '無効なURLです');
    }
  }
}
