import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_constants.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';

import '../../app/constants/app_colors.dart';

/// Builds a station selector widget that displays the station type and selected station.
///
/// [isDeparture] determines whether this is for departure station (true)
/// or arrival station (false).
///
/// Returns a tappable widget that shows the station type and current selection
class StationListPage extends StatelessWidget {
  final String pageTitle;
  final String? otherStation;
  final List<String> stationNames = List.from(AppConstants.stationNames);

  StationListPage({
    required this.pageTitle,
    required this.otherStation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (otherStation != null) {
      stationNames.remove(otherStation);
    }

    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      body: ListView.builder(
        itemCount: stationNames.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.pop(context, stationNames[index]),
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.listDivider),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  stationNames[index],
                  style: AppStyles.trainStationName,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
