import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/new_board_sreen_bloc.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/textfield_common.dart';

class NewBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewBoardScreenBloc>(
      create: (context) => NewBoardScreenBloc(),
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return BlocBuilder<NewBoardScreenBloc, NewBoardScreenBlocState>(
      builder: (context, state) => Scaffold(
        appBar: _buildAppBar(context, state),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              _buildBoardNameTextField(context),
              SizedBox(height: 20),
              _buildPrivateBoardSwitch(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, NewBoardScreenBlocState state) {
    return AppBar(
      title: const Text(
        'Create a new board',
      ),
      leading: Container(
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: PinterestButton.primary(
            text: 'Create',
            onPressed: state.boardName.isEmpty
                ? null
                : () => _onCreateButtonPressed(context),
          ),
        ),
      ],
    );
  }

  Widget _buildBoardNameTextField(BuildContext context) {
    return PinterestTextField(
      props: PinterestTextFieldProps(
          label: 'Board name',
          hintText: 'Add',
          onChanged: (value) {
            BlocProvider.of<NewBoardScreenBloc>(context)
                .add(BoardNameChanged(value: value));
          }),
    );
  }

  Widget _buildPrivateBoardSwitch(BuildContext context) {
    final bloc = BlocProvider.of<NewBoardScreenBloc>(context);
    return Row(
      children: <Widget>[
        Text('Private board'),
        Spacer(),
        Switch(
          value: bloc.state.isPrivate,
          onChanged: (value) {
            bloc.add(IsPrivateChanged());
          },
        ),
      ],
    );
  }

  void _onCreateButtonPressed(BuildContext context) {
    BlocProvider.of<NewBoardScreenBloc>(context).add(CreateBoardRequested());
  }
}
