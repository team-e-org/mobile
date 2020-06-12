import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/new_board_sreen_bloc.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

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
        appBar: AppBar(
          title: Text(
            'Create a new board',
          ),
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('Create'),
              onPressed: state.boardName.isEmpty
                  ? null
                  : () => _onCreateButtonPressed(context),
            )
          ],
        ),
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

  Widget _buildBoardNameTextField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Board name',
        hintText: 'Type something...',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        BlocProvider.of<NewBoardScreenBloc>(context)
            .add(BoardNameChanged(value: value));
      },
    );
  }

  Widget _buildPrivateBoardSwitch(BuildContext context) {
    final bloc = BlocProvider.of<NewBoardScreenBloc>(context);
    return Row(
      children: <Widget>[
        Text('Private board'),
        Spacer(),
        Switch(
          value: bloc.state.isPrivate, // TODO
          onChanged: (value) {
            bloc.add(IsPrivateChanged());
          },
        ),
      ],
    );
  }

  void _onCreateButtonPressed(BuildContext context) {
    final bloc = BlocProvider.of<NewBoardScreenBloc>(context);
    bloc.add(CreateBoardRequested());
  }
}
