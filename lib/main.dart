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

  void updateThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
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
      locale: const Locale('ko'),
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
      home: HomePage(updateThemeMode: updateThemeMode),
    );
  }
}
