import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

const primaryColor = Color(0xFFFF608D);
const grey = Color(0xFFC4C4C4);

enum ColorSchemeType { bg, role, text, button }

// 다크모드가 없으므로 현재는 white mode 색상으로 통일

class _BgColor {
  _BgColor({
    required this.basic,
    required this.paper,
    required this.disabled,
    required this.border,
    required this.borderContrast,
  });
  final Color basic;
  final Color paper;
  final Color disabled;
  final Color border;
  final Color borderContrast;

  static _BgColor get lightTheme => _BgColor(
        basic: const Color(0xFFFFFFFF),
        paper: const Color(0xFFF2F3F5),
        disabled: const Color.fromRGBO(178, 180, 182, 1),
        border: const Color(0xFFE5E7EA),
        borderContrast: const Color(0xFFF2F3F5),
      );

  static _BgColor get darkTheme => lightTheme;
}

class _RoleColor {
  _RoleColor({
    required this.basic,
    required this.brand,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.info,
    required this.link,
    required this.success,
    required this.warning,
    required this.danger,
    required this.validation,
  });
  final Color basic;
  final Color brand;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color info;
  final Color link;
  final Color success;
  final Color warning;
  final Color danger;
  final Color validation;

  static _RoleColor get lightTheme => _RoleColor(
        basic: const Color(0xFF000000),
        brand: const Color(0xFF323749),
        primary: const Color(0xFFFF3E4E),
        secondary: const Color(0xFF1E85FF),
        accent: const Color(0x0fffffff),
        info: const Color(0x0fffffff),
        link: const Color(0x0fffffff),
        success: const Color(0xFF37D200),
        warning: const Color(0xFFFFA722),
        danger: const Color(0xFFFF3F4A),
        validation: const Color(0xFFFF3F4A),
      );

  static _RoleColor get darkTheme => lightTheme;
}

class _TextColor {
  _TextColor({
    required this.basic,
    required this.label,
    required this.placeholder,
    required this.disabled,
    required this.validation,
    required this.contrastBasic,
    required this.contrastPlaceholder,
    required this.contrastDisabled,
    required this.contrastValidation,

    ///
    required this.brand,
    required this.primary,
    required this.secondary,

    ///
    required this.accent,
    required this.info,
    required this.link,
    required this.success,
    required this.warning,
    required this.danger,
  });
  final Color basic;
  final Color label;
  final Color placeholder;
  final Color disabled;
  final Color validation;
  final Color contrastBasic;
  final Color contrastPlaceholder;
  final Color contrastDisabled;
  final Color contrastValidation;

  ///
  final Color brand;
  final Color primary;
  final Color secondary;

  ///
  final Color accent;
  final Color info;
  final Color link;
  final Color success;
  final Color warning;
  final Color danger;

  static _TextColor get lightTheme => _TextColor(
        basic: const Color(0xFF000000),
        label: const Color(0xFF808080),
        placeholder: const Color(0xFFB3B3B3),
        disabled: Colors.white,
        validation: const Color(0xFFFF3F4A),
        contrastBasic: Colors.white,
        contrastPlaceholder: const Color(0xFFCCCCCC),
        contrastDisabled: const Color(0x30FFFFFF),
        contrastValidation: const Color(0x0fffffff),

        ///
        brand: const Color(0xFFB3B3B3),
        primary: const Color(0xFFFF3E4E),
        secondary: const Color(0xFF1E85FF),

        ///
        accent: const Color(0x0fffffff),
        info: const Color(0xFF262626),
        link: const Color(0x0fffffff),
        success: const Color(0x0fffffff),
        warning: const Color(0x0fffffff),
        danger: const Color(0x0fffffff),
      );

  static _TextColor get darkTheme => lightTheme;
}

class _ButtonColorType {
  const _ButtonColorType(this.text, this.bg);
  final Color text;
  final Color bg;
}

class _ButtonColor {
  _ButtonColor({
    required this.primary,
    required this.brand,
    required this.secondary,
    required this.success,
    required this.danger,
    required this.warning,
    required this.info,
    required this.light,
    required this.disabled,
  });
  final _ButtonColorType primary;
  final _ButtonColorType brand;
  final _ButtonColorType secondary;
  final _ButtonColorType success;
  final _ButtonColorType danger;
  final _ButtonColorType warning;
  final _ButtonColorType info;
  final _ButtonColorType light;
  final _ButtonColorType disabled;

  static _ButtonColor get lightTheme => _ButtonColor(
        primary: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFFFF3E4E),
        ),
        brand: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFF323749),
        ),
        secondary: const _ButtonColorType(
          Color(0xFF000000),
          Color(0xFFE5E5EA),
        ),
        success: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFF4CD964),
        ),
        danger: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFFFF3F4A),
        ),
        warning: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFFFFA722),
        ),
        info: const _ButtonColorType(
          Color(0xFFE5E7EA),
          Colors.black,
        ),
        light: const _ButtonColorType(
          Color(0xFF262626),
          Color(0xFFE5E7EA),
        ),
        disabled: const _ButtonColorType(
          Color(0xFFB3B3B3),
          Color(0xFFB3B3B3),
        ),
      );

  static _ButtonColor get darkTheme => lightTheme;
}

// https://stackoverflow.com/a/56307575/884156
var brightness =
    SchedulerBinding.instance.platformDispatcher.platformBrightness;
bool isLightMode = brightness != Brightness.dark;

class AppColors {
  static var bg = isLightMode ? _BgColor.lightTheme : _BgColor.darkTheme;
  static var role = isLightMode ? _RoleColor.lightTheme : _RoleColor.darkTheme;
  static var text = isLightMode ? _TextColor.lightTheme : _TextColor.darkTheme;
  static var button =
      isLightMode ? _ButtonColor.lightTheme : _ButtonColor.darkTheme;
}
