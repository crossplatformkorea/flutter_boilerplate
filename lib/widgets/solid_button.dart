import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  final void Function() onPressed;
  final bool disabled;
  final bool isLoading;
  final Widget child;
  final SolidButtonStyle style;

  const SolidButton({
    Key? key,
    required this.onPressed,
    this.disabled = false,
    this.isLoading = false,
    required this.child,
    this.style = const SolidButtonStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const m = MaterialStateProperty.all;

    return Container(
      margin: style.margin,
      width: style.width,
      height: style.height,
      child: ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: m<Color?>(
            disabled
                ? style.backgroundColor.withOpacity(0.4)
                : style.backgroundColor,
          ),
          padding: m<EdgeInsetsGeometry?>(style.padding),
          shape: m<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: style.borderRadius == null
                  ? BorderRadius.circular(8)
                  : style.borderRadius!,
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              return states.contains(MaterialState.pressed)
                  ? style.feedbackColor == null
                      ? null
                      : style.feedbackColor!
                  : null;
            },
          ),
          foregroundColor: m<Color?>(
            disabled
                ? (style.textColor ?? Colors.black).withOpacity(0.4)
                : (style.textColor ?? Colors.white),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: style.indicatorSize,
                height: style.indicatorSize,
                child: CircularProgressIndicator(
                  strokeWidth: style.indicatorWidth,
                  color: style.indicatorColor,
                ),
              )
            : child,
      ),
    );
  }
}

class SolidButtonStyle {
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Color? feedbackColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? textColor;
  final double indicatorSize;
  final double indicatorWidth;
  final Color? indicatorColor;

  const SolidButtonStyle({
    this.width,
    this.height,
    this.backgroundColor = Colors.black,
    this.feedbackColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.textColor,
    this.indicatorSize = 20,
    this.indicatorWidth = 2,
    this.indicatorColor = Colors.black,
  });
}
