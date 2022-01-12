import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/generated/l10n.dart';
import 'package:flutter_boilerplate/screens/home.dart';
import 'package:flutter_boilerplate/utils/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: implementation_imports
import 'package:flutter_dotenv/src/errors.dart' show FileNotFoundError;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } on FileNotFoundError {
    logger.e("Not found .env file");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const Home(),
        ),
      ],
    );
  }
}
