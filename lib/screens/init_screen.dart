import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/controllers/user_controller.dart';
import 'package:flutter_boilerplate/errors/user_not_found.dart';
import 'package:flutter_boilerplate/navigations/main_bottom_tab.dart';
import 'package:flutter_boilerplate/screens/sign_in_screen.dart';
import 'package:flutter_boilerplate/widgets/circle_loading_indicator.dart';
import 'package:get/get.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    setInitScreen();
  }

  Future<void> setInitScreen() async {
    try {
      await _userController.initUser();

      Get.offAll(() => const MainBottomTab());
    } on UserNotFound {
      Get.offAll(() => const SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CircleLoadingIndicator();
  }
}
