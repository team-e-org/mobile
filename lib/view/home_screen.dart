import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/home_screen_bloc.dart';
import 'package:mobile/view/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenBloc(),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          print(state);
          final blocProvider = BlocProvider.of<HomeScreenBloc>(context);
          if (state is InitialState) {
            blocProvider.add(const LoadPinsPage(page: 1));
          }

          return Container(
            child: PinGridView(pins: state.pins),
          );
        },
      ),
    );
  }
}
