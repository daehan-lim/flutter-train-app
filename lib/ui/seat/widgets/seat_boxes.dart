import 'package:flutter/material.dart';

import '../../../app/constants/app_styles.dart';

Widget buildSeatBox({required bool selected, required double dimension}) {
  return Container(
    width: dimension,
    height: dimension,
    decoration: BoxDecoration(
      color: selected ? Colors.purple : Colors.grey[300],
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

Widget buildAlphaNumBox(String label) {
  return Container(
    alignment: Alignment.center,
    width: AppStyles.bigSeatBoxDimension,
    height: AppStyles.bigSeatBoxDimension,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    child: Text(label, style: TextStyle(fontSize: 18)),
  );
}