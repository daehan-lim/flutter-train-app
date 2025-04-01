import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app/constants/app_colors.dart';
import '../app/constants/app_styles.dart';
import '../ui/settings/settings_page.dart';
import '../util/util.dart';

class AppMenu extends StatelessWidget {
  final void Function(ThemeMode _) updateThemeMode;
  final void Function(String lang) updateLanguage;

  const AppMenu({
    required this.updateThemeMode,
    required this.updateLanguage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.getMenuBackgroundColor(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      onSelected: (value) {
        if (value == 'settings') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => SettingsPage(
                    brightness: Theme.of(context).brightness,
                    onThemeChanged: updateThemeMode,
                    language: Localizations.localeOf(context).languageCode,
                    onLanguageChanged: updateLanguage,
                  ),
            ),
          );
        }
        // Handle other menu items...
      },
      icon: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(CupertinoIcons.ellipsis_circle),
      ),
      itemBuilder:
          (BuildContext context) => [
            buildMenuItem(
              value: 'webview',
              label: strings(context).korailBook,
              icon: Icons.web,
            ),
            // PopupMenuDivider(),
            // buildMenuItem(
            //   value: 'website',
            //   label: '웹사이트 열기',
            //   icon: Icons.public,
            // ),
            // PopupMenuDivider(),
            buildMenuItem(
              value: 'settings',
              label: strings(context).settings,
              icon: Icons.settings,
            ),
          ],
    );
  }

  PopupMenuItem<String> buildMenuItem({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return PopupMenuItem(
      value: value,
      height: AppStyles.menuItemHeight,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 18)),
            Icon(icon, size: 20),
          ],
        ),
      ),
    );
  }
}
