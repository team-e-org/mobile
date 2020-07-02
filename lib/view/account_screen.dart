import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/account_screen_bloc.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/board_detail_screen.dart';
import 'package:mobile/view/board_edit_screen.dart';
import 'package:mobile/view/components/board_grid_view.dart';
import 'package:mobile/view/components/bottom_sheet_menu.dart';
import 'package:mobile/view/components/menu_button.dart';
import 'package:mobile/view/components/reloadable_board_grid_view.dart';
import 'package:mobile/view/components/user_icon.dart';
import 'package:mobile/view/create_new_button.dart';
import 'package:mobile/view/onboarding/authentication_bloc.dart';

import 'components/components.dart';

class _Choices {
  static const logout = 'Logout';
}

class AccountScreen extends StatelessWidget {
  AccountRepository accountRepository;
  UsersRepository usersRepository;
  BoardsRepository boardsRepository;

  AuthenticationBloc authBloc;
  AccountScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    accountRepository = RepositoryProvider.of(context);
    usersRepository = RepositoryProvider.of(context);
    boardsRepository = RepositoryProvider.of(context);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, stateAuth) {
        authBloc = BlocProvider.of(context);
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
            floatingActionButton: CreateNewButton(
              callback: (context) {
                BlocProvider.of<AccountScreenBloc>(context)
                    .add(const Refresh());
              },
            ),
          ),
        );
      },
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
              authBloc.add(LoggedOut());
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
        bloc = BlocProvider.of(context);
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
                itemCount: state.boards.length,
                itemBuilder: (context, index) {
                  return BoardCardProps(
                    board: state.boards[index],
                    pins: state.boardPinMap[state.boards[index].id],
                    onTap: () => _onBoardTap(context, state.boards[index]),
                    menuButton: _menuButton(context, state.boards[index]),
                  );
                },
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

  MenuButton _menuButton(BuildContext context, Board board) {
    return MenuButton(
      items: [
        BottomSheetMenuItem(
          title: const Text('ボードの編集'),
          onTap: () async {
            await Navigator.of(context).pushNamed(
              Routes.boardEdit,
              arguments: BoardEditScreenArguments(board: board),
            );

            Navigator.of(context).pop();
            bloc.add(const Refresh());
          },
        )
      ]..removeWhere((e) => e == null),
    );
  }
}
