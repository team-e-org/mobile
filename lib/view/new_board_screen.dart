import 'package:flutter/material.dart';
import 'package:mobile/view/mock/mock_screen_common.dart';

class NewBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            _buildBoardNameTextField(context),
            SizedBox(height: 20),
            _buildPrivateBoardSwitch(context),
          ],
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
        // TODO 変更を通知する
      },
    );
  }

  Widget _buildPrivateBoardSwitch(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('Private board'),
        Spacer(),
        Switch(
          value: false, // TODO
          onChanged: (value) {
            // TODO
          },
        ),
      ],
    );
  }
}
