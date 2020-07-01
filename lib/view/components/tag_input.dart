import 'package:flutter/material.dart';
import 'package:mobile/view/components/tag_chips.dart';

class TagInput extends StatefulWidget {
  TagInput({
    this.label = '',
    this.hintText = '',
    this.onChanged,
  });

  final String label;
  final String hintText;
  final void Function(List<String> tags) onChanged;

  @override
  _TagInputState createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  List<String> tags = [];
  final _controller = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final value = _controller.text;
      if (value.isEmpty) {
        return;
      }

      final lastChar = value[value.length - 1];
      final tag = value.trim();
      if (lastChar == ' ' || lastChar == '\n' || lastChar == '\t') {
        if (!tags.contains(tag)) {
          setState(() {
            tags.add(tag);
          });
          widget.onChanged(tags);
        }
        _controller.clear();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label),
          TextFormField(
            controller: _controller,
            maxLines: 1,
            onFieldSubmitted: _onTextFieldSubmitted,
          ),
          TagChips(
            tags: tags,
          ),
        ],
      ),
    );
  }

  void _onTextFieldSubmitted(String value) {
    if (value.isEmpty) {
      return;
    }

    final tag = value.trim();
    if (!tags.contains(tag)) {
      setState(() {
        tags.add(tag);
      });
      widget.onChanged(tags);
    }
    _controller.clear();
  }
}
