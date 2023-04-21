import 'package:flutter/material.dart';
import 'package:flutter_seoul/generated/l10n.dart';
import 'package:flutter_seoul/utils/router_config.dart';
import 'package:flutter_seoul/utils/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'mocks/navigator_observer.mocks.dart';

enum Device { mobile, tablet, desktop }

class TestUtils {
  static MockNavigatorObserver observer = MockNavigatorObserver();
  static Widget buildMediaQueryTestableWidget(
      {required Device device, required Widget child}) {
    double setDeviceWidth() {
      if (device == Device.mobile) {
        return 412;
      } else if (device == Device.tablet) {
        return 900;
      }

      return 1920;
    }

    return MediaQuery(
      data: MediaQueryData(
        size: Size.fromWidth(
          setDeviceWidth(),
        ),
      ),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  static Widget makeTestableWidget({required String? child}) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
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
        routerConfig: routerConfig(child),
      ),
    );
  }
}
