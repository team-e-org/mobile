import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';

class BoardCard extends StatelessWidget {
  final Board board;
  final List<Pin> pins;
  final Function onTap;
  final EdgeInsetsGeometry margin;

  BoardCard({
    this.board,
    this.pins = const [],
    this.onTap,
    this.margin = const EdgeInsets.all(0),
  });

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
                child: Column(
                  children: [
                    _boardName(),
                  ],
                ),
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

  Widget _imageGrids() {
    var _imageUrl = pins.length > 0 ? pins[0].imageUrl : "";
    return Container(
        child: Row(
      children: [
        Image(
          image: NetworkImage(_imageUrl),
        ),
      ],
    ));
  }

  Widget _boardName() {
    return Text(
      board.name,
      style: TextStyle(
        fontSize: 24,
      ),
    );
  }
}
