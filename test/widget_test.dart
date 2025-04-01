import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_train_app/main.dart';
import 'package:flutter_train_app/app/constants/app_constants.dart';

void main() {
  group('Train booking flow test', () {
    testWidgets(
      'Complete booking flow - station selection to seat confirmation',
      (WidgetTester tester) async {
        // Launch the app
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();

        // Verify home page loaded properly
        expect(find.text('기차 예매'), findsOneWidget);
        expect(find.text('선택'), findsExactly(2));

        // Step 1: Select departure station
        await tester.tap(find.text('출발역').first);
        await tester.pumpAndSettle();

        // Verify station list page opened for departure
        expect(find.text('출발역'), findsOneWidget);

        // Select first station as departure station
        final departureStation = AppConstants.stationNames[0];
        await tester.tap(find.text(departureStation));
        await tester.pumpAndSettle();

        // Verify we're back on home page with the departure station selected
        expect(find.text(departureStation), findsOneWidget);

        // Step 2: Select arrival station
        await tester.tap(find.text('도착역').first);
        await tester.pumpAndSettle();

        // Verify station list page opened for arrival
        expect(find.text('도착역'), findsOneWidget);

        // Select last station as arrival station (should be different from departure)
        final arrivalStation = AppConstants.stationNames.last;
        await tester.tap(find.text(arrivalStation));
        await tester.pumpAndSettle();

        // Verify we're back on home page with both stations selected
        expect(find.text(departureStation), findsOneWidget);
        expect(find.text(arrivalStation), findsOneWidget);

        // Step 3: Tap the seat selection button
        await tester.tap(find.text('좌석 선택'));
        await tester.pumpAndSettle();

        // Verify seat page loaded properly
        expect(find.text('좌석 선택'), findsOneWidget);
        expect(find.text(departureStation), findsOneWidget);
        expect(find.text(arrivalStation), findsOneWidget);

        // Step 4: Select a seat (row 5, column A)
        // Find the first seat box in row 5
        final rowFinder = find.text('5');
        expect(rowFinder, findsOneWidget);

        // Get the row container
        final rowContainer =
            find.ancestor(of: rowFinder, matching: find.byType(Row)).first;

        // Find the first seat in that row (seat A)
        final seatA = tester.widget<GestureDetector>(
          find
              .descendant(
                of: rowContainer,
                matching: find.byType(GestureDetector),
              )
              .first,
        );

        // Tap on that seat
        await tester.tap(find.byWidget(seatA));
        await tester.pumpAndSettle();

        // Step 5: Tap the booking button
        await tester.tap(find.text('예매 하기'));
        await tester.pumpAndSettle();

        // Verify confirmation dialog appears
        expect(find.text('확인'), findsOneWidget);
        expect(find.text('취소'), findsOneWidget);

        // Find seat confirmation text using pattern
        expect(find.textContaining('좌석:'), findsOneWidget);

        // Confirm booking
        await tester.tap(find.text('확인'));
        await tester.pumpAndSettle();

        // Verify we're back at the home page
        expect(find.text('기차 예매'), findsOneWidget);

        // Look for success message
        expect(find.text('좌석이 성공적으로 예약되었습니다.'), findsOneWidget);
      },
    );

    testWidgets('Prevents booking without station selection', (
      WidgetTester tester,
    ) async {
      // Launch the app
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Try to navigate to seat page without selecting stations
      await tester.tap(find.text('좌석 선택'));
      await tester.pumpAndSettle();

      // Verify error dialog appears
      expect(find.text('알림'), findsOneWidget);
      expect(find.text('출발역과 도착역을 모두 선택해주세요.'), findsOneWidget);
    });
  });
}
