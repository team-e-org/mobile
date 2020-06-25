import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/select_board_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/view/components/components.dart';

import 'components/board_grid_view.dart';

typedef SelectBoardScreenCallback = void Function(BuildContext, Board);

class SelectBoardScreenArguments {
  SelectBoardScreenArguments({
    this.onBoardPressed,
  });

  final SelectBoardScreenCallback onBoardPressed;
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
          ),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<SelectBoardScreenBloc, SelectBoardScreenState>(
      builder: (context, state) {
        final blocProvider = BlocProvider.of<SelectBoardScreenBloc>(context);

        print(state);
        if (blocProvider.state is InitialState) {
          blocProvider.add(const LoadInitial());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              ActionCardSlim(
                text: "Add Board",
                icon: Icon(Icons.add),
              ),
              BoardGridView(
                boards: state.boards,
                boardPinMap: state.boardPinMap,
                layout: BoardGridViewLayout.slim,
                shrinkWrap: true,
                primary: true,
                physics: NeverScrollableScrollPhysics(),
                onTap: args.onBoardPressed,
              ),
            ],
          ),
        );
      },
    );
  }
}
