import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/api/boards_api.dart';
import 'package:mobile/api/users_api.dart';
import 'package:mobile/bloc/account_screen_bloc.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/components.dart';
import 'package:mobile/view/onboarding/authentication_bloc.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen() {
    const endpoint = 'http://localhost:3100';
    apiClient = ApiClient(Client(), apiEndpoint: endpoint);

    usersApi = DefaultUsersApi(apiClient);
    usersRepository = UsersRepository(usersApi);
    boardsApi = DefaultBoardsApi(apiClient);
    boardsRepository = BoardsRepository(boardsApi);
  }
  final String endpoint = 'http://localhost:3100';
  ApiClient apiClient;
  UsersApi usersApi;
  UsersRepository usersRepository;
  BoardsApi boardsApi;
  BoardsRepository boardsRepository;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, stateAuth) {
        return Scaffold(
          body: SafeArea(
            child: BlocProvider(
              create: (context) => AccountScreenBloc(
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

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<AccountScreenBloc, AccountScreenState>(
      builder: (context, state) {
        final authBlocProvider = BlocProvider.of<AuthenticationBloc>(context);
        final blocProvider = BlocProvider.of<AccountScreenBloc>(context);

        if (blocProvider.state is InitialState) {
          blocProvider.add(const LoadInitial(111));
        }

        return _boardsGridView(context, state.boards, state.boardPinMap);
      },
    );
  }

  Widget _accountContainer() {
    return Container();
  }

  Widget _boardsGridView(
    BuildContext context,
    List<Board> boards,
    Map<int, List<Pin>> boardPinMap,
  ) {
    if (boards.isNotEmpty) {
      return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(2),
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        staggeredTileBuilder: (index) {
          return const StaggeredTile.fit(2);
        },
        itemCount: boards.length,
        itemBuilder: (context, index) {
          final board = boards[index];
          final pins = boardPinMap[board.id];
          return BoardCard(
            board: board,
            pins: pins,
            onTap: () => _onBoardTap(context, board),
            margin: const EdgeInsets.all(4),
          );
        },
      );
    } else {
      return Container(
        child: const Center(
          child: Text('ボードがありませんでした'),
        ),
      );
    }
  }

  void _onBoardTap(BuildContext context, Board board) {
    if (board == null) {
      return;
    }
    // TODO(dh9489): 画面遷移
  }
}
