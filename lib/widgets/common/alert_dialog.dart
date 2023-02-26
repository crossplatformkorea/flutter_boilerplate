import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/colors.dart';
import 'button.dart';
import 'styles.dart';

class _AlertDialog {
  factory _AlertDialog() {
    return _singleton;
  }

  _AlertDialog._internal();
  static final _AlertDialog _singleton = _AlertDialog._internal();

  void confirm(
    BuildContext context, {
    bool barrierDismissible = false,
    required String title,
    required String content,
    String? confirmText = '예',
    String? cancelText = '아니요',
    Color? confirmButtonBackgroundColor,
    Color? confirmTextColor,
    Function? onPress,
    void Function()? onPressCancel,
    bool showCancelButton = false,
    bool showRedButton = false,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(24),
          contentPadding:
              const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          actionsPadding: const EdgeInsets.all(24),
          title: Text(title, style: const TitleTextStyle()),
          content: Text(content, style: const SubTitleTextStyle()),
          actions: <Widget>[
            Button(
                width: MediaQuery.of(context).size.width,
                text: confirmText,
                onPress: () {
                  Navigator.of(context).pop();
                  if (onPress != null) onPress();
                },
                color: confirmTextColor ?? AppColors.text.contrastBasic,
                backgroundColor: showRedButton
                    ? AppColors.role.danger
                    : confirmButtonBackgroundColor ?? AppColors.role.brand),
            showCancelButton
                ? Button(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 10),
                    text: cancelText,
                    onPress: onPressCancel ?? () => Navigator.of(context).pop(),
                    backgroundColor: AppColors.button.light.bg,
                    color: AppColors.button.light.text,
                  )
                : const SizedBox()
          ],
        );
      },
    );
  }

  /// 모집등록시 사용
  void recruitmentRegistration(
    BuildContext context, {
    bool barrierDismissible = false,
    required Function onPressAdvanceRegistration,
    required Function onPressSolicitationRegistration,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(24),
          contentPadding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
          actionsPadding: const EdgeInsets.all(24),
          title: const Text('모집등록', style: TitleTextStyle()),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('등록하실 모집의 유형을 선택해주세요.', style: SubTitleTextStyle()),
              Button(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 40),
                height: 38,
                text: '+ 사전예약 모집등록',
                textStyle: TextStyle(
                  color: AppColors.text.basic,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                onPress: () {
                  context.pop();
                  onPressAdvanceRegistration();
                },
                backgroundColor: AppColors.bg.paper,
                color: Colors.black,
              ),
              Button(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 6),
                height: 38,
                text: '+ 위임요청 모집등록',
                textStyle: TextStyle(
                  color: AppColors.text.basic,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                onPress: () {
                  context.pop();
                  onPressSolicitationRegistration();
                },
                backgroundColor: AppColors.bg.paper,
                color: Colors.black,
              ),
            ],
          ),
          actions: <Widget>[
            Button(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              text: '취소',
              onPress: () => Navigator.of(context).pop(),
              backgroundColor: AppColors.button.light.bg,
              color: AppColors.button.light.text,
            ),
          ],
        );
      },
    );
  }
}

var alertDialog = _AlertDialog();
