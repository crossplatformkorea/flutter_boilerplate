import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/generated/l10n.dart';
import 'package:flutter_seoul/providers/user_provider.dart';
import 'package:flutter_seoul/utils/router_config.dart';
import 'package:flutter_seoul/utils/themes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_seoul/widgets/model_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "oldValue": "$previousValue",
  "newValue": "$newValue"
}''');
    }
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: '.env');

  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(modelProvider);
    final currentUser = ref.watch(userStateProvider);

    useEffect(() {
      if (!currentUser.isLoading) {
        FlutterNativeSplash.remove();
      }
      return null;
    }, [currentUser.isLoading]);

    if (currentUser.isLoading) {
      return const MaterialApp(
        home: Scaffold(body: SizedBox()),
      );
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: themeNotifier.isDark ? ThemeMode.dark : ThemeMode.light,
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
        routerConfig: routerConfig(
          (currentUser.value != null && currentUser.value!.isNotEmpty)
              ? GoRoutes.home.fullPath
              : GoRoutes.signIn.fullPath,
        ),
      ),
    );
  }
}
