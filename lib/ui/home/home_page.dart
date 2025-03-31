import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_strings.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';
import 'package:flutter_train_app/ui/station_list/station_list_page.dart';
import 'package:flutter_train_app/ui/seat/seat_page.dart';
import 'package:flutter_train_app/util/util.dart';

import '../../app/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _arrivalStation;
  String? _departureStation;

  void _selectStation({required bool isDeparture}) async {
    final String title =
        isDeparture ? AppStrings.departureStation : AppStrings.arrivalStation;
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

  Widget _buildStationSelector({required bool isDeparture}) {
    final String title =
        isDeparture ? AppStrings.departureStation : AppStrings.arrivalStation;
    final String? selectedStation =
        isDeparture ? _departureStation : _arrivalStation;

    return GestureDetector(
      onTap: () => _selectStation(isDeparture: isDeparture),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppStyles.arrivalDepartureText),
          Text(
            selectedStation ?? AppStrings.select,
            style: AppStyles.getSelectedStationText(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getScaffoldBackgroundHome(context),
      appBar: AppBar(
        title: Text(AppStrings.trainReservation),
        actions: [
          PopupMenuButton<String>(
            color: AppColors.getMenuBackgroundColor(context),
            onSelected: (_) {},
            icon: Icon(CupertinoIcons.ellipsis_circle), // iOS-style icon
            itemBuilder:
                (BuildContext context) => [
                  buildMenuItem(
                    value: 'webview',
                    label: '코레일 예약',
                    icon: Icons.web,
                  ),
                  // PopupMenuDivider(),
                  // buildMenuItem(
                  //   value: 'website',
                  //   label: '웹사이트 열기',
                  //   icon: Icons.public,
                  // ),
                  PopupMenuDivider(),
                  buildMenuItem(
                    value: 'settings',
                    label: '설정',
                    icon: Icons.settings,
                  ),
                ],
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
                    showAppSnackBar(context, AppStrings.seatBookSuccess);
                  }
                } else {
                  showAppCupertinoDialog(
                    context: context,
                    title: AppStrings.notice,
                    content: AppStrings.selectDepartureArrivalMessage,
                  );
                }
              },
              child: Text(AppStrings.selectSeat, style: AppStyles.buttonText),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> buildMenuItem({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return PopupMenuItem(
      value: value,
      height: AppStyles.menuItemHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
          Icon(icon, size: 20),
        ],
      ),
    );
  }
}
