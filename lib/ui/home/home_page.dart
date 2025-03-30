import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_strings.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';
import 'package:flutter_train_app/ui/home/widgets/station_select_texts.dart';
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

  void updateArrivalStation(String station) {
    _arrivalStation = station;
  }

  void updateDepartureStation(String station) {
    _departureStation = station;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getScaffoldBackgroundHome(context),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppStrings.seatBookSuccess,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 4),
                      ),
                    );
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
}
