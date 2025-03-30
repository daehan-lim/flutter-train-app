import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/app_theme.dart';
import 'package:flutter_train_app/app/constants/app_strings.dart';
import 'package:flutter_train_app/app/constants/styles.dart';

import '../../app/constants/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.isDark(context)
              ? AppColors.darkBackground
              : AppColors.greyBackground,
      appBar: AppBar(title: Text(AppStrings.homeTitle)),
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
                  StationSelectTexts(AppStrings.departureStation),
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      width: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  StationSelectTexts(AppStrings.arrivalStation),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppStrings.selectSeat, style: AppStyles.seatSelectButtonText,),
            ),
          ],
        ),
      ),
    );
  }
}

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
