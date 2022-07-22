import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final void Function(bool) onChanged;

  final Widget? uncheckedWidget;
  final Widget? checkedWidget;

  final CheckBoxStyle checkBoxStyle;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.uncheckedWidget,
    this.checkedWidget,
    this.checkBoxStyle = const CheckBoxStyle(),
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomCheckbox oldWidget) {
    if (widget.value != _value) {
      _value = widget.value;
    }

    super.didUpdateWidget(oldWidget);
  }

  Widget _buildCheckBox() {
    if (_value) {
      if (widget.checkedWidget != null) {
        return widget.checkedWidget!;
      }

      return _buildDefaultCheckBox(
        child: Icon(
          Icons.check,
          color: widget.checkBoxStyle.checkColor,
          size: widget.checkBoxStyle.iconSize,
        ),
      );
    }

    if (widget.uncheckedWidget != null) {
      return widget.uncheckedWidget!;
    }

    return _buildDefaultCheckBox();
  }

  Widget _buildDefaultCheckBox({Widget? child}) {
    final style = widget.checkBoxStyle;

    return Container(
      height: style.height,
      width: style.width,
      padding: style.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          style.borderRadius,
        ),
        border: Border.all(
          width: 1, //
          color: style.borderColor,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ripple animation does not work
    // when touching when the color is set in the container.
    return Material(
      color: _value
          ? widget.checkBoxStyle.checkedBackgroundColor
          : widget.checkBoxStyle.uncheckedBackgroundColor,
      child: InkWell(
        customBorder:
            widget.checkBoxStyle.isCircleFeedback ? const CircleBorder() : null,
        onTap: () {
          setState(() => _value = !_value);

          widget.onChanged(_value);
        },
        child: _buildCheckBox(),
      ),
    );
  }
}

class CheckBoxStyle {
  final bool isCircleFeedback;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? iconSize;
  final Color borderColor;
  final Color checkColor;
  final Color checkedBackgroundColor;
  final Color uncheckedBackgroundColor;

  const CheckBoxStyle({
    this.isCircleFeedback = false,
    this.width = 25,
    this.height = 25,
    this.padding,
    this.borderRadius = 4,
    this.checkColor = Colors.blue,
    this.borderColor = Colors.black,
    this.iconSize = 23,
    this.checkedBackgroundColor = Colors.white,
    this.uncheckedBackgroundColor = Colors.white,
  });
}
