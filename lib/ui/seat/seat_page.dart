import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_strings.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';
import 'package:flutter_train_app/ui/seat/widgets/seat_boxes.dart';
import 'package:flutter_train_app/ui/seat/widgets/seat_list.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage(this.departureStation, this.arrivalStation, {super.key});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  int? selectedRow;
  int? selectedCol;

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
      appBar: AppBar(title: Text(AppStrings.selectSeat)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.departureStation,
                  style: AppStyles.arrivalDepartureTextSeat,
                ),
                Icon(Icons.arrow_circle_right_outlined, size: 30),
                Text(widget.arrivalStation, style: AppStyles.arrivalDepartureTextSeat),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSeatBox(
                  selected: true,
                  dimension: AppStyles.smallSeatBoxDimension,
                ),
                SizedBox(width: 4),
                Text(AppStrings.selected),
                SizedBox(width: 20),
                buildSeatBox(
                  selected: false,
                  dimension: AppStyles.smallSeatBoxDimension,
                ),
                SizedBox(width: 4),
                Text(AppStrings.selected),
              ],
            ),
            SeatList(selectedRow: selectedRow, selectedCol: selectedCol, onSeatSelected: onSeatSelected),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppStrings.book, style: AppStyles.buttonText),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
