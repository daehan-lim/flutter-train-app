import 'package:flutter/material.dart';

import 'constants/app_colors.dart';

class AppTheme {
  static ThemeData buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final outlineColor = isDark ? Colors.white38 : Colors.black38;
    final surfaceColor = isDark ? AppColors.boxBackgroundDark : Colors.white;
    final dividerColor =
        isDark ? AppColors.dividerDark : AppColors.dividerLight;
    final appBarColor = isDark ? AppColors.darkBackground : AppColors.primary;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        outline: outlineColor,
        surface: surfaceColor,
      ).copyWith(primary: AppColors.primary),
      highlightColor: AppColors.primary,
      dividerColor: dividerColor,

      appBarTheme: AppBarTheme(backgroundColor: appBarColor),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.button,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 12),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
