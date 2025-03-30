import 'package:flutter/material.dart';

import '../../../app/constants/app_strings.dart';
import '../../../app/constants/app_styles.dart';
import '../../station_list/station_list_page.dart';

class StationSelectTexts extends StatefulWidget {
  final String departureArrival;

  const StationSelectTexts(this.departureArrival, {super.key});

  @override
  State<StationSelectTexts> createState() => _StationSelectTextsState();
}

class _StationSelectTextsState extends State<StationSelectTexts> {
  String? _selectedStation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final String? selectedStation = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StationListPage(widget.departureArrival),
          ),
        );
        if (selectedStation != null) {
          setState(() {
            _selectedStation = selectedStation;
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.departureArrival, style: AppStyles.arrivalDepartureText),
          Text(
            _selectedStation ?? AppStrings.select,
            style: AppStyles.getSelectedStationText(context),
          ),
        ],
      ),
    );
  }
}
