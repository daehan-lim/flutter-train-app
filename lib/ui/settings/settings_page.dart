import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_colors.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';
import 'package:flutter_train_app/util/util.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  final Brightness brightness;
  final Function(ThemeMode) onThemeChanged;

  final String language;
  final Function(String) onLanguageChanged;

  const SettingsPage({
    super.key,
    required this.brightness,
    required this.onThemeChanged,
    required this.language,
    required this.onLanguageChanged,
  });

  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'penjan.eng@gmail.com',
      queryParameters: {strings(context).subject: strings(context).emailBody},
    );

    // First, try opening the default email app
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      // If no email app, open browser-based mail client (Gmail)
      final fallbackUrl = Uri.parse(
        'https://mail.google.com/mail/?view=cm&fs=1'
        '&to=${strings(context).devEmail}&su=${Uri.encodeComponent(strings(context).emailBody)}',
      );
      if (await canLaunchUrl(fallbackUrl)) {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      } else {
        // No browser found either
        showAppSnackBar(context, strings(context).emailSendFail);
      }
    }
  }

  void _showThemeBottomSheet(BuildContext context) {
    showOptionsBottomSheet(
      context: context,
      title: strings(context).chooseTheme,
      option1Text: strings(context).lightMode,
      option2Text: strings(context).darkMode,
      option1Icon: const Icon(Icons.light_mode),
      option2Icon: const Icon(Icons.dark_mode),
      selectedIndex: brightness == Brightness.light ? 0 : 1,
      onOption1Tap: () => onThemeChanged(ThemeMode.light),
      onOption2Tap: () => onThemeChanged(ThemeMode.dark),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showOptionsBottomSheet(
      context: context,
      title: strings(context).chooseLanguage,
      option1Text: strings(context).korean,
      option2Text: strings(context).english,
      option1Icon: const Text('🇰🇷', style: TextStyle(fontSize: 24)),
      option2Icon: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
      selectedIndex: language == 'ko' ? 0 : 1,
      onOption1Tap: () => onLanguageChanged('ko'),
      onOption2Tap: () => onLanguageChanged('en'),
    );
  }


  void showOptionsBottomSheet({
    required BuildContext context,
    required String title,
    required String option1Text,
    required String option2Text,
    required Widget option1Icon,
    required Widget option2Icon,
    required VoidCallback onOption1Tap,
    required VoidCallback onOption2Tap,
    required int selectedIndex, // 0 or 1
  }) {
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
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 5),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor),
                ListTile(
                  title: Text(option1Text),
                  leading: option1Icon,
                  trailing: selectedIndex == 0
                      ? Icon(
                    Icons.check_circle,
                    color: AppColors.getCheckIconColor(context),
                  )
                      : null,
                  onTap: () {
                    onOption1Tap();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(option2Text),
                  leading: option2Icon,
                  trailing: selectedIndex == 1
                      ? Icon(
                    Icons.check_circle,
                    color: AppColors.getCheckIconColor(context),
                  )
                      : null,
                  onTap: () {
                    onOption2Tap();
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8),
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
      appBar: AppBar(title: Text(strings(context).settings)),
      body: SettingsList(
        sections: [
          SettingsSection(
            // margin: EdgeInsetsDirectional.only(start: 18, end: 18, top: 7, bottom: 7),
            title: Text(strings(context).appSettings, style: AppStyles.mediumText),
            tiles: [
              SettingsTile(
                leading: const Icon(Icons.brightness_4),
                title: Text(strings(context).themeMode),
                value: Text(
                  brightness == Brightness.dark
                      ? strings(context).darkMode
                      : strings(context).lightMode,
                  style: AppStyles.settingsValue,
                ),
                onPressed: (context) => _showThemeBottomSheet(context),
              ),
              SettingsTile(
                leading: Icon(Icons.language),
                title: Text(strings(context).language),
                value: Text(
                  language == 'ko'
                      ? strings(context).korean
                      : strings(context).english,
                  style: AppStyles.settingsValue,
                ),
                onPressed: (context) => _showLanguageBottomSheet(context),
              ),
            ],
          ),
          SettingsSection(
            // margin: EdgeInsetsDirectional.only(start: 18, end: 18, top: 7, bottom: 7),
            title: Text(strings(context).info, style: AppStyles.mediumText),
            tiles: [
              SettingsTile(
                leading: const Icon(Icons.email),
                title: Text(strings(context).contactDev),
                onPressed: (context) => _launchEmail(context),
              ),
              SettingsTile(
                leading: const Icon(Icons.info_outline),
                title: Text(strings(context).version),
                value: Text(strings(context).versionCode),
                onPressed: (_) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
