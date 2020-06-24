import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/util/validator.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/textfield_common.dart';

typedef PinEditScreenCallback = void Function(BuildContext, NewPin);

class PinEditScreenArguments {
  PinEditScreenArguments({this.file, this.onNextPressed});

  File file;
  PinEditScreenCallback onNextPressed;
}

class PinEditScreen extends StatefulWidget {
  const PinEditScreen({this.args});

  final PinEditScreenArguments args;

  @override
  _PinEditScreenState createState() => _PinEditScreenState();
}

class PinFormData {
  PinFormData({
    this.title = '',
    this.description = '',
    this.url = '',
    this.isPrivate = false,
  });

  String image;
  String title;
  String description;
  String url;
  bool isPrivate;

  NewPin toNewPin() {
    return NewPin(
      title: title,
      description: description,
      url: url,
      isPrivate: isPrivate,
    );
  }
}

class _PinEditScreenState extends State<PinEditScreen> {
  final PinFormData _formdata = PinFormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create pin'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: Image.file(
                    widget.args.file,
                    fit: BoxFit.contain,
                  ),
                ),
                const Divider(),
                _formField(_formdata),
                PinterestButton.primary(
                    text: 'Next',
                    onPressed: () => widget.args
                        .onNextPressed(context, _formdata.toNewPin())),
              ],
            ),
          ),
        ));
  }

  Widget _formField(PinFormData formData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                        _formdata.title = value;
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
                  _formdata.description = value;
                })
              },
            ),
          ),
          PinterestTextField(
            props: PinterestTextFieldProps(
                label: 'URL',
                hintText: 'ここにURLを書く',
                validator: Validator.isValidPinUrl,
                maxLengthEnforced: false,
                onChanged: (value) => {
                      setState(() {
                        _formdata.url = value;
                      })
                    }),
          ),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Private'),
                Container(
                  child: Switch(
                    value: _formdata.isPrivate,
                    onChanged: (value) {
                      setState(() {
                        _formdata.isPrivate = value;
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
