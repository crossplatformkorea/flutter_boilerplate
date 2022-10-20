import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/controllers/count_controller.dart';
import 'package:flutter_boilerplate/screens/edit_profile.dart';
import 'package:flutter_boilerplate/utils/colors.dart';
import 'package:flutter_boilerplate/widgets/solid_button.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(CountController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String _emailValue = "";
  late String _passwordValue = "";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _getThemeStatus() async {
    var isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : false;
    }).obs;

    bool copyValue = (await isLight.value)!;
    Get.changeThemeMode(copyValue ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void initState() {
    super.initState();
    _getThemeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(32, 60, 32, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(0, 64, 0, 8),
                    child: const Text(
                      "Flutter Seoul",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 64),
                    child: const Text(
                      "Flutter BoilerPlate",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: TextField(
                      onChanged: (String txt) => setState(() {
                        _emailValue = txt;
                      }),
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .border!
                                    .borderSide
                                    .color)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedBorder!
                                    .borderSide
                                    .color)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: TextField(
                      onChanged: (String txt) => setState(() {
                        _passwordValue = txt;
                      }),
                      controller: _passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .border!
                                    .borderSide
                                    .color)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedBorder!
                                    .borderSide
                                    .color)),
                      ),
                    ),
                  ),
                  SolidButton(
                    onPressed: () {
                      Get.to(
                        () => const EditProfile(),
                        arguments: "${controller.count.value}",
                      );
                    },
                    disabled: _emailValue == "" || _passwordValue == "",
                    style: SolidButtonStyle(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      backgroundColor:
                          Theme.of(context).buttonTheme.colorScheme!.background,
                    ),
                    child: Text(
                      "로그인 하기",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 48),
              child: Column(
                children: [
                  const Text("이용문의",
                      style: TextStyle(fontSize: 12, color: grey)),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      "support@dooboolab.com",
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
