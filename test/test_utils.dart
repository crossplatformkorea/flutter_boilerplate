import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/generated/l10n.dart';
import 'package:flutter_boilerplate/screens/home.dart';
import 'package:flutter_boilerplate/screens/result.dart';
import 'package:flutter_boilerplate/utils/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'mocks/navigator_observer.mocks.dart';

class TestUtils {
  static MockNavigatorObserver observer = MockNavigatorObserver();
  static Widget makeTestableWidget({required Widget child}) {
    var widget = GetMaterialApp(
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
      home: child,
      navigatorObservers: <NavigatorObserver>[observer],
      getPages: [
        GetPage(
          name: '/',
          page: () => const Home(),
        ),
        GetPage(
          name: '/result',
          page: () => const Result(),
        ),
      ],
    );

    return widget;
  }
}
