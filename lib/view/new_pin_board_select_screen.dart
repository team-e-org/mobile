import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/new_pin_board_select_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/view/components/notification.dart';
import 'package:mobile/view/pages/board_select_page.dart';

class NewPinBoardSelectScreenArguments {
  NewPinBoardSelectScreenArguments({
    this.file,
    this.newPin,
  });

  final File file;
  final NewPin newPin;
}

class NewPinBoardSelectScreen extends StatelessWidget {
  NewPinBoardSelectScreen({this.args});

  final NewPinBoardSelectScreenArguments args;

  PinsRepository pinsRepository;
  AccountRepository accountRepository;
  UsersRepository usersRepository;
  BoardsRepository boardsRepository;

  NewPinBoardSelectScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    accountRepository = RepositoryProvider.of(context);
    usersRepository = RepositoryProvider.of(context);
    boardsRepository = RepositoryProvider.of(context);
    pinsRepository = RepositoryProvider.of(context);

    return BlocProvider(
      create: (context) => NewPinBoardSelectScreenBloc(
        accountRepository: accountRepository,
        usersRepository: usersRepository,
        boardsRepository: boardsRepository,
        pinsRepository: pinsRepository,
      )..add(const LoadBoardList()),
      child: BlocConsumer<NewPinBoardSelectScreenBloc,
          NewPinBoardSelectScreenState>(
        listener: (context, state) {
          if (state is CreatePinErrorState) {
            PinterestNotification.showError(
                title: 'ピンの作成に失敗しました', subtitle: '時間を置いて再度お試しください');
          } else if (state is CreatePinFinished) {
            PinterestNotification.show(title: 'ピンを作成しました');
            Navigator.of(context).pop();
          }
        },
        builder: _contentBuilder,
      ),
    );
  }

  Widget _contentBuilder(
      BuildContext context, NewPinBoardSelectScreenState state) {
    bloc = BlocProvider.of<NewPinBoardSelectScreenBloc>(context);
    return BoardSelectPage(
      boards: state.boards,
      isLoading: state is LoadBoardListWaiting,
      boardPinMap: state.boardPinMap,
      onSelected: _onSelected,
      isError: state is LoadBoardListErrorState,
      onReload: () {
        bloc.add(const RefreshBoardList());
      },
      onRefresh: () async {
        bloc.add(const RefreshBoardList());
      },
      enableAddBoard: true,
    );
  }

  void _onSelected(BuildContext context, Board board) {
    bloc.add(
        CreatePin(newPin: args.newPin, imageFile: args.file, board: board));
  }
}
