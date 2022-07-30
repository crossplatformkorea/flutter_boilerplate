import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/generated/l10n.dart';
import 'package:flutter_boilerplate/screens/init_screen.dart';
import 'package:flutter_boilerplate/screens/sign_in_screen.dart';
import 'package:flutter_boilerplate/services/analytics.dart';
import 'package:flutter_boilerplate/utils/firebase_config.dart';
import 'package:flutter_boilerplate/utils/themes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await FirebaseConfig.initializeApp();
  await Future.wait([
    FirebaseAppCheck.instance.activate(
      // TODO: Recaptcha registration required after domain setting for the web
      // https://firebase.google.com/docs/app-check/web/recaptcha-provider
      webRecaptchaSiteKey: "recaptcha-v3-site-key",
    ),
    Analytics().recordAppOpen(),
  ]);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Themes.setStatusBarColors();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ko', 'KR'),
      ],
      home: const InitScreen(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const SignInScreen(),
        ),
      ],
    );
  }
}
