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

  String title;
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
        body: SingleChildScrollView(
          child: Container(
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
                    Navigator.pushNamed(
                        context, Routes.createNewPinSelectPhoto);
                  },
                )
              ],
            ),
          ),
        ));
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
                maxLength: 30,
                maxLengthEnforced: false,
                onChanged: (value) => {
                      setState(() {
                        formdata.title = value;
                      })
                    }),
          ),
          PinterestTextField(
            props: PinterestTextFieldProps(
              label: 'Description',
              hintText: 'ここに説明を書く',
              validator: Validator.isValidPinDescription,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 8,
              maxLength: 280,
              maxLengthEnforced: false,
              onChanged: (value) => {
                setState(() {
                  formdata.description = value;
                })
              },
            ),
          ),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: const Text('Private'),
                ),
                Expanded(
                  child: Switch(
                    value: formdata.isPrivate,
                    onChanged: (value) {
                      formdata.isPrivate = value;
                    },
                  ),
                ),
              ],
            ),
          )
          //             Row(
          //   children: <Widget>[
          //     Text('Private board'),
          //     Spacer(),
          //     Switch(
          //       value: formdata.isPrivate,
          //       onChanged: (value) {
          //         formdata.isPrivate = value;
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
