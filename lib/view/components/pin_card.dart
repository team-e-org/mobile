import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/common/typography_common.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_pinImage(), const SizedBox(height: 4), _pinTitle()],
        ),
      ),
    );
  }

  Widget _pinImage() {
    return CachedNetworkImage(
      imageUrl: pin.imageUrl,
      placeholder: (context, url) => Container(
        height: 200,
        color: Colors.grey[100],
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]),
          ),
        ),
      ),
      errorWidget: (context, url, dynamic error) {
        Logger().e(error);
        return Container(
          child: const Text(
            'Sorry, failed to load image.',
          ),
        );
      },
    );
  }

  Widget _pinTitle() {
    return PinterestTypography.body2(
      pin.title ?? ' ',
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
