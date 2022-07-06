import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/screens/account.dart';
import 'package:flutter_boilerplate/screens/sign_in.dart';
import 'package:flutter_boilerplate/utils/localization.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    Get.offAll(const SignIn());
  }

  @override
  void onAuthenticated(Session session) {
    Get.offAll(const Account());
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {
    Get.snackbar(t('error'), message);
  }
}
