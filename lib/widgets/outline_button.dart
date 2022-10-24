import 'package:flutter/material.dart';
import 'package:flutter_seoul/utils/colors.dart';

class OutlineButton extends StatelessWidget {
  final void Function() onPressed;
  final bool disabled;
  final bool isLoading;
  final Widget child;
  final OutlineButtonStyle style;

  const OutlineButton({
    Key? key,
    required this.onPressed,
    this.disabled = false,
    this.isLoading = false,
    required this.child,
    this.style = const OutlineButtonStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const m = MaterialStateProperty.all;

    return Container(
      width: style.width,
      height: style.height,
      margin: style.margin,
      child: ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: ButtonStyle(
          padding: m<EdgeInsetsGeometry?>(style.padding),
          backgroundColor: m<Color?>(Colors.transparent),
          elevation: m<double?>(0),
          side: m<BorderSide?>(
            BorderSide(
              width: style.borderWidth,
              color: disabled
                  ? style.borderColor.withOpacity(0.3)
                  : style.borderColor,
            ),
          ),
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
                      ? Colors.black.withOpacity(0.03)
                      : style.feedbackColor!
                  : null;
            },
          ),
          foregroundColor: m<Color?>(
            disabled
                ? (style.textColor ?? Colors.black).withOpacity(0.4)
                : (style.textColor ?? Colors.black),
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

class OutlineButtonStyle {
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Color? feedbackColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderWidth;
  final Color borderColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? textColor;
  final double indicatorSize;
  final double indicatorWidth;
  final Color? indicatorColor;

  const OutlineButtonStyle({
    this.width,
    this.height,
    this.borderWidth = 1.5,
    this.borderColor = primaryColor,
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
