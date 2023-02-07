import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../utils/colors.dart';

class RadioGroup<T> extends HookWidget {
  const RadioGroup({
    super.key,
    this.label,
    this.padding,
    this.selected,
    this.onChanged,
    required this.values,
    this.names,
    this.strokeColor,
    this.disabledStrokeColor,
    this.strokeWidth = 1,
    this.enabled = true,
    this.extraWidgetOnSelected,
  }) : assert(names == null || names.length == values.length,
            'The length of `names` should match with `values` when provided.');
  final EdgeInsets? padding;
  final T? selected;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final List<T> values;
  final List<String>? names;
  final Color? strokeColor;
  final Color? disabledStrokeColor;
  final double strokeWidth;
  final bool enabled;
  final Widget? extraWidgetOnSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    label!,
                    style: TextStyle(
                        color: AppColors.text.basic,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : const SizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: values.asMap().entries.map((entry) {
              var idx = entry.key;
              var e = entry.value;

              return Flexible(
                flex: 1,
                child: InkWell(
                  onTap: enabled ? () => onChanged?.call(e) : null,

                  /// Apply [InkWell] border radius
                  ///
                  /// https://stackoverflow.com/a/64410674/8841562
                  customBorder: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(8)),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: enabled
                                ? strokeColor ?? AppColors.bg.border
                                : disabledStrokeColor ?? AppColors.bg.disabled,
                            width: strokeWidth,
                          ),
                        ),
                        borderRadius: idx == 0
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              )
                            : idx == values.length - 1
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  )
                                : null),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Radio(
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -3),
                                focusColor: AppColors.role.brand,
                                activeColor: AppColors.role.brand,
                                value: e,
                                groupValue: selected,
                                onChanged: enabled ? onChanged : null,
                              ),
                              names != null
                                  ? Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              names![idx].toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            e == selected
                                                ? extraWidgetOnSelected ??
                                                    const SizedBox()
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
