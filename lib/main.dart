import 'package:flutter/material.dart';
import 'package:flutter_seoul/generated/l10n.dart';
import 'package:flutter_seoul/screens/edit_profile.dart';
import 'package:flutter_seoul/screens/home.dart';
import 'package:flutter_seoul/screens/result.dart';
import 'package:flutter_seoul/screens/sample.dart';
import 'package:flutter_seoul/utils/themes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_seoul/widgets/model_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.isDark ? Themes.dark : Themes.light,
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
          routes: {
            '/': (context) => const Home(),
            '/edit_profile': (context) => const EditProfile(),
            '/sample': (context) => const Sample(),
            '/result': (context) => const Result()
          },
        );
      }),
    );
  }
}
