import 'package:flutter/material.dart';
import 'package:flutter_seoul/widgets/edit_text.dart';

class EditTextView extends StatefulWidget {
  const EditTextView(
      {Key? key, required this.item, required this.onChanged, this.type})
      : super(key: key);

  final String item;
  final void Function(String) onChanged;
  final TextInputType? type;

  @override
  State<EditTextView> createState() => _EditTextViewState();
}

class _EditTextViewState extends State<EditTextView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: EditText(
        onChanged: widget.onChanged,
        hintText: widget.item,
        keyboardType: widget.type,
        obscureText: widget.item == "Password" ? true : false,
        enableSuggestions: widget.item == "Password" ? false : true,
        autocorrect: widget.item == "Password" ? false : true,
      ),
    );
  }
}
