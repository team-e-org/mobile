import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:mobile/view/components/bottom_sheet_menu.dart';
import 'package:mobile/view/components/menu_button.dart';
import 'package:mobile/view/components/pin_image.dart';
import 'package:mobile/view/pin_delete_dialog.dart';
import 'package:mobile/view/pin_edit_screen.dart';

class PinCard extends StatelessWidget {
  const PinCard({
    this.board,
    @required this.pin,
    this.onTap,
    this.menuButton,
  });

  final Board board;
  final Pin pin;
  final VoidCallback onTap;
  final MenuButton menuButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _pinImageContainer(),
          const SizedBox(height: 4),
          _pinInfo(context),
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
    return PinImage(pin.imageUrl);
  }

  Widget _pinInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(child: _pinTitle()),
          menuButton,
        ]..removeWhere((e) => e == null),
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
