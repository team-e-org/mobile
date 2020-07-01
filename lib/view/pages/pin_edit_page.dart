import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/util/validator.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/textfield_common.dart';
import 'package:mobile/view/components/tag_input.dart';

class PinEditPage extends StatefulWidget {
  PinEditPage({
    @required this.image,
    this.pin,
    this.submitButtonTitle = 'Submit',
    this.isSubmitButtonLoading = false,
    @required this.onSubmit,
  }) : assert(image != null);

  final ImageProvider image;
  final String submitButtonTitle;
  final Pin pin;
  final bool isSubmitButtonLoading;
  final void Function(BuildContext, NewPin) onSubmit;

  @override
  _PinEditPageState createState() => _PinEditPageState();
}

class _PinEditPageState extends State<PinEditPage> {
  final _formdata = _PinFormData();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.pin != null) {
      print('acagd gaagjdna');
      setState(() {
        _formdata
          ..title = widget.pin.title
          ..description = widget.pin.description ?? ''
          ..url = widget.pin.url ?? ''
          ..tags = widget.pin.tags ?? []
          ..isPrivate = widget.pin.isPrivate ?? false;
      });
    }
  }

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
                  child: Image(
                    image: widget.image,
                  ),
                ),
                const Divider(),
                _formField(),
                PinterestButton.primary(
                    text: widget.submitButtonTitle,
                    loading: widget.isSubmitButtonLoading,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        widget.onSubmit(context, _formdata.toNewPin());
                      }
                    }),
              ],
            ),
          ),
        ));
  }

  Widget _formField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                PinterestTextField(
                  props: PinterestTextFieldProps(
                    label: 'Title',
                    hintText: 'ここにタイトルを書く',
                    initialValue: _formdata.title,
                    validator: _pinTitleValidator,
                    maxLength: 30,
                    maxLengthEnforced: false,
                    onChanged: (value) => {
                      setState(() {
                        _formdata.title = value;
                      })
                    },
                  ),
                ),
                PinterestTextField(
                  props: PinterestTextFieldProps(
                    label: 'Description',
                    hintText: 'ここに説明を書く',
                    initialValue: _formdata.description,
                    validator: _pinDescriptionValidator,
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
                    initialValue: _formdata.url,
                    validator: _pinUrlValidator,
                    maxLengthEnforced: false,
                    onChanged: (value) => {
                      setState(() {
                        _formdata.url = value;
                      })
                    },
                  ),
                ),
                TagInput(
                  label: 'Tags',
                  hintText: 'ここにタグを書く',
                  initialValue: _formdata.tags,
                  onChanged: (tags) {
                    setState(() {
                      _formdata.tags = tags;
                    });
                  },
                ),
              ],
            ),
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

  String _pinTitleValidator(String value) {
    if (!Validator.isValidPinTitle(value)) {
      return 'Invalid pin title';
    }
    return null;
  }

  String _pinDescriptionValidator(String value) {
    if (!Validator.isValidPinDescription(value)) {
      return 'Invalid pin description';
    }
    return null;
  }

  String _pinUrlValidator(String value) {
    if (value != null && value.isNotEmpty && !Validator.isValidPinUrl(value)) {
      return 'Invalid url';
    }
    return null;
  }
}

class _PinFormData {
  _PinFormData({
    this.title = '',
    this.description = '',
    this.url = '',
    this.isPrivate = false,
    List<String> tags,
  }) {
    this.tags = tags ?? [];
  }

  String image;
  String title;
  String description;
  String url;
  bool isPrivate;
  List<String> tags;

  NewPin toNewPin() {
    return NewPin(
      title: title,
      description: description,
      url: url,
      isPrivate: isPrivate,
      tags: tags,
    );
  }
}
