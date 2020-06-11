import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';

class PinCard extends StatelessWidget {
  final Pin pin;
  final Function onClick;

  PinCard({
    this.pin,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.red,
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
