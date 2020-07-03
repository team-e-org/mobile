import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/board_detail_screen_bloc.dart';
import 'package:mobile/bloc/pins_bloc.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/pin_model.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/bottom_sheet_menu.dart';
import 'package:mobile/view/components/menu_button.dart';
import 'package:mobile/view/components/reloadable_pin_grid_view.dart';
import 'package:mobile/view/pin_delete_dialog.dart';
import 'package:mobile/view/pin_detail_screen.dart';
import 'package:mobile/view/pin_edit_screen.dart';

import 'components/components.dart';

class BoardDetailScreenArguments {
  BoardDetailScreenArguments({
    @required this.board,
  });

  final Board board;
}

class BoardDetailScreen extends StatelessWidget {
  BoardDetailScreen({this.args});

  final BoardDetailScreenArguments args;

  BoardDetailScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    final pinsRepository = RepositoryProvider.of<PinsRepository>(context);

    return BlocProvider(
      create: (context) => BoardDetailScreenBloc(pinsRepository, args.board)
        ..add(PinsBlocEvent.loadNext),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.board.name),
      ),
      body: SafeArea(
        child: BlocBuilder<BoardDetailScreenBloc, PinsBlocState>(
          builder: _contentBuilder,
        ),
      ),
    );
  }

  Widget _contentBuilder(BuildContext context, PinsBlocState state) {
    bloc = BlocProvider.of<BoardDetailScreenBloc>(context);

    return ReloadablePinGridView(
      isLoading: state is Loading,
      itemCount: state.pins.length,
      itemBuilder: (context, index) {
        return PinCard(
          board: args.board,
          pin: state.pins[index],
          onTap: () => _onPinTap(context, args.board, state.pins[index]),
          menuButton: _menuButton(context, state.pins[index]),
        );
      },
      onScrollOut: () => bloc.add(PinsBlocEvent.loadNext),
      enableScrollOut: !state.isEndOfPins,
      isError: state is ErrorState,
      onReload: () => bloc.add(PinsBlocEvent.loadNext),
      onRefresh: () async => bloc.add(PinsBlocEvent.refresh),
    );
  }

  void _onPinTap(BuildContext context, Board board, Pin pin) async {
    if (pin == null) {
      return;
    }

    final isSaved = await Navigator.of(context).pushNamed(
      Routes.pinDetail,
      arguments: PinDetailScreenArguments(
        board: board,
        pin: pin,
      ),
    ) as bool;
    if (isSaved) {
      bloc.add(PinsBlocEvent.refresh);
    }
  }

  MenuButton _menuButton(BuildContext context, Pin pin) {
    final userId =
        RepositoryProvider.of<AccountRepository>(context).getPersistUserId();

    return MenuButton(
      items: [
        pin.userId == userId
            ? BottomSheetMenuItem(
                title: const Text('ピンの編集'),
                onTap: () async {
                  await Navigator.of(context).pushNamed(
                    Routes.pinEdit,
                    arguments: PinEditScreenArguments(pin: pin),
                  );
                  Navigator.of(context).pop();
                  bloc.add(PinsBlocEvent.refresh);
                },
              )
            : null,
        BottomSheetMenuItem(
            title: const Text('ピンをボードから削除する'),
            onTap: () async {
              await PinDeleteDialog.show(
                  context: context, board: args.board, pin: pin);
              Navigator.of(context).pop();
              bloc.add(PinsBlocEvent.refresh);
            }),
      ]..removeWhere((e) => e == null),
    );
  }
}
