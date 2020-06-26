import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/util/validator.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/textfield_common.dart';

typedef BoardEditPageCallback = void Function(
    BuildContext context, NewBoard newBoard);

class BoardEditPage extends StatefulWidget {
  const BoardEditPage({
    this.title = '',
    this.name,
    this.isPrivate,
    this.onSubmit,
  });

  final String title;
  final String name;
  final bool isPrivate;
  final BoardEditPageCallback onSubmit;

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
}

class _BoardEditPageState extends State<BoardEditPage> {
  BoardFormData _formData;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      _formData = BoardFormData(
        name: widget.name,
        isPrivate: widget.isPrivate,
      );
    } else {
      _formData = BoardFormData(
        name: '',
        isPrivate: false,
      );
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
                text: 'Create',
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
      // leading: Container(
      //   child: IconButton(
      //     icon: Icon(Icons.close),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),
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
        Text('Private board'),
        Spacer(),
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
      final newBoard = _formData.toNewBoard();
      widget.onSubmit(context, newBoard);
    }
  }

  String _boardNameValidator(String value) {
    if (!Validator.isValidBoardName(value)) {
      return 'Invalid board name';
    }
    return null;
  }
}
