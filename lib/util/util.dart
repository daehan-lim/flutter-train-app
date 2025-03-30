import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app/constants/app_strings.dart';

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
              onPressed: () => Navigator.pop(context, AppStrings.cancel),
              child: Text(
                AppStrings.cancel,
                style: TextStyle(color: Colors.red, fontSize: 17),
              ),
            ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, AppStrings.confirm),
            child: Text(
              AppStrings.confirm,
              style: TextStyle(color: Colors.blue, fontSize: 17),
            ),
          ),
        ],
      );
    },
  );
}
