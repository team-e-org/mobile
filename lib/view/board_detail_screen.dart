import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/board_detail_screen_bloc.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/pin_model.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/reloadable_pin_grid_view.dart';
import 'package:mobile/view/pin_detail_screen.dart';

class BoardDetailScreenArguments {
  BoardDetailScreenArguments({
    @required this.board,
  });

  final Board board;
}

class BoardDetailScreen extends StatelessWidget {
  const BoardDetailScreen({this.args});

  final BoardDetailScreenArguments args;

  @override
  Widget build(BuildContext context) {
    final pinsRepository = RepositoryProvider.of<PinsRepository>(context);

    return BlocProvider(
      create: (context) => BoardDetailScreenBloc(
          pinsRepository: pinsRepository, board: args.board),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.board.name),
      ),
      body: SafeArea(
        child: BlocBuilder<BoardDetailScreenBloc, BoardDetailScreenState>(
          builder: _contentBuilder,
        ),
      ),
    );
  }

  Widget _contentBuilder(BuildContext context, BoardDetailScreenState state) {
    final blocProvider = BlocProvider.of<BoardDetailScreenBloc>(context);

    if (state is InitialState) {
      blocProvider.add(LoadPinsPage());
    }

    return ReloadablePinGridView(
      isLoading: state is Loading,
      pins: state.pins,
      onPinTap: _onPinTap,
      onScrollOut: () => {blocProvider.add(LoadPinsPage())},
      isError: state is ErrorState,
      onReload: () => {blocProvider.add(LoadPinsPage())},
    );
  }

  void _onPinTap(BuildContext context, Pin pin) {
    if (pin == null) {
      return;
    }

    Navigator.of(context).pushNamed(
      Routes.pinDetail,
      arguments: PinDetailScreenArguments(pin: pin),
    );
  }
}
