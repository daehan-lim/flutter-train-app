import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_strings.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';

import '../../app/constants/app_colors.dart';

class StationListPage extends StatelessWidget {
  final String pageTitle;
  List<String> stationNames = AppStrings.stationNames;

  StationListPage(this.pageTitle, {super.key});

  @override
  Widget build(BuildContext context) {
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
                border: Border(bottom: BorderSide(color: AppColors.listDivider)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(stationNames[index], style: AppStyles.trainStationName),
              ),
            ),
          );
        },
      ),
    );
  }
}
