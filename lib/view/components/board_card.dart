import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
              _imageGridContainer(),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _boardName(),
              ),
            ],
          )),
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

  Widget _imageGridContainer() {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: _imageGrids(pins),
        ),
      ),
    );
  }

  Widget _imageGrids(List<Pin> pins) {
    if (pins.isEmpty) {
      return Container(
        color: Colors.grey,
        child: const Center(child: Icon(Icons.photo_library)),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: pins[0].imageUrl,
          ),
        ),
        pins.length > 1
            ? Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: pins[1].imageUrl,
                        ),
                      ),
                      pins.length > 2
                          ? Expanded(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: pins[2].imageUrl,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  Widget _boardName() {
    return Text(
      board.name,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
