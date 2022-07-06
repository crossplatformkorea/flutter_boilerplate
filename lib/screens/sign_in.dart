import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:flutter_boilerplate/utils/localization.dart';
import 'package:flutter_boilerplate/widgets/auth_state.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends AuthState<SignIn> {
  bool _isLoading = false;
  late final TextEditingController _emailController;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    var redirectTo = kIsWeb ? null : dotenv.get("DEEP_LINK");

    final response = await supabase.auth.signIn(
        email: _emailController.text,
        options: AuthOptions(
          redirectTo: redirectTo,
        ));

    final error = response.error;

    if (error != null) {
      Get.snackbar(t('error'), error.message);
    } else {
      Get.snackbar(
        t('success'),
        t('checkYourEmail'),
      );
      _emailController.clear();
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t('signIn'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Text(
            t('emailSignIn'),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: t('email'),
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: Text(
              _isLoading ? t('loading') : t('sendMagicLink'),
            ),
          ),
        ],
      ),
    );
  }
}
