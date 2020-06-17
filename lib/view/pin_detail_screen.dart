import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile/view/components/notification.dart';

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPinImageArea(context, pin.imageUrl),
              // TODO 投稿者情報を入れる
              SizedBox(height: 32),
              _buildPinInfo(
                title: pin.title,
                description: pin.description,
              ),
              SizedBox(height: 32),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinImageArea(BuildContext context, String imageUrl) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        _pinImage(imageUrl),
        Positioned(
          left: 12,
          top: 16,
          child: _backButton(context),
        ),
      ],
    );
  }

  Widget _pinImage(String imageUrl) {
    return CachedNetworkImage(
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
    return Column(
      children: <Widget>[
        PinterestTypography.body1(title),
        SizedBox(height: 8),
        PinterestTypography.body2(description),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PinterestButton.secondary(
          text: 'Access',
          onPressed: () {
            // TODO
            PinterestNotification.showNotImplemented();
          },
        ),
        SizedBox(width: 20),
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
}
