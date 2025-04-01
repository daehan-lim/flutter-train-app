import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_colors.dart';

import '../../../app/constants/app_styles.dart';

/// Creates a styled seat box widget with proper coloring based on selection state.
///
/// [selected] determines if the seat box should appear selected (highlighted)
/// [dimension] controls the size of the squared seat box
Widget buildSeatBox({
  required bool selected,
  required double dimension,
  required BuildContext context,
}) {
  return Container(
    width: dimension,
    height: dimension,
    decoration: BoxDecoration(
      color: selected ? Colors.purple : AppColors.getSeatBoxUnselected(context),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

/// Creates a box widget displaying row numbers or column letters in the seat selection grid.
///
/// [label] is the text to display (row number, column letter, or empty string)
Widget buildAlphaNumBox(String label) {
  return Container(
    alignment: Alignment.center,
    width: AppStyles.bigSeatBoxDimension,
    height: AppStyles.bigSeatBoxDimension,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    child: Text(label, style: TextStyle(fontSize: 18)),
  );
}
