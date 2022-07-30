import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/controllers/count_controller.dart';
import 'package:flutter_boilerplate/navigations/main_bottom_tab.dart';
import 'package:flutter_boilerplate/screens/sign_up_screen/sign_up_screen.dart';
import 'package:flutter_boilerplate/utils/colors.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:flutter_boilerplate/utils/localization.dart';
import 'package:flutter_boilerplate/widgets/outline_button.dart';
import 'package:flutter_boilerplate/widgets/solid_button.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final controller = Get.put(CountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              hotPinkColor,
              skyBlueColor,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image(
                      image: AssetImage(
                        imageLogo,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Column(
                children: [
                  OutlineButton(
                    onPressed: () => Get.to(() => const SignUpScreen()),
                    style: const OutlineButtonStyle(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.only(
                        bottom: 15,
                      ),
                      borderColor: Colors.white,
                      textColor: Colors.white,
                    ),
                    child: Text(t("SIGN_UP")),
                  ),
                  SolidButton(
                    onPressed: () => Get.to(() => const MainBottomTab()),
                    style: SolidButtonStyle(
                      width: double.infinity,
                      height: 50,
                      backgroundColor: Colors.white,
                      feedbackColor: Colors.grey[300],
                    ),
                    child: Text(
                      t("SIGN_IN"),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
