import 'package:flutter/material.dart';

import '../../../app/constants/app_strings.dart';
import '../../../app/constants/app_styles.dart';
import '../../station_list/station_list_page.dart';

class StationSelectTexts extends StatelessWidget {
  final String departureArrival;

  const StationSelectTexts(this.departureArrival, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StationListPage(departureArrival),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(departureArrival, style: AppStyles.arrivalDepartureText),
          Text(
            AppStrings.select,
            style: AppStyles.getSelectedStationText(context),
          ),
        ],
      ),
    );
  }
}
