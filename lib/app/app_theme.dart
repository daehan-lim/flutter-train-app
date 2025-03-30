import 'package:flutter/material.dart';

import 'constants/app_colors.dart';

class AppTheme {
  static ThemeData buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final outlineColor = isDark ? Colors.white38 : Colors.black38;
    final outlinedBorderColor = isDark ? Colors.white30 : Colors.black;
    final textColor = isDark ? Colors.white : Colors.black;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        outline: outlineColor,
      ).copyWith(primary: AppColors.primary),
      highlightColor: AppColors.primary,
    );
  }

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
