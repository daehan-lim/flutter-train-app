import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/app_theme.dart';
import 'package:flutter_train_app/ui/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train Tickets',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.buildTheme(Brightness.light),
      darkTheme: AppTheme.buildTheme(Brightness.dark),
      home: const HomePage(),
    );
  }
}