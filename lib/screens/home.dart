import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/screens/edit_profile.dart';
import 'package:flutter_seoul/utils/colors.dart';
import 'package:flutter_seoul/utils/localization.dart';
import 'package:flutter_seoul/utils/router_config.dart';
import 'package:flutter_seoul/widgets/edit_text.dart';
import 'package:flutter_seoul/widgets/seoul_button.dart';
import 'package:go_router/go_router.dart';

class LoginValue {
  String name;
  TextInputType? keyboardType;
  String? hintText;
  bool obscureText;
  bool enableSuggestions;
  bool autocorrect;

  LoginValue(
      {required this.name,
      this.keyboardType,
      this.hintText,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true});
}

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailValue = useState('');
    var passwordValue = useState('');

    final List<LoginValue> loginValues = [
      LoginValue(
          name: 'Email',
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress),
      LoginValue(
        name: 'Password',
        hintText: 'Password',
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
      ),
    ];
    var t = localization(context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                    Column(
                        children: loginValues.map((LoginValue item) {
                      return EditText(
                        onChanged: (String txt) {
                          if (item.name == 'Email') {
                            emailValue.value = txt;
                          } else {
                            passwordValue.value = txt;
                          }
                        },
                        keyboardType: item.keyboardType,
                        hintText: item.hintText,
                        obscureText: item.obscureText,
                        enableSuggestions: item.enableSuggestions,
                        autocorrect: item.autocorrect,
                      );
                    }).toList()),
                    SeoulButton(
                      onPressed: () {
                        context.push(
                          GoRoutes.editProfile.fullPath,
                          extra: EditProfileArguments(
                              title: 'editProfile', person: 'ss'),
                        );
                      },
                      disabled:
                          emailValue.value == '' || passwordValue.value == '',
                      style: SeoulButtonStyle(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        backgroundColor: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .background,
                      ),
                      child: Text(
                        '로그인 하기',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                            fontSize: 16),
                      ),
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
      ),
    );
  }
}
