import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/app_theme.dart';

class AppStyles {
  static const arrivalDepartureText = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
  );

  static const seatSelectButtonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  static const trainStationName = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
  );

  static getSelectedStationText(BuildContext context) {
    return TextStyle(
      fontSize: 40,
      color: AppTheme.isDark(context) ? Colors.white : Colors.black,
    );
  }
}
