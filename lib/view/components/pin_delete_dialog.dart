import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/pin_delete_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/notification.dart';

class PinDeleteDialog {
  static Future show({BuildContext context, Pin pin}) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => PinDeleteBloc(),
          child: BlocConsumer<PinDeleteBloc, PinDeleteState>(
            listener: (context, state) {
              if (state is DeletePinFinished) {
                PinterestNotification.show(title: 'ピンを削除しました');
                Navigator.of(context).pop();
              } else if (state is ErrorState) {
                PinterestNotification.showError(title: 'ピンを削除できませんでした');
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              final bloc = BlocProvider.of<PinDeleteBloc>(context);
              return AlertDialog(
                content: const Text('ピンを削除しますか？'),
                actions: [
                  FlatButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: const Text('Confirm'),
                    onPressed: () {
                      bloc.add(DeletePin(pin: pin));
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
