import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/util/validator.dart';
import 'package:mobile/view/components/common/textfield_common.dart';

class PinEditScreenArguments {
  PinEditScreenArguments({this.file});

  File file;
}

class PinEditScreen extends StatefulWidget {
  const PinEditScreen({this.args});

  final PinEditScreenArguments args;

  @override
  _PinEditScreenState createState() => _PinEditScreenState();
}

class PinFormData {
  PinFormData();

  String name;
  String description;
  String url;
  bool isPrivate;
}

class _PinEditScreenState extends State<PinEditScreen> {
  final formdata = PinFormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create pin'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Image.file(
                widget.args.file,
                fit: BoxFit.contain,
              ),
            ),
            Divider(),
            _formField(formdata),
            RaisedButton(
              child: Text('Next'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.createNewPinSelectPhoto);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _formField(PinFormData formData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          PinterestTextField(
            props: PinterestTextFieldProps(
              label: 'Title',
              hintText: 'ここにタイトルを書く',
              validator: Validator.isValidPinTitle,
            ),
          ),
          PinterestTextField(
              props: PinterestTextFieldProps(
            label: 'Description',
            hintText: 'ここに説明を書く',
            validator: Validator.isValidPinDescription,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 8,
          )),
        ],
      ),
    );
  }
}
