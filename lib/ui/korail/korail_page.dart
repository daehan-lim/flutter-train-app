import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/util.dart';

class KorailPage extends StatelessWidget {
  const KorailPage({super.key});

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
      appBar: AppBar(title: Text(strings(context).korailBook)),
      body: WebViewWidget(controller: controller),
    );
  }
}
