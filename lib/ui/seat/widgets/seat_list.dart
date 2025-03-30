import 'package:flutter/material.dart';
import 'package:flutter_train_app/ui/seat/widgets/seat_boxes.dart';

import '../../../app/constants/app_styles.dart';

class SeatList extends StatelessWidget {
  final int? selectedRow;
  final int? selectedCol;
  final void Function(int _, int _) onSeatSelected;

  const SeatList({
    required this.selectedRow,
    required this.selectedCol,
    required this.onSeatSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildAlphaNumBox('A'),
                SizedBox(width: 4),
                buildAlphaNumBox('B'),
                SizedBox(width: 4),
                buildAlphaNumBox(''),
                SizedBox(width: 4),
                buildAlphaNumBox('C'),
                SizedBox(width: 4),
                buildAlphaNumBox('D'),
              ],
            ),
            for (var i = 1; i <= 20; i++) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getSeatBox(row: i, col: 1, context: context),
                  SizedBox(width: 4),
                  getSeatBox(row: i, col: 2, context: context),
                  SizedBox(width: 4),
                  buildAlphaNumBox(i.toString()),
                  SizedBox(width: 4),
                  getSeatBox(row: i, col: 3, context: context),
                  SizedBox(width: 4),
                  getSeatBox(row: i, col: 4, context: context),
                ],
              ),
              SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }

  Widget getSeatBox({required int row, required int col, required BuildContext context}) {
    bool selected = row == selectedRow && col == selectedCol;
    return GestureDetector(
      onTap: () => onSeatSelected(row, col),
      child: buildSeatBox(
        selected: selected,
        dimension: AppStyles.bigSeatBoxDimension,
        context: context
      ),
    );
  }
}
