import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/models/user_model.dart';
import 'package:flutter_boilerplate/screens/init_screen.dart';
import 'package:flutter_boilerplate/services/analytics.dart';
import 'package:flutter_boilerplate/services/auth.dart';
import 'package:flutter_boilerplate/utils/colors.dart';
import 'package:flutter_boilerplate/utils/localization.dart';
import 'package:flutter_boilerplate/utils/tools.dart';
import 'package:flutter_boilerplate/widgets/back_app_bar.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../services/apis/firebase_functions.dart';
import '../../utils/constants.dart';
import '../../widgets/outline_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isSignInLoading = false;
  final UserController _userController = Get.put(UserController());

  Future<void> _signIn() async {
    setState(() => _isSignInLoading = true);

    try {
      // TODO: Set unique value
      const String uniqueKey = "Unique key";

      await _signInFirebaseAuth(uniqueKey);
      await _userController.storeUser(
        const UserModel(
          id: uniqueKey,
          name: "name",
        ),
      );
      await Analytics().recordSignUp();
      await _printUserCredential();

      Get.offAll(() => const InitScreen());
    } catch (e) {
      setState(() => _isSignInLoading = false);

      logger.e(e);
    }
  }

  Future<void> _signInFirebaseAuth(String uniqueKey) async {
    final String token = await fetchFirebaseToken(
      uniqueKey,
    );
    await Auth().signInWithCustomToken(token);
  }

  Future<void> _printUserCredential() async {
    final idTokenResult = await _userController.authUser.getIdTokenResult();
    logger.d(idTokenResult.claims);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        title: Text(t("SIGN_UP")),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      t("SIGN_UP"),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Image(
                        image: AssetImage(
                          imageLogo,
                        ),
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
                    onPressed: () => _signIn(),
                    isLoading: _isSignInLoading,
                    style: const OutlineButtonStyle(
                      margin: EdgeInsets.only(
                        bottom: 15,
                      ),
                      width: double.infinity,
                      height: 50,
                    ),
                    child: const Text(
                      "Sign up with custom token",
                      style: TextStyle(
                        color: hotPinkColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
