import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/account_screen_bloc.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/board_detail_screen.dart';
import 'package:mobile/view/components/board_grid_view.dart';
import 'package:mobile/view/components/notification.dart';
import 'package:mobile/view/components/reloadable_board_grid_view.dart';
import 'package:mobile/view/components/user_icon.dart';
import 'package:mobile/view/onboarding/authentication_bloc.dart';

class _Choices {
  static const logout = 'Logout';
}

class AccountScreen extends StatelessWidget {
  AccountRepository accountRepository;
  UsersRepository usersRepository;
  BoardsRepository boardsRepository;

  @override
  Widget build(BuildContext context) {
    accountRepository = RepositoryProvider.of(context);
    usersRepository = RepositoryProvider.of(context);
    boardsRepository = RepositoryProvider.of(context);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, stateAuth) {
        return BlocProvider(
          create: (context) => AccountScreenBloc(
            accountRepository: accountRepository,
            usersRepository: usersRepository,
            boardsRepository: boardsRepository,
          )..add(const LoadInitial()),
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: SafeArea(
              child: _buildContent(context),
            ),
            floatingActionButton: _buildFAB(context),
          ),
        );
      },
    );
  }

  Widget _buildFAB(BuildContext context) {
    return BlocBuilder<AccountScreenBloc, AccountScreenState>(
      builder: (context, state) => FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result =
              await Navigator.of(context).pushNamed(Routes.createNew);
          if (result is Board) {
            PinterestNotification.show(
              title: 'New board created',
              subtitle: result.name,
            );
            BlocProvider.of<AccountScreenBloc>(context).add(Refresh());
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final choices = [_Choices.logout];

    return AppBar(
      title: const Text('Account'),
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (String choice) {
            if (choice == _Choices.logout) {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            }
          },
          itemBuilder: (BuildContext context) => choices
              .map((choice) => PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  ))
              .toList(),
        )
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<AccountScreenBloc, AccountScreenState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: _accountContainer(context, state.user),
            ),
            Expanded(
              flex: 3,
              child: ReloadableBoardGridView(
                layout: BoardGridViewLayout.large,
                isLoading: state is Loading,
                boards: state.boards,
                boardPinMap: state.boardPinMap,
                onBoardTap: _onBoardTap,
                isError: state is ErrorState,
                onReload: () {
                  BlocProvider.of<AccountScreenBloc>(context)
                      .add(const Refresh());
                },
                onRefresh: () async {
                  BlocProvider.of<AccountScreenBloc>(context)
                      .add(const Refresh());
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _accountContainer(BuildContext context, User user) {
    return Card(
      child: Container(
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserIcon(
              imageUrl: user == null ? '' : user.icon,
              radius: 32,
              margin: const EdgeInsets.all(8),
            ),
            Text(
              user == null ? '' : user.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _onBoardTap(BuildContext context, Board board) {
    if (board == null) {
      return;
    }
    Navigator.of(context).pushNamed(Routes.boardDetail,
        arguments: BoardDetailScreenArguments(board: board));
  }
}
