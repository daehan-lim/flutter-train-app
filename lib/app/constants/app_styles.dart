import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/app_theme.dart';

class AppStyles {
  //dimensions
  static const double smallSeatBoxDimension = 24;
  static const double bigSeatBoxDimension = 50;
  static const double menuItemHeight = 45;

  static const arrivalDepartureText = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
  );

  static const buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  static const trainStationName = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
  );

  static const arrivalDepartureTextSeat = TextStyle(
    fontSize: 30,
    color: Colors.purple,
    fontWeight: FontWeight.bold,
  );

  static const mediumText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold
  );

  static const settingsValue = TextStyle(
    fontSize: 15
  );

  static getSelectedStationText(BuildContext context) {
    return TextStyle(
      fontSize: 40,
      color: AppTheme.isDark(context) ? Colors.white : Colors.black,
    );
  }
}
