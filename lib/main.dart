import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/app_constants.dart';
import 'firebase_options.dart';
import 'config/themes.dart';
import 'core/di/injection_container.dart';
import 'gen/l10n/app_localizations.dart';
import 'providers/settings_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';
import 'services/preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    // Auth persistence is automatic on mobile; setPersistence is web-only.
    if (kIsWeb) {
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    }
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  await configureDependencies();

  final preferencesService = PreferencesService();
  await preferencesService.init();

  runApp(
    ProviderScope(
      overrides: [
        preferencesServiceProvider.overrideWithValue(preferencesService),
      ],
      child: const MobileShopApp(),
    ),
  );
}

class MobileShopApp extends ConsumerWidget {
  const MobileShopApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'Mobile Shop POS',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: AppConstants.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (deviceLocale != null) {
          for (final supported in supportedLocales) {
            if (supported.languageCode == deviceLocale.languageCode) {
              return supported;
            }
          }
        }
        return supportedLocales.first;
      },
      themeMode: themeMode,
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      home: const SplashScreen(),
    );
  }
}
