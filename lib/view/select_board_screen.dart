import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/select_board_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/view/pages/board_select_page.dart';

class SelectBoardScreenArguments {
  SelectBoardScreenArguments({
    this.file,
    this.newPin,
    this.onSelected,
  });

  final File file;
  final NewPin newPin;
  final Function(BuildContext context, Board board) onSelected;
}

class SelectBoardScreen extends StatelessWidget {
  SelectBoardScreen({this.args});

  final SelectBoardScreenArguments args;

  AccountRepository accountRepository;
  UsersRepository usersRepository;
  BoardsRepository boardsRepository;

  @override
  Widget build(BuildContext context) {
    accountRepository = RepositoryProvider.of(context);
    usersRepository = RepositoryProvider.of(context);
    boardsRepository = RepositoryProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select board'),
      ),
      body: Container(
        child: BlocProvider(
          create: (context) => SelectBoardScreenBloc(
            accountRepository: accountRepository,
            usersRepository: usersRepository,
            boardsRepository: boardsRepository,
          )..add(const LoadInitial()),
          child: BlocBuilder<SelectBoardScreenBloc, SelectBoardScreenState>(
            builder: _contentBuilder,
          ),
        ),
      ),
    );
  }

  Widget _contentBuilder(BuildContext context, SelectBoardScreenState state) {
    final bloc = BlocProvider.of<SelectBoardScreenBloc>(context);
    return BoardSelectPage(
      boards: state.boards,
      isLoading: state is Loading,
      boardPinMap: state.boardPinMap,
      onSelected: args.onSelected,
      isError: state is Error,
      onReload: () {
        bloc.add(const Refresh());
      },
      onRefresh: () async {
        bloc.add(const Refresh());
      },
      enableAddBoard: true,
    );
  }
}
