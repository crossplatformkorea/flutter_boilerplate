import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/models/user_model.dart';
import 'package:flutter_seoul/providers/user_provider.dart';
import 'package:flutter_seoul/repositories/user_repository.dart';
import 'package:flutter_seoul/utils/colors.dart';
import 'package:flutter_seoul/utils/localization.dart';
import 'package:flutter_seoul/utils/router_config.dart';
import 'package:flutter_seoul/widgets/common/button.dart';
import 'package:flutter_seoul/widgets/common/edit_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignIn extends HookConsumerWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user =
        useState<UserModel>(const UserModel(id: '0', email: '', password: ''));
    var t = localization(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 32, top: 60, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 60, bottom: 8),
                    child: Text(
                      t.appName,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 64),
                    child: const Text(
                      'Flutter BoilerPlate',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(children: [
                    EditText(
                      onChanged: (String txt) {
                        user.value = user.value.copyWith(email: txt);
                      },
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                    ),
                    EditText(
                      onChanged: (String txt) {
                        user.value = user.value.copyWith(password: txt);
                      },
                      hintText: 'Password',
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                  ]),
                  Button(
                    text: '로그인 하기',
                    disabled:
                        user.value.email == '' || user.value.password == '',
                    onPress: () async {
                      await UserRepository.instance.login(user.value);
                      ref.watch(userStateProvider.notifier).getMe();
                      if (context.mounted) {
                        context.go(GoRoutes.home.fullPath);
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 56, bottom: 48),
              child: Column(
                children: [
                  Text(localization(context).inquiry,
                      style: const TextStyle(fontSize: 12, color: grey)),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'support@dooboolab.com',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
