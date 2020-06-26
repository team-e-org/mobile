import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/new_board_sreen_bloc.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/repository/boards_repository.dart';
import 'package:mobile/view/components/notification.dart';
import 'package:mobile/view/pages/board_edit_page.dart';

class NewBoardScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewBoardScreenBloc>(
      create: (context) => NewBoardScreenBloc(
        boardRepo: RepositoryProvider.of<BoardsRepository>(context),
      ),
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return BlocConsumer<NewBoardScreenBloc, NewBoardScreenBlocState>(
        listener: (context, state) {
          if (state is BoardCreateSuccessState) {
            PinterestNotification.show(
              title: 'ボードを作成しました',
              subtitle: state.createdBoard.name,
            );
            Navigator.pop(context, state.createdBoard);
          }
          if (state is BoardCreateErrorState) {
            PinterestNotification.showError(
              title: 'ボードが作成できませんでした',
              subtitle: '時間を置いて再度お試しください',
            );
          }
        },
        builder: (context, state) => BoardEditPage(
              title: 'Create a new board',
              onSubmit: _onSubmit,
            ));
  }

  void _onSubmit(BuildContext context, NewBoard newBoard) {
    BlocProvider.of<NewBoardScreenBloc>(context)
        .add(CreateBoardRequest(newBoard: newBoard));
  }
}
