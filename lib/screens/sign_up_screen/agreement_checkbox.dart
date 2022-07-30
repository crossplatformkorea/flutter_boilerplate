import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/widgets/custom_checkbox.dart';

class AgreementCheckbox extends StatelessWidget {
  final bool value;
  final double size;
  final void Function(bool) onChanged;

  const AgreementCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.size = 30,
  }) : super(key: key);

  Widget _buildCheckbox(Color color) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Icon(
        Icons.check,
        color: color,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomCheckbox(
      onChanged: onChanged,
      value: value,
      checkBoxStyle: const CheckBoxStyle(
        checkedBackgroundColor: Colors.transparent,
        uncheckedBackgroundColor: Colors.transparent,
        isCircleFeedback: true,
      ),
      checkedWidget: _buildCheckbox(Theme.of(context).primaryColor),
      uncheckedWidget: _buildCheckbox(Colors.grey),
    );
  }
}
