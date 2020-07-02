import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/board_detail_screen_bloc.dart';
import 'package:mobile/bloc/board_edit_bloc.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';
import 'package:mobile/view/pages/board_edit_page.dart';

class BoardEditScreenArguments {
  const BoardEditScreenArguments({this.board});

  final Board board;
}

class BoardEditScreen extends StatelessWidget {
  BoardEditScreen({this.args});

  BoardEditScreenArguments args;

  BoardEditScreenBloc _boardEditBloc;
  BoardsRepository _boardsRepository;

  @override
  Widget build(BuildContext context) {
    _boardsRepository = RepositoryProvider.of(context);
    return BlocProvider(
      create: (context) =>
          BoardEditScreenBloc(boardsRepository: _boardsRepository),
      child: BlocConsumer<BoardEditScreenBloc, BoardEditScreenState>(
        listener: (context, state) {},
        builder: _contentBuilder,
      ),
    );
  }

  Widget _contentBuilder(BuildContext context, BoardEditScreenState state) {
    _boardEditBloc = BlocProvider.of(context);
    return BoardEditPage(
      title: 'Edit Board',
      board: args.board,
      isSubmitButtonLoading: state is EditBoardWaiting,
      submitButtonTitle: 'Update',
      onSubmit: _onSubmit,
    );
  }

  void _onSubmit(BuildContext context, BoardFormData formdata) {
    final editBoard = formdata.toEditBoard();
    _boardEditBloc
        .add(RequestEditBoard(boardId: args.board.id, editBoard: editBoard));
  }
}
