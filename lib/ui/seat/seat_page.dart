import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_constants.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';
import 'package:flutter_train_app/ui/seat/widgets/seat_boxes.dart';
import 'package:flutter_train_app/ui/seat/widgets/seat_list.dart';

import '../../util/util.dart';

/// A page that displays the train seating arrangement and allows seat selection.
///
/// This page shows the departure and arrival stations, a legend for seat status,
/// and the seating grid for users to select a seat for booking.
class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    required this.departureStation,
    required this.arrivalStation,
    super.key,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  int? selectedRow;
  int? selectedCol;

  /// Handles the seat selection logic when a seat is tapped.
  ///
  /// Tapping an unselected seat selects it.
  /// Tapping the currently selected seat deselects it.
  ///
  /// [newRow] The row of the tapped seat
  /// [newCol] The column of the tapped seat
  void onSeatSelected(int newRow, int newCol) {
    setState(() {
      if (selectedRow == newRow && selectedCol == newCol) {
        selectedRow = null;
        selectedCol = null;
      } else {
        selectedRow = newRow;
        selectedCol = newCol;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(strings(context).selectSeat)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.departureStation,
                      style: AppStyles.arrivalDepartureTextSeat,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Icon(Icons.arrow_circle_right_outlined, size: 30),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.arrivalStation,
                      style: AppStyles.arrivalDepartureTextSeat,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSeatBox(
                  selected: true,
                  dimension: AppStyles.smallSeatBoxDimension,
                  context: context,
                ),
                SizedBox(width: 4),
                Text(strings(context).selected),
                SizedBox(width: 20),
                buildSeatBox(
                  selected: false,
                  dimension: AppStyles.smallSeatBoxDimension,
                  context: context,
                ),
                SizedBox(width: 4),
                Text(strings(context).selected),
              ],
            ),
            SeatList(
              selectedRow: selectedRow,
              selectedCol: selectedCol,
              onSeatSelected: onSeatSelected,
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedRow != null) {
                  // when row is null, column is also null
                  final String? result = await showAppCupertinoDialog(
                    context: context,
                    title: strings(context).confirmBook,
                    content: strings(context).seatNumber
                        .replaceAll('%d', '$selectedRow')
                        .replaceAll(
                          '%s',
                          AppConstants.colLetters[selectedCol! - 1],
                        ),
                    showCancel: true,
                  );
                  if (result == strings(context).confirm) {
                    Navigator.pop(context, true);
                  }
                }
              },
              child: Text(strings(context).book, style: AppStyles.buttonText),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
