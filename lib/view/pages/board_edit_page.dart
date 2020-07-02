import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/util/validator.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/textfield_common.dart';

class BoardEditPage extends StatefulWidget {
  const BoardEditPage({
    this.title,
    this.board,
    this.submitButtonTitle,
    this.isSubmitButtonLoading,
    this.onSubmit,
  });

  final String title;
  final Board board;
  final String submitButtonTitle;
  final bool isSubmitButtonLoading;
  final void Function(BuildContext context, BoardFormData formData) onSubmit;

  @override
  _BoardEditPageState createState() => _BoardEditPageState();
}

class BoardFormData {
  BoardFormData({
    this.name = '',
    this.isPrivate = false,
  });

  String name;
  bool isPrivate;

  NewBoard toNewBoard() {
    return NewBoard(
      name: name,
      isPrivate: isPrivate,
    );
  }

  EditBoard toEditBoard() {
    return EditBoard(
      name: name,
      isPrivate: isPrivate,
    );
  }
}

class _BoardEditPageState extends State<BoardEditPage> {
  BoardFormData _formData = BoardFormData();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.board != null) {
      setState(() {
        _formData
          ..name = widget.board.name
          ..isPrivate = widget.board.isPrivate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  _buildBoardNameTextField(context),
                  SizedBox(height: 20),
                  _buildPrivateBoardSwitch(context),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: PinterestButton.primary(
                text: widget.submitButtonTitle,
                loading: widget.isSubmitButtonLoading,
                onPressed: _formData.name.isEmpty
                    ? null
                    : () => _onCreateButtonPressed(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
    );
  }

  Widget _buildBoardNameTextField(BuildContext context) {
    return Form(
      key: _formKey,
      child: PinterestTextField(
        props: PinterestTextFieldProps(
            label: 'Board name',
            hintText: 'Add',
            validator: _boardNameValidator,
            initialValue: _formData.name,
            maxLength: 30,
            onChanged: (value) {
              setState(() {
                _formData.name = value;
              });
            }),
      ),
    );
  }

  Widget _buildPrivateBoardSwitch(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text('Private board'),
        const Spacer(),
        Switch(
          value: _formData.isPrivate,
          onChanged: (value) {
            _formData.isPrivate = value;
          },
        ),
      ],
    );
  }

  void _onCreateButtonPressed(BuildContext context) {
    if (_formKey.currentState.validate()) {
      widget.onSubmit(context, _formData);
    }
  }

  String _boardNameValidator(String value) {
    if (!Validator.isValidBoardName(value)) {
      return 'Invalid board name';
    }
    return null;
  }
}
