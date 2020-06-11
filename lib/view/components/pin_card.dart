import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';

class PinCard extends StatelessWidget {
  final Pin pin;
  final Function onTap;

  PinCard({
    this.pin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image(
                image: NetworkImage(pin.imageUrl),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _pinTitle(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _pinTitle() {
    return Text(
      pin.title,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
