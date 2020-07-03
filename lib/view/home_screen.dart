import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/home_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/reloadable_pin_grid_view.dart';

import 'components/components.dart';
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
      create: (context) => HomeScreenBloc(pinsRepository: pinsRepository)
        ..add(HomeScreenEvent.loadNext),
      child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {},
        builder: _contentBuilder,
      ),
    );
  }

  Widget _contentBuilder(BuildContext context, HomeScreenState state) {
    final bloc = BlocProvider.of<HomeScreenBloc>(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: ReloadablePinGridView(
          isLoading: state is Loading,
          itemCount: state.pins.length,
          itemBuilder: (context, index) {
            return PinCard(
              pin: state.pins[index],
              onTap: () => _onPinTap(context, state.pins[index]),
            );
          },
          onScrollOut: () => bloc.add(HomeScreenEvent.loadNext),
          enableScrollOut: !state.isEndOfPins,
          isError: state is ErrorState,
          onReload: () => bloc.add(HomeScreenEvent.loadNext),
          onRefresh: () async => bloc.add(HomeScreenEvent.refresh),
        ),
      ),
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
