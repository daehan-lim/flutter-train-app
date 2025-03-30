import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/constants/app_strings.dart';
import 'package:flutter_train_app/app/constants/app_styles.dart';

class SeatPage extends StatelessWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage(this.departureStation, this.arrivalStation, {super.key});

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
                  departureStation,
                  style: AppStyles.arrivalDepartureTextSeat,
                ),
                Icon(Icons.arrow_circle_right_outlined, size: 30),
                Text(arrivalStation, style: AppStyles.arrivalDepartureTextSeat),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSeatBox(
                  selected: true,
                  dimension: AppStyles.smallSeatBoxDimension,
                ),
                SizedBox(width: 4),
                Text(AppStrings.selected),
                SizedBox(width: 20),
                _buildSeatBox(
                  selected: false,
                  dimension: AppStyles.smallSeatBoxDimension,
                ),
                SizedBox(width: 4),
                Text(AppStrings.selected),
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAlphaNumBox('A'),
                        SizedBox(width: 4),
                        _buildAlphaNumBox('B'),
                        SizedBox(width: 4),
                        _buildAlphaNumBox(''),
                        SizedBox(width: 4),
                        _buildAlphaNumBox('C'),
                        SizedBox(width: 4),
                        _buildAlphaNumBox('D'),
                      ],
                    ),
                    for (var i = 1; i <= 20; i++) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSeatBox(
                            selected: false,
                            dimension: AppStyles.bigSeatBoxDimension,
                          ),
                          SizedBox(width: 4),
                          _buildSeatBox(
                            selected: false,
                            dimension: AppStyles.bigSeatBoxDimension,
                          ),
                          SizedBox(width: 4),
                          _buildAlphaNumBox(i.toString()),
                          SizedBox(width: 4),
                          _buildSeatBox(
                            selected: false,
                            dimension: AppStyles.bigSeatBoxDimension,
                          ),
                          SizedBox(width: 4),
                          _buildSeatBox(
                            selected: false,
                            dimension: AppStyles.bigSeatBoxDimension,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ],
                ),
              ),
            ),
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

  Widget _buildSeatBox({required bool selected, required double dimension}) {
    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        color: selected ? Colors.purple : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildAlphaNumBox(String label) {
    return Container(
      alignment: Alignment.center,
      width: AppStyles.bigSeatBoxDimension,
      height: AppStyles.bigSeatBoxDimension,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: TextStyle(fontSize: 18)),
    );
  }
}
