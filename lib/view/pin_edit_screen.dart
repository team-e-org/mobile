import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/pin_edit_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/notification.dart';
import 'package:mobile/view/pages/pin_edit_page.dart';
import 'package:mobile/view/select_board_screen.dart';

class PinEditScreenArguments {
  PinEditScreenArguments({this.pin});

  Pin pin;
}

class PinEditScreen extends StatelessWidget {
  PinEditScreen({this.args});

  PinEditScreenArguments args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PinEditScreenBloc(),
      child: BlocConsumer<PinEditScreenBloc, PinEditScreenState>(
        listener: (context, state) {
          if (state is UpdatePinFinished) {
            Navigator.of(context).pop();
          } else if (state is UpdatePinErrorState) {
            PinterestNotification.showError(
              title: 'ピンの更新に失敗しました',
              subtitle: '時間を置いてから再度試してください',
            );
          }
        },
        builder: _contentBuilder,
      ),
    );
  }

  Widget _contentBuilder(BuildContext context, PinEditScreenState state) {
    final bloc = BlocProvider.of<PinEditScreenBloc>(context);
    return PinEditPage(
      image: NetworkImage(args.pin.imageUrl),
      pin: args.pin,
      submitButtonTitle: 'Update',
      isSubmitButtonLoading: state is UpdatePinWaiting,
      onSubmit: (context, state) {
        bloc.add(UpdatePin());
      },
    );
  }
}
