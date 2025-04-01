import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/util.dart';
import '../../widgets/app_menu.dart';

class KorailPage extends StatelessWidget {
  final void Function(ThemeMode _) updateThemeMode;
  final void Function(String lang) updateLanguage;

  const KorailPage({
    super.key,
    required this.updateThemeMode,
    required this.updateLanguage,
  });

  @override
  Widget build(BuildContext context) {
    var controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onHttpError: (HttpResponseError error) {},
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(
            Uri.parse(
              Localizations.localeOf(context).languageCode == 'ko'
                  ? AppConstants.korailUrl
                  : AppConstants.korailEnglishUrl,
            ),
          );
    return Scaffold(
      appBar: AppBar(
        title: Text(strings(context).korailBook),
        actions: [
          AppMenu(
            updateThemeMode: updateThemeMode,
            updateLanguage: updateLanguage,
            isWebViewOpened: true,
          ),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
