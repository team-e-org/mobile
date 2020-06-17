import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/home_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/components.dart';

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
      create: (context) => HomeScreenBloc(pinsRepository),
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

    final controller = ScrollController();
    controller.addListener(() {
      if (controller.position.maxScrollExtent <= controller.position.pixels) {
        blocProvider.add(LoadPinsPage());
      }
    });

    return Container(
      padding: const EdgeInsets.all(8),
      child: PinGridView(
        pins: state.pins,
        onTap: _onPinTap,
        controller: controller,
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
