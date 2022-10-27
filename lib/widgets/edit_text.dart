import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  const EditText(
      {Key? key,
      required this.onChanged,
      this.style,
      this.decoration,
      this.keyboardType,
      this.hintText,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true})
      : super(key: key);

  final void Function(String) onChanged;
  final TextStyle? style;
  final String? hintText;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        obscureText: widget.obscureText,
        enableSuggestions: widget.enableSuggestions,
        autocorrect: widget.autocorrect,
        style: widget.style,
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context)
                      .inputDecorationTheme
                      .border!
                      .borderSide
                      .color)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context)
                      .inputDecorationTheme
                      .focusedBorder!
                      .borderSide
                      .color)),
        ),
        onChanged: (String txt) => widget.onChanged(txt),
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
