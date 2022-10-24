import 'package:flutter/material.dart';
import 'package:flutter_seoul/utils/colors.dart';

class SeoulButton extends StatelessWidget {
  final void Function() onPressed;
  final bool disabled;
  final bool isLoading;
  final Widget child;
  final SeoulButtonStyle style;

  const SeoulButton({
    Key? key,
    required this.onPressed,
    this.disabled = false,
    this.isLoading = false,
    required this.child,
    this.style = const SeoulButtonStyle(),
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
            disabled ? Theme.of(context).disabledColor : style.backgroundColor,
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

class SeoulButtonStyle {
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

  const SeoulButtonStyle({
    this.width,
    this.height,
    this.backgroundColor = primaryColor,
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
