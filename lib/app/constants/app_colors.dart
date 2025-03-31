import 'package:flutter/material.dart';

import '../app_theme.dart';

class AppColors {
  // Colors in AppTheme
  static const primary = Color(0xFFFEF8FA);
  static const dividerLight = Color(0xFFBDBDBD); // Colors.grey[400]
  static const dividerDark = Colors.white;
  static const button = Colors.purple;
  static const boxBackgroundDark = Color(0xFF424242);

  // Colors used directly in pages
  static const darkBackground = Color(0xFF161217);
  static const greyBackground = Color(0xFFEEEEEE,); // Same as Colors.grey[200] but constant
  static const listDivider = Color(0xFFE0E0E0); // Colors.grey[300]

  static Color getScaffoldBackgroundHome(BuildContext context) {
    return AppTheme.isDark(context)
        ? AppColors.darkBackground
        : AppColors.greyBackground;
  }

  static Color getSeatBoxUnselected(BuildContext context) {
    return AppTheme.isDark(context)
        ? Color(0xFF5F6161) // Colors.grey[300]
        : Color(0xFFE0E0E0); // Colors.grey[300]
  }

  static Color getMenuBackgroundColor(BuildContext context) {
    return AppTheme.isDark(context)
        ? Color(0xFF202020)
        : Colors.white;
  }
}
