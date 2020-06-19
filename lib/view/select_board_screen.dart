import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/account_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/components.dart';

import 'components/board_grid_view.dart';
import 'onboarding/authentication_bloc.dart';

class SelectBoardScreenArguments {
  SelectBoardScreenArguments({
    this.newPin,
  });

  final NewPin newPin;
}

class SelectBoardScreen extends StatelessWidget {
  SelectBoardScreen({this.args});

  final SelectBoardScreenArguments args;

  UsersRepository usersRepository;
  BoardsRepository boardsRepository;

  @override
  Widget build(BuildContext context) {
    usersRepository = RepositoryProvider.of(context);
    boardsRepository = RepositoryProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select board'),
      ),
      body: Container(
        child: BlocProvider(
          create: (context) => AccountScreenBloc(
            usersRepository: usersRepository,
            boardsRepository: boardsRepository,
          ),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<AccountScreenBloc, AccountScreenState>(
      builder: (context, state) {
        final blocProvider = BlocProvider.of<AccountScreenBloc>(context);

        print(state);
        if (blocProvider.state is InitialState) {
          blocProvider.add(const LoadInitial(111));
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
                onTap: (context, board) {
                  Navigator.popUntil(context, ModalRoute.withName(Routes.root));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
