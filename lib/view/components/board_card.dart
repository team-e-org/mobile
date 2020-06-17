import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:http/http.dart' as http;

class BoardCard extends StatelessWidget {
  const BoardCard({
    this.board,
    this.pins = const [],
    this.onTap,
    this.margin = const EdgeInsets.all(0),
  });

  final Board board;
  final List<Pin> pins;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _imageContainer(),
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _boardName(),
              ),
            ],
          )),
    );
  }

  Widget _imageContainer() {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(24),
        ),
        child: _imageGrids(),
      ),
    );
  }

  Future<bool> _validateImageUrl(String url) async {
    try {
      final res = await http.head(url);
      return res.statusCode == 200;
    } on Exception catch (e) {
      Logger().w(e);
      return false;
    }
  }

  Widget _imageGrids() {
    final pin = pins[0];
    return FutureBuilder(
      future: _validateImageUrl(pin.imageUrl),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        var imageUrl = '';
        if (snapshot.hasData && snapshot.data == true) {
          imageUrl = pin.imageUrl;
        }
        return Image.network(imageUrl);
      },
    );
  }

  Widget _boardName() {
    return Text(
      board.name,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }
}
