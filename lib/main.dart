import 'package:flutter/material.dart';
import 'package:flutter_seoul/generated/l10n.dart';
import 'package:flutter_seoul/utils/router_config.dart';
import 'package:flutter_seoul/utils/themes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_seoul/widgets/model_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(modelProvider);

    return MaterialApp.router(
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
      routerConfig: routerConfig,
    );
  }
}
