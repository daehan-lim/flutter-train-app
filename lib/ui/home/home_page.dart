import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';
import 'package:flutter_train_app/ui/station_list/station_list_page.dart';
import 'package:flutter_train_app/ui/seat/seat_page.dart';
import 'package:flutter_train_app/util/util.dart';
import 'package:flutter_train_app/widgets/app_menu.dart';

import '../../app/constants/app_colors.dart';

/// A stateful widget that displays the home page of the train reservation app.
///
/// This page allows users to select departure and arrival stations, and navigate
/// to the seat selection page. It also provides access to theme and language settings.
class HomePage extends StatefulWidget {
  /// Callback function to update the app's theme mode
  final Function(ThemeMode) updateThemeMode;
  final void Function(String lang) updateLanguage;

  const HomePage({
    super.key,
    required this.updateThemeMode,
    required this.updateLanguage,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _arrivalStation;
  String? _departureStation;

  /// Navigates to the station selection screen and updates the selected station.
  ///
  /// [isDeparture] determines whether the user is selecting a departure station (true)
  /// or an arrival station (false).
  void _selectStation({required bool isDeparture}) async {
    final String title =
        isDeparture
            ? strings(context).departureStation
            : strings(context).arrivalStation;
    final String? otherStation =
        isDeparture ? _arrivalStation : _departureStation;

    final String? selectedStation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                StationListPage(pageTitle: title, otherStation: otherStation),
      ),
    );

    if (selectedStation != null) {
      setState(() {
        if (isDeparture) {
          _departureStation = selectedStation;
        } else {
          _arrivalStation = selectedStation;
        }
      });
    }
  }

  /// Builds a station selector widget that displays the station type and selected station.
  ///
  /// [isDeparture] determines whether this is for departure station (true)
  /// or arrival station (false).
  ///
  /// Returns a tappable widget that shows the station type and current selection
  Widget _buildStationSelector({required bool isDeparture}) {
    final String title =
        isDeparture
            ? strings(context).departureStation
            : strings(context).arrivalStation;
    final String? selectedStation =
        isDeparture ? _departureStation : _arrivalStation;

    return Material(
      child: InkWell(
        highlightColor: Colors.grey.withValues(alpha: 0.3),
        // splashColor: Colors.grey.withValues(alpha: 0.4),
        onTap: () => _selectStation(isDeparture: isDeparture),
        child: SizedBox(
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: AppStyles.arrivalDepartureText),
              Text(
                selectedStation ?? strings(context).select,
                style: AppStyles.getSelectedStationText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getScaffoldBackgroundHome(context),
      appBar: AppBar(
        title: Text(strings(context).trainReservation),
        actions: [
          AppMenu(
            updateThemeMode: widget.updateThemeMode,
            updateLanguage: widget.updateLanguage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStationSelector(isDeparture: true), // departure
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      width: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  _buildStationSelector(isDeparture: false), // arrival
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_departureStation != null && _arrivalStation != null) {
                  bool? bookSuccessful = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => SeatPage(
                            departureStation: _departureStation!,
                            arrivalStation: _arrivalStation!,
                          ),
                    ),
                  );
                  if (bookSuccessful == true) {
                    showAppSnackBar(context, strings(context).seatBookSuccess);
                  }
                } else {
                  showAppCupertinoDialog(
                    context: context,
                    title: strings(context).notice,
                    content: strings(context).selectDepartureArrivalMessage,
                  );
                }
              },
              child: Text(
                strings(context).selectSeat,
                style: AppStyles.buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
