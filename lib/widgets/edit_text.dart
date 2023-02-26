import 'package:flutter/material.dart';
import 'package:flutter_seoul/utils/colors.dart';
import 'package:flutter_seoul/widgets/common/styles.dart';

OutlineInputBorder focusedOutlineBorder = OutlineInputBorder(
  borderSide: BorderSide(width: 1.5, color: AppColors.role.basic),
  borderRadius: const BorderRadius.all(Radius.circular(8)),
);

OutlineInputBorder outlineBorder = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: AppColors.role.basic),
  borderRadius: const BorderRadius.all(Radius.circular(8)),
);

OutlineInputBorder disableBorder = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: AppColors.bg.borderContrast),
  borderRadius: const BorderRadius.all(Radius.circular(8)),
);

OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(width: 1.5, color: AppColors.role.danger),
  borderRadius: const BorderRadius.all(Radius.circular(8)),
);

OutlineInputBorder errorBorder = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: AppColors.role.danger),
  borderRadius: const BorderRadius.all(Radius.circular(8)),
);

class EditText extends StatefulWidget {
  const EditText(
      {Key? key,
      required this.onChanged,
      this.style,
      this.decoration,
      this.keyboardType,
      this.hintText,
      this.validator,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true})
      : super(key: key);

  final void Function(String) onChanged;
  final TextStyle? style;
  final String? hintText;
  final String? Function(String?)? validator;
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

class EditFormText extends StatelessWidget {
  const EditFormText({
    Key? key,
    this.focusNode,
    this.margin,
    this.padding,
    this.label = '',
    this.hintText,
    this.cursorColor,
    this.errorText,
    this.textEditingController,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.textInputAction,
    this.validator,
    this.keyboardType,
    this.isSecret = false,
    this.hasChecked = false,
    this.showBorder = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.inputDecoration,
    this.labelStyle = const InputLabelTextStyle(),
    this.textStyle = const TextStyle(
      fontSize: 16.0,
    ),
    this.hintStyle = const TextStyle(
      fontSize: 16.0,
    ),
    this.errorStyle = const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    this.onTap,
    this.prefixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLength,
  }) : super(key: key);
  final FocusNode? focusNode;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String label;
  final int minLines;
  final int maxLines;
  final InputDecoration? inputDecoration;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final String? hintText;
  final Color? cursorColor;
  final TextStyle hintStyle;
  final String? errorText;
  final TextStyle errorStyle;
  final bool isSecret;
  final bool hasChecked;
  final bool showBorder;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Widget? prefixIcon;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    label,
                    style: labelStyle,
                  ),
                )
              : const SizedBox(),
          Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              TextFormField(
                key: key,
                maxLength: maxLength,
                validator: validator,
                keyboardType: keyboardType,
                obscureText: isSecret,
                focusNode: focusNode,
                minLines: minLines,
                cursorColor: cursorColor,
                maxLines: maxLines,
                controller: textEditingController,
                enabled: enabled,
                readOnly: readOnly,
                autofocus: autofocus,

                /// Set default [InputDecoration] below instead of constructor
                /// because we need to apply optional parameters given in other props.
                ///
                /// You can pass [inputDecoration] to replace default [InputDecoration].
                decoration: inputDecoration ??
                    InputDecoration(
                      prefixIcon: prefixIcon,
                      counterText: '',
                      focusColor: AppColors.text.basic,
                      fillColor: !enabled
                          ? AppColors.bg.borderContrast
                          : AppColors.bg.basic,
                      filled: !enabled,
                      disabledBorder:
                          showBorder ? disableBorder : InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                      focusedBorder:
                          showBorder ? focusedOutlineBorder : InputBorder.none,
                      enabledBorder:
                          showBorder ? outlineBorder : InputBorder.none,
                      errorBorder: showBorder ? errorBorder : InputBorder.none,
                      focusedErrorBorder:
                          showBorder ? focusedErrorBorder : InputBorder.none,
                      hintText: hintText,
                      hintStyle: hintStyle,
                      errorText: errorText,
                      errorMaxLines: 2,
                      errorStyle: errorStyle,
                    ),
                style: textStyle.merge(TextStyle(
                  color: !enabled ? AppColors.text.placeholder : null,
                )),
                onChanged: onChanged,
                onFieldSubmitted: onSubmitted,
                onEditingComplete: onEditingComplete,
                textInputAction: textInputAction,
                onTap: onTap,
                autocorrect: false,
              ),
              hasChecked
                  ? const Positioned(
                      right: 0.0,
                      top: 16.0,
                      child: Icon(
                        Icons.check,
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
