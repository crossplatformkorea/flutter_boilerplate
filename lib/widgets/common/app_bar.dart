import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarBack extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List? actions;
  final bool isBottomBorderDisplayed;
  final BottomBorderStyle bottomBorderStyle;

  const AppBarBack({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.isBottomBorderDisplayed = true,
    this.bottomBorderStyle = const BottomBorderStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_outlined,
        ),
        onPressed: () => context.pop(),
      ),
      bottom: isBottomBorderDisplayed
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomBorderStyle.height),
              child: Container(
                color: bottomBorderStyle.color,
                height: bottomBorderStyle.height,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BottomBorderStyle {
  final Color color;
  final double height;

  const BottomBorderStyle({
    this.color = Colors.grey,
    this.height = 1,
  });
}
