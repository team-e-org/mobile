import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/home_screen_bloc.dart';
import 'package:mobile/bloc/pins_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/reloadable_pin_grid_view.dart';

import 'pin_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currPage = 0;

  @override
  Widget build(BuildContext context) {
    final pinsRepository = RepositoryProvider.of<PinsRepository>(context);

    return BlocProvider(
      create: (context) =>
          HomeScreenBloc(pinsRepository)..add(PinsBlocEvent.loadNext),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeScreenBloc, PinsBlocState>(
        builder: _contentBuilder,
      ),
    );
  }

  Widget _contentBuilder(BuildContext context, PinsBlocState state) {
    final bloc = BlocProvider.of<HomeScreenBloc>(context);
    return ReloadablePinGridView(
      isLoading: state is Loading,
      pins: state.pins,
      onPinTap: _onPinTap,
      onScrollOut: () => {bloc.add(PinsBlocEvent.loadNext)},
      enableScrollOut: !state.isEndOfPins,
      isError: state is ErrorState,
      onReload: () => {bloc.add(PinsBlocEvent.loadNext)},
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
