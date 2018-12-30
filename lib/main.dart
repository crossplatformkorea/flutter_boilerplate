import 'package:flutter/material.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';
import 'dart:async';

import './utils/localization.dart';
import './utils/theme.dart' as Theme;
import './screens/splash.dart' show Splash;
import './screens/index.dart' show Index;
import './screens/empty.dart' show Empty;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Theme.Colors.dodgerBlue,
        accentColor: Theme.Colors.dodgerBlue,
        hintColor: Theme.Colors.paleGray,
        disabledColor: Theme.Colors.disabled,
      ),
      routes: {
        '/splash': (BuildContext context) => Splash(),
        '/index': (BuildContext context) => Index(),
        '/empty': (BuildContext context) => Empty(),
      },
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ko', 'KR')
      ],
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          debugPrint("*language locale is null!!!");
          return supportedLocales.first;
        }
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      title: 'dooboolab',
      home: Splash(), // production
    );
  }
}

