import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:http/http.dart' as http;

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
          children: [
            Container(child: _pinImage()),
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

  Future<bool> _validateImageUrl() async {
    try {
      final res = await http.head(pin.imageUrl);
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Widget _pinImage() {
    return FutureBuilder(
      future: _validateImageUrl(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        var imageUrl = '';
        if (snapshot.hasData && snapshot.data == true) {
          imageUrl = pin.imageUrl;
        }
        return Image.network(imageUrl);
      },
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
