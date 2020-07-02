import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/board_edit_screen.dart';
import 'package:mobile/view/components/components.dart';
import 'package:mobile/view/components/bottom_sheet_menu.dart';
import 'package:mobile/view/components/menu_button.dart';

class BoardCardLarge extends BoardCardBase {
  BoardCardLarge({
    @required this.props,
    this.margin,
  }) : super(
          props: props,
          margin: margin,
          titleStyle: const TextStyle(fontSize: 16),
          subtitleStyle: const TextStyle(fontSize: 12),
        );

  final BoardCardProps props;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: props.onTap,
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
              child: _infoContainer(context),
            ),
          ],
        ),
      ),
    );
  }
}

class BoardCardCompact extends BoardCardBase {
  BoardCardCompact({
    @required this.props,
    this.margin,
  }) : super(
          props: props,
          margin: margin,
          titleStyle: const TextStyle(fontSize: 12),
          subtitleStyle: const TextStyle(fontSize: 8),
        );

  final BoardCardProps props;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: props.onTap,
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
              child: _infoContainer(context),
            ),
          ],
        ),
      ),
    );
  }
}

class BoardCardSlim extends BoardCardBase {
  BoardCardSlim({
    @required this.props,
    this.margin,
  }) : super(
          margin: margin,
          titleStyle: const TextStyle(fontSize: 14),
          subtitleStyle: const TextStyle(fontSize: 12),
        );

  final BoardCardProps props;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: props.onTap,
      child: Container(
        color: ThemeData().scaffoldBackgroundColor,
        margin: margin,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _imageContainer(),
            const SizedBox(width: 10),
            Expanded(
              child: _infoContainer(context, showMenu: false),
            )
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
  BoardCardBase({
    @required this.props,
    this.margin,
    this.titleStyle = _titleStyle,
    this.subtitleStyle = _subtitleStyle,
  });

  BoardCardProps props;
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
    if (props.pins.isEmpty) {
      return Container(
        color: Colors.grey,
        child: const Center(child: Icon(Icons.photo_library)),
      );
    }

    return CachedNetworkImage(
      imageUrl: props.pins[0].imageUrl,
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
    if (props.pins.isEmpty) {
      return Container(
        color: Colors.grey,
        child: const Center(child: Icon(Icons.photo_library)),
      );
    }

    return Container(
      color: Colors.grey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: props.pins[0].imageUrl,
            ),
          ),
          props.pins.length > 1
              ? Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: props.pins[1].imageUrl,
                          ),
                        ),
                        props.pins.length > 2
                            ? Expanded(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: props.pins[2].imageUrl,
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  static const TextStyle _titleStyle = TextStyle(fontSize: 16);
  static const TextStyle _subtitleStyle = TextStyle(fontSize: 12);

  Widget _infoContainer(BuildContext context, {bool showMenu = true}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  props.board.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: titleStyle,
                ),
              ]..removeWhere((e) => e == null),
            ),
          ),
          props.menuButton,
        ]..removeWhere((e) => e == null),
      ),
    );
  }
}

class BoardCardProps {
  const BoardCardProps({
    @required this.board,
    this.pins = const [],
    this.onTap,
    this.menuButton,
  });

  final Board board;
  final List<Pin> pins;
  final VoidCallback onTap;
  final MenuButton menuButton;
}

class BoardCardStyle {}
