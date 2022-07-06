import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/generated/l10n.dart';
import 'package:flutter_boilerplate/screens/account.dart';
import 'package:flutter_boilerplate/screens/home.dart';
import 'package:flutter_boilerplate/screens/sign_in.dart';
import 'package:flutter_boilerplate/utils/themes.dart';
import 'package:flutter_boilerplate/utils/tools.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: env("SUPABASE_API_URL"),
    anonKey: env("SUPABASE_ANON_KEY"),
    debug: env("ENV") == "development",
  );

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
      home: const Home(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const Home(),
        ),
        GetPage(
          name: '/sign-in',
          page: () => const SignIn(),
        ),
        GetPage(
          name: '/account',
          page: () => const Account(),
        ),
      ],
    );
  }
}
