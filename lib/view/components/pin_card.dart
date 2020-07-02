import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:mobile/view/components/option_menu.dart';
import 'package:mobile/view/pin_delete_dialog.dart';
import 'package:mobile/view/pin_edit_screen.dart';

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
    return CachedNetworkImage(
      imageUrl: pin.imageUrl,
      placeholder: (context, url) {
        return _placeholder(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]),
          ),
        );
      },
      errorWidget: (context, url, dynamic error) {
        Logger().e(error);
        return _placeholder(
            child: const Icon(
          Icons.error_outline,
          color: Colors.black,
        ));
      },
    );
  }

  Widget _placeholder({Widget child}) {
    return Container(
      height: 200,
      color: Colors.grey[100],
      child: Center(child: child),
    );
  }

  Widget _pinInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(child: _pinTitle()),
          _MenuButton(menuItems: _menuItems(context)),
        ],
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

  List<BottomSheetMenuItem> _menuItems(BuildContext context) {
    final userId =
        RepositoryProvider.of<AccountRepository>(context).getPersistUserId();
    return [
      pin.userId == userId
          ? BottomSheetMenuItem(
              title: const Text('ピンの編集'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.pinEdit,
                  arguments: PinEditScreenArguments(pin: pin),
                );
              },
            )
          : null,
      BottomSheetMenuItem(
          title: const Text('ピンの削除'),
          onTap: () async {
            await PinDeleteDialog().show(context: context, pin: pin);
          }),
    ]..remove(null);
  }
}

class _MenuButton extends StatelessWidget {
  _MenuButton({this.menuItems});
  final List<BottomSheetMenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    if (menuItems.isEmpty) {
      return Container();
    }

    return Container(
      width: 16,
      height: 16,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(
          Icons.more_horiz,
          size: 16,
        ),
        onPressed: () {
          BottomSheetMenu.show(context: context, children: menuItems);
        },
        iconSize: 16,
      ),
    );
  }
}
