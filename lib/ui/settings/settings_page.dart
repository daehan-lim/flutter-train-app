import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_colors.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';
import 'package:flutter_train_app/util/util.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/constants/app_strings.dart';

class SettingsPage extends StatelessWidget {
  final Brightness brightness;
  final Function(ThemeMode) onThemeChanged;

  const SettingsPage({
    super.key,
    required this.brightness,
    required this.onThemeChanged,
  });


  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'penjan.eng@gmail.com',
      queryParameters: {AppStrings.subject: AppStrings.emailBody},
    );

    // First, try opening the default email app
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      // If no email app, open browser-based mail client (Gmail)
      final fallbackUrl = Uri.parse(
        'https://mail.google.com/mail/?view=cm&fs=1'
        '&to=${AppStrings.devEmail}&su=${Uri.encodeComponent(AppStrings.emailBody)}',
      );
      if (await canLaunchUrl(fallbackUrl)) {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      } else {
        // No browser found either
        showAppSnackBar(context, AppStrings.emailSendFail);
      }
    }
  }

  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.chooseTheme,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor),
                ListTile(
                  title: const Text(AppStrings.lightMode),
                  leading: const Icon(Icons.light_mode),
                  trailing:
                      brightness == Brightness.light
                          ? Icon(
                            Icons.check_circle,
                            color: AppColors.getCheckIconColor(context),
                          )
                          : null,
                  onTap: () {
                    onThemeChanged(ThemeMode.light);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(AppStrings.darkMode),
                  leading: const Icon(Icons.dark_mode),
                  trailing:
                      brightness == Brightness.dark
                          ? Icon(
                            Icons.check_circle,
                            color: AppColors.getCheckIconColor(context),
                          )
                          : null,
                  onTap: () {
                    onThemeChanged(ThemeMode.dark);
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text(AppStrings.appTheme, style: AppStyles.mediumText),
            tiles: [
              SettingsTile(
                leading: const Icon(Icons.brightness_4),
                title: const Text(AppStrings.themeMode),
                value: Text(
                  brightness == Brightness.dark
                      ? AppStrings.darkMode
                      : AppStrings.lightMode,
                ),
                onPressed: (context) => _showThemeBottomSheet(context),
              ),
            ],
          ),
          SettingsSection(
            title: const Text(AppStrings.info, style: AppStyles.mediumText),
            tiles: [
              SettingsTile(
                leading: const Icon(Icons.email),
                title: const Text(AppStrings.contactDev),
                onPressed: (context) => _launchEmail(context),
              ),
              SettingsTile(
                leading: const Icon(Icons.info_outline),
                title: const Text(AppStrings.version),
                value: const Text(AppStrings.versionCode),
                onPressed: (_) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
