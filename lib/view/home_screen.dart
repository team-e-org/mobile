import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/api/pins_api.dart';
import 'package:mobile/bloc/home_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
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
    const _endpoint = 'http://localhost:3100';
    final _client = ApiClient(Client(), apiEndpoint: _endpoint);
    final _api = DefaultPinsApi(_client);
    final _repository = DefaultPinsRepository(_api);

    return BlocProvider(
      create: (context) => HomeScreenBloc(_repository),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          final blocProvider = BlocProvider.of<HomeScreenBloc>(context);
          if (state is InitialState) {
            blocProvider.add(LoadPinsPage());
          }

          final controller = ScrollController();
          controller.addListener(() {
            if (controller.position.maxScrollExtent <=
                controller.position.pixels) {
              blocProvider.add(LoadPinsPage());
            }
          });

          return Container(
            child: PinGridView(
              pins: state.pins,
              onTap: _onPinTap,
              controller: controller,
            ),
          );
        },
      ),
    );
  }

  void _onPinTap(BuildContext context, Pin pin) {
    if (pin == null) {
      return;
    }

    Navigator.of(context).pushNamed(
      '/pin/detail',
      arguments: PinDetailScreenArguments(pin: pin),
    );
  }
}
