import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/pin_delete_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/view/components/notification.dart';

class PinDeleteDialog {
  static Future show({BuildContext context, Board board, Pin pin}) {
    final pinsRepository = RepositoryProvider.of<PinsRepository>(context);
    return showDialog<void>(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => PinDeleteBloc(pinsRepository: pinsRepository),
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
              final pinDeleteBloc = BlocProvider.of<PinDeleteBloc>(context);
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
                      pinDeleteBloc.add(DeletePin(board: board, pin: pin));
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
