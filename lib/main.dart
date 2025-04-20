import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/app_theme.dart';
import 'package:flutter_train_app/ui/home/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  String _language = 'ko';

  /// Updates the application theme mode.
  ///
  /// [mode] The new ThemeMode to apply (light, dark, or system)
  void updateThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  /// Updates the application language.
  ///
  /// [lang] The language code to switch to ('en' or 'ko')
  void updateLanguage(String lang) {
    setState(() {
      _language = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train Tickets',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.buildTheme(Brightness.light),
      darkTheme: AppTheme.buildTheme(Brightness.dark),
      locale: Locale(_language),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ko'), // Korean
        Locale('en'), // English
      ],
      home: HomePage(
        updateThemeMode: updateThemeMode,
        updateLanguage: updateLanguage,
      ),
    );
  }
}

/*
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final settings = ref.watch(settingsProvider);

        return MaterialApp(
          title: 'Train Tickets',
          debugShowCheckedModeBanner: false,
          themeMode: settings.themeMode,
          theme: AppTheme.buildTheme(Brightness.light),
          darkTheme: AppTheme.buildTheme(Brightness.dark),
          locale: Locale(settings.language),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko'),
            Locale('en'),
          ],
          home: child, // uses prebuilt child
        );
      },
      child: const HomePage(), // avoids rebuilding this
    );
  }
}

 */