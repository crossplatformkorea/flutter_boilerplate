// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_boilerplate/main.dart';
import 'package:flutter_boilerplate/screens/splash.dart';

import 'package:flutter\_localizations/flutter\_localizations.dart';
import 'package:flutter_boilerplate/utils/localization.dart' show LocalizationDelegate;

void main() {

  Widget makeTestableWidget({ Widget child }) {
    return MaterialApp(
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
      locale: Locale('en'),
      home: child,
    );
  }

  testWidgets('Widget', (WidgetTester tester) async {
    Splash screen = Splash();
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: screen));
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    // TODO: below fails
    expect(find.text('Loading'), findsOneWidget);
    // TODO: below fails
    expect(find.text('Loading...'), findsOneWidget);
    // below pass
    expect(find.text('1'), findsNothing);
  });
}
