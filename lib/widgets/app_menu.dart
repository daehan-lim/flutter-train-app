import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_constants.dart';
import 'package:flutter_train_app/ui/korail/korail_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/constants/app_colors.dart';
import '../app/constants/app_styles.dart';
import '../ui/settings/settings_page.dart';
import '../util/util.dart';

class AppMenu extends StatelessWidget {
  final void Function(ThemeMode _) updateThemeMode;
  final void Function(String lang) updateLanguage;
  final bool isWebViewOpened;

  const AppMenu({
    required this.updateThemeMode,
    required this.updateLanguage,
    this.isWebViewOpened = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.getMenuBackgroundColor(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      onSelected: (value) async {
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
        } else if (value == 'webview') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => KorailPage(
                    updateThemeMode: updateThemeMode,
                    updateLanguage: updateLanguage,
                  ),
            ),
          );
        } else if (value == 'website') {
          final url = Uri.parse(AppConstants.korailUrl);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        }
      },
      icon: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(CupertinoIcons.ellipsis_circle),
      ),
      itemBuilder:
          (BuildContext context) => [
            if (!isWebViewOpened)
              buildMenuItem(
                value: 'webview',
                label: strings(context).korailBook,
                icon: Icons.web,
              )
            else
              buildMenuItem(
                value: 'website',
                label: strings(context).openWebsite,
                icon: Icons.public,
              ),
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
            Text(label, style: TextStyle(fontSize: 17)),
            Icon(icon, size: 20),
          ],
        ),
      ),
    );
  }
}
