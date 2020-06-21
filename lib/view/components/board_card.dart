import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';

class BoardCardLarge extends BoardCardBase {
  const BoardCardLarge({
    @required this.board,
    this.pins = const [],
    this.onTap,
    this.margin,
  }) : super(
          board: board,
          pins: pins,
          onTap: onTap,
          margin: margin,
          titleStyle: const TextStyle(fontSize: 16),
          subtitleStyle: const TextStyle(fontSize: 12),
        );

  final Board board;
  final List<Pin> pins;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        color: ThemeData().scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageGridContainer(),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _infoContainer(),
            ),
          ],
        ),
      ),
    );
  }
}

class BoardCardCompact extends BoardCardBase {
  const BoardCardCompact({
    @required this.board,
    this.pins = const [],
    this.onTap,
    this.margin,
  }) : super(
          board: board,
          pins: pins,
          onTap: onTap,
          margin: margin,
          titleStyle: const TextStyle(fontSize: 12),
          subtitleStyle: const TextStyle(fontSize: 8),
        );

  final Board board;
  final List<Pin> pins;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        color: ThemeData().scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageGridContainer(),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _infoContainer(),
            ),
          ],
        ),
      ),
    );
  }
}

class BoardCardSlim extends BoardCardBase {
  const BoardCardSlim({
    @required this.board,
    this.pins = const [],
    this.onTap,
    this.margin,
  }) : super(
          board: board,
          pins: pins,
          onTap: onTap,
          margin: margin,
          titleStyle: const TextStyle(fontSize: 14),
          subtitleStyle: const TextStyle(fontSize: 12),
        );

  final Board board;
  final List<Pin> pins;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: ThemeData().scaffoldBackgroundColor,
        margin: margin,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _imageContainer(),
            const SizedBox(width: 10),
            _infoContainer(),
          ],
        ),
      ),
    );
  }
}

class ActionCardSlim extends StatelessWidget {
  const ActionCardSlim({
    this.text,
    this.icon,
    this.onTap,
    this.margin,
  });

  final String text;
  final Icon icon;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        color: ThemeData().scaffoldBackgroundColor,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _imageContainer(),
            const SizedBox(width: 10),
            _infoContainer(),
          ],
        ),
      ),
    );
  }

  Widget _imageContainer() {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }

  Widget _infoContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

abstract class BoardCardBase extends StatelessWidget {
  const BoardCardBase({
    @required this.board,
    this.pins = const [],
    this.onTap,
    this.margin,
    this.titleStyle = _titleStyle,
    this.subtitleStyle = _subtitleStyle,
  });

  final Board board;
  final List<Pin> pins;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;
  final TextStyle titleStyle, subtitleStyle;

  Widget _imageContainer() {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        child:
            ClipRRect(borderRadius: BorderRadius.circular(8), child: _image()),
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(
      imageUrl: pins[0].imageUrl,
      fit: BoxFit.cover,
    );
  }

  Widget _imageGridContainer() {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: _imageGrids(),
        ),
      ),
    );
  }

  Widget _imageGrids() {
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

  static const TextStyle _titleStyle = TextStyle(fontSize: 16);
  static const TextStyle _subtitleStyle = TextStyle(fontSize: 12);

  Widget _infoContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          board.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: titleStyle,
        ),
        Text(
          pins.length.toString() + ' pins',
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: subtitleStyle,
        ),
      ],
    );
  }
}
