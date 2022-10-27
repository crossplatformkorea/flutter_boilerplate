import 'package:flutter/material.dart';
import 'package:flutter_seoul/generated/l10n.dart';
import 'package:flutter_seoul/screens/edit_profile.dart';
import 'package:flutter_seoul/screens/home.dart';
import 'package:flutter_seoul/screens/sample.dart';
import 'package:flutter_seoul/utils/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_seoul/widgets/model_theme.dart';
import 'package:provider/provider.dart';

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

  static Widget makeTestableWidget({required Widget child}) {
    var widget = ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
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
          routes: {
            '/': (context) => const Home(),
            '/edit_profile': (context) => const EditProfile(),
            '/sample': (context) => const Sample()
          },
        );
      }),
    );
    return widget;
  }
}
