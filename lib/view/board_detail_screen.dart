import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/board_detail_screen_bloc.dart';
import 'package:mobile/bloc/pins_bloc.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/pin_model.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/reloadable_pin_grid_view.dart';
import 'package:mobile/view/pin_detail_screen.dart';

import 'components/components.dart';

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
    final bloc = BlocProvider.of<BoardDetailScreenBloc>(context);

    return ReloadablePinGridView(
      isLoading: state is Loading,
      itemCount: state.pins.length,
      itemBuilder: (context, index) {
        return PinCard(
          pin: state.pins[index],
          onTap: () => _onPinTap(context, state.pins[index]),
        );
      },
      onScrollOut: () => bloc.add(PinsBlocEvent.loadNext),
      enableScrollOut: !state.isEndOfPins,
      isError: state is ErrorState,
      onReload: () => bloc.add(PinsBlocEvent.loadNext),
      onRefresh: () async => bloc.add(PinsBlocEvent.refresh),
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
