import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:mobile/view/components/notification.dart';

class PinCard extends StatelessWidget {
  const PinCard({
    this.pin,
    this.onTap,
  });

  final Pin pin;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _pinImageContainer(),
          const SizedBox(height: 4),
          _pinInfo(),
        ]),
      ),
    );
  }

  Widget _pinImageContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: _pinImage(),
    );
  }

  Widget _pinImage() {
    return CachedNetworkImage(
      imageUrl: pin.imageUrl,
      placeholder: (context, url) {
        return _placeholder(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]),
          ),
        );
      },
      errorWidget: (context, url, dynamic error) {
        Logger().e(error);
        return _placeholder(
            child: const Icon(
          Icons.error_outline,
          color: Colors.black,
        ));
      },
    );
  }

  Widget _placeholder({Widget child}) {
    return Container(
      height: 200,
      color: Colors.grey[100],
      child: Center(child: child),
    );
  }

  Widget _pinInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(child: _pinTitle()),
          _optionButton(),
        ],
      ),
    );
  }

  Widget _optionButton() {
    return Container(
      width: 16,
      height: 16,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(
          Icons.more_horiz,
          size: 16,
        ),
        onPressed: () {
          PinterestNotification.showNotImplemented();
        },
        iconSize: 16,
      ),
    );
  }

  Widget _pinTitle() {
    return PinterestTypography.body2(
      pin.title ?? '',
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
