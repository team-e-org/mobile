import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/bloc/account_screen_bloc.dart';
import 'package:mobile/data/account_repository.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/board_grid_view.dart';
import 'package:mobile/view/components/components.dart';
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
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SafeArea(
            child: BlocProvider(
              create: (context) => AccountScreenBloc(
                accountRepository: accountRepository,
                usersRepository: usersRepository,
                boardsRepository: boardsRepository,
              ),
              child: _buildContent(context),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.createNew);
            },
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
        final authBlocProvider = BlocProvider.of<AuthenticationBloc>(context);
        final blocProvider = BlocProvider.of<AccountScreenBloc>(context);

        if (blocProvider.state is InitialState) {
          blocProvider.add(const LoadInitial());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: _accountContainer(context, state.user),
            ),
            Expanded(
              flex: 3,
              child: BoardGridView(
                boards: state.boards,
                boardPinMap: state.boardPinMap,
                layout: BoardGridViewLayout.compact,
                onTap: (context, board) {},
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
              margin: EdgeInsets.all(8),
            ),
            Text(
              user == null ? '' : user.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    // TODO(dh9489): 画面遷移
  }
}
