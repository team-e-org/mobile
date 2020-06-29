import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/select_board_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/components.dart';
import 'package:mobile/view/components/reloadable_board_grid_view.dart';
import 'package:mobile/view/components/notification.dart';
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
          )..add(const LoadInitial()),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<SelectBoardScreenBloc, SelectBoardScreenState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<SelectBoardScreenBloc>(context);
        return Column(
          children: [
            _AddBoardCard(),
            Expanded(
              child: ReloadableBoardGridView(
                layout: BoardGridViewLayout.slim,
                isLoading: state is Loading,
                boards: state.boards,
                boardPinMap: state.boardPinMap,
                onBoardTap: args.onBoardPressed,
                isError: state is ErrorState,
                onReload: () {
                  bloc.add(const Refresh());
                },
                onRefresh: () async {
                  bloc.add(const Refresh());
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AddBoardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SelectBoardScreenBloc>(context);

    return ActionCardSlim(
      text: 'Add Board',
      icon: Icon(Icons.add),
      onTap: () async {
        await Navigator.of(context).pushNamed(Routes.createNewBoard);
        bloc.add(const Refresh());
      },
    );
  }
}
