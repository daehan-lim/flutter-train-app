import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<String?> showAppCupertinoDialog({
  required BuildContext context,
  required String title,
  required String content,
  bool showCancel = false,
}) {
  return showCupertinoDialog<String>(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title, style: const TextStyle(fontSize: 20)),
        content: Text(content, style: const TextStyle(fontSize: 15)),
        actions: [
          if (showCancel)
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context, strings(context).cancel),
              child: Text(
                strings(context).cancel,
                style: TextStyle(color: Colors.red, fontSize: 17),
              ),
            ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, strings(context).confirm),
            child: Text(
              strings(context).confirm,
              style: TextStyle(color: Colors.blue, fontSize: 17),
            ),
          ),
        ],
      );
    },
  );
}

void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 4),
    ),
  );
}

AppLocalizations strings(BuildContext context) {
  return AppLocalizations.of(context)!;
}
