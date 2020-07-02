import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/account_screen_bloc.dart';
import 'package:mobile/view/create_new_screen.dart';

class CreateNewButton extends StatelessWidget {
  CreateNewButton({this.callback});

  void Function(BuildContext context) callback;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        await CreateNewMenu.show(context: context);
        callback(context);
      },
    );
  }
}
