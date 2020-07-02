import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/boards_bloc.dart';
import 'package:mobile/bloc/pin_save_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/view/components/notification.dart';
import 'package:mobile/view/pages/board_select_page.dart';

class PinSaveScreenArguments {
  PinSaveScreenArguments({this.pin});

  final Pin pin;
}

class PinSaveScreen extends StatelessWidget {
  PinSaveScreen({this.args});

  PinSaveScreenArguments args;

  PinSaveBloc pinSaveBloc;
  BoardsBloc boardsBloc;

  AccountRepository accountRepository;
  UsersRepository usersRepository;
  BoardsRepository boardsRepository;
  PinsRepository pinsRepository;

  @override
  Widget build(BuildContext context) {
    accountRepository = RepositoryProvider.of(context);
    usersRepository = RepositoryProvider.of(context);
    boardsRepository = RepositoryProvider.of(context);
    pinsRepository = RepositoryProvider.of(context);

    return BlocProvider(
      create: (context) => PinSaveBloc(pinsRepository: pinsRepository),
      child: BlocConsumer<PinSaveBloc, PinSaveState>(
        listener: (context, pinSaveState) {
          if (pinSaveState is SavePinFinished) {
            PinterestNotification.show(title: 'ピンを保存しました');
            Navigator.of(context).pop();
          } else if (pinSaveState is SavePinErrorState) {
            PinterestNotification.showError(title: 'ピンの保存に失敗しました');
          }
        },
        builder: (context, pinSaveState) {
          return BlocProvider(
            create: (context) => BoardsBloc(
              accountRepository: accountRepository,
              usersRepository: usersRepository,
              boardsRepository: boardsRepository,
            )..add(const LoadBoardList()),
            child: BlocConsumer<BoardsBloc, BoardsBlocState>(
              listener: (context, boardsBlocSate) {},
              builder: (context, boardsBlocState) {
                pinSaveBloc = BlocProvider.of<PinSaveBloc>(context);
                boardsBloc = BlocProvider.of<BoardsBloc>(context);

                return _contentBuilder(context, pinSaveState, boardsBlocState);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _contentBuilder(
    BuildContext context,
    PinSaveState pinSaveState,
    BoardsBlocState boardsBlocState,
  ) {
    return BoardSelectPage(
      boards: boardsBlocState.boards,
      isLoading: boardsBlocState is LoadBoardListWaiting,
      boardPinMap: boardsBlocState.boardPinMap,
      onSelected: _onSelected,
      isError: boardsBlocState is LoadBoardListErrorState,
      onReload: () {
        boardsBloc.add(const RefreshBoardList());
      },
      onRefresh: () async {
        boardsBloc.add(const RefreshBoardList());
      },
      enableAddBoard: true,
    );
  }

  void _onSelected(BuildContext context, Board board) {
    pinSaveBloc.add(SavePin(boardId: board.id, pinId: args.pin.id));
  }
}
