import 'package:flutter/material.dart';

import '../../../app/constants/app_strings.dart';
import '../../../app/constants/app_styles.dart';

class StationSelectTexts extends StatelessWidget {
  final String departureArrival;

  const StationSelectTexts(this.departureArrival, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(departureArrival, style: AppStyles.arrivalDepartureText),
        Text(AppStrings.select, style: AppStyles.getSelectedStationText(context)),
      ],
    );
  }
}