import 'package:flutter/material.dart';
import '../../utils/colors.dart';

enum ButtonType {
  solid,
  outline,
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.buttonType = ButtonType.solid,
    this.text = '',
    this.width,

    /// Adhoc used for button with default width but with specific height
    this.height = 52,
    this.onPress,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w600,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.showContainerBackground = false,
    this.margin = const EdgeInsets.only(left: 0, right: 0),
    this.padding,
    this.borderRadius = 8.0,
    this.borderWidth = 0.0,
    this.borderColor,
    this.loading = false,
    this.disabled = false,
    this.autofocus = false,
    this.leftWidget,
    this.rightWidget,
    this.textStyle,
    this.borderShape,
  }) : super(key: key);

  final ButtonType buttonType;
  final String? text;
  final double? width;
  final double height;
  final VoidCallback? onPress;
  final Color color;
  final FontWeight fontWeight;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final bool showContainerBackground;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final double borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final bool loading;
  final bool disabled;
  final bool autofocus;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final TextStyle? textStyle;
  final MaterialStateProperty<OutlinedBorder?>? borderShape;

  Widget _renderLoading(BuildContext context) {
    return CircularProgressIndicator(
      semanticsLabel: '로딩',
      backgroundColor: backgroundColor ?? AppColors.role.brand,
      strokeWidth: 3,
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }

  Widget _renderContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        leftWidget ?? const SizedBox(),
        SizedBox(
          child: Center(
            child: loading
                ? _renderLoading(context)
                : Text(
                    text!,
                    style: TextStyle(color: color, fontWeight: fontWeight)
                        .merge(textStyle),
                  ),
          ),
        ),
        rightWidget ?? const SizedBox(),
      ],
    );
  }

  Widget _renderSolidButton(BuildContext context) {
    return ElevatedButton(
      onPressed: loading
          ? () {}
          : !disabled
              ? onPress
              : null,
      autofocus: autofocus,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.role.brand,
        padding: padding,
        fixedSize: Size(width ?? double.infinity, height),
        textStyle: TextStyle(color: color, fontWeight: FontWeight.w600)
            .merge(textStyle),
        disabledForegroundColor: Colors.black,
        disabledBackgroundColor:
            disabledBackgroundColor ?? AppColors.button.disabled.bg,
        elevation: 0,
      ).merge(ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
        shape: borderShape ??
            (borderWidth != 0.0
                ? MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      side: BorderSide(
                        color: borderColor ?? AppColors.button.disabled.bg,
                        width: borderWidth,
                      ),
                    ),
                  )
                : MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  )),
      )),
      child: _renderContent(context),
    );
  }

  Widget _renderOutlineButton(BuildContext context) {
    return OutlinedButton(
      autofocus: autofocus,
      clipBehavior: Clip.none,
      onPressed: loading
          ? () {}
          : !disabled
              ? onPress
              : null,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 1),
        padding: padding,
        fixedSize: Size(width ?? double.infinity, height),
        textStyle: TextStyle(color: color, fontWeight: FontWeight.w500)
            .merge(textStyle),
        disabledForegroundColor: Colors.black,
        elevation: 0,
      ).merge(ButtonStyle(
        shape: borderShape ??
            (borderWidth != 0.0
                ? MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      side: BorderSide(
                        color: borderColor ?? AppColors.button.disabled.bg,
                        width: borderWidth,
                      ),
                    ),
                  )
                : MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  )),
      )),
      child: _renderContent(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        width: width,
        height: height,
        child: buttonType == ButtonType.solid
            ? _renderSolidButton(context)
            : _renderOutlineButton(context));
  }
}
