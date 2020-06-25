import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/home_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/components.dart';
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
      create: (context) => HomeScreenBloc(pinsRepository)..add(LoadPinsPage()),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: _contentBuilder,
      ),
    );
  }

  Widget _contentBuilder(BuildContext context, HomeScreenState state) {
    final blocProvider = BlocProvider.of<HomeScreenBloc>(context);

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
