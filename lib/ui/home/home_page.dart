import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/app_theme.dart';
import 'package:flutter_train_app/app/constants/app_strings.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';
import 'package:flutter_train_app/ui/home/widgets/station_select_texts.dart';
import 'package:flutter_train_app/ui/station_list/station_list_page.dart';

import '../../app/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _arrivalStation;
  String? _departureStation;

  void updateArrivalStation(String station) {
    _arrivalStation = station;
  }

  void updateDepartureStation(String station) {
    _departureStation = station;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.isDark(context)
              ? AppColors.darkBackground
              : AppColors.greyBackground,
      appBar: AppBar(title: Text(AppStrings.trainReservation)),
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
                  StationSelectTexts(
                    AppStrings.departureStation,
                    updateDepartureStation,
                  ),
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      width: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  StationSelectTexts(
                    AppStrings.arrivalStation,
                    updateArrivalStation,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_departureStation != null && _arrivalStation != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              StationListPage(AppStrings.arrivalStation),
                    ),
                  );
                } else {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text(AppStrings.notice, style: TextStyle(fontSize: 20)),
                        content: Text(AppStrings.selectDepartureArrivalMessage, style: TextStyle(fontSize: 15)),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.pop(context),
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
              },
              child: Text(
                AppStrings.selectSeat,
                style: AppStyles.seatSelectButtonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
