import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:flightapp/Screens/FlightBookingPage.dart';
import 'package:flightapp/Screens/FlightOption.dart';

void main() {
  testWidgets('FlightBookingPage initial state', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: FlightBookingPage()));

    // Verify the initial state of the screen
    expect(find.text('Flight Booking'), findsOneWidget);
    expect(find.text('Book a Trip '), findsOneWidget);
    expect(find.text('   To Your Dreams'), findsOneWidget);
    expect(find.text('Flying From'), findsOneWidget);
    expect(find.text('Flying To'), findsOneWidget);
    expect(find.text('Departure Date'), findsOneWidget);
    expect(find.text('Search Flights'), findsOneWidget);
  });
  
  testWidgets('FlightBookingPage interaction', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: FlightBookingPage()));

    // Tap on the Flying From text field
    await tester.tap(find.byKey(Key('fromTextField')));
    await tester.pumpAndSettle();

    // Verify that the search bottom sheet is shown
    expect(find.text('SearchBottomSheetFrom'), findsOneWidget);

    // Tap on the first item in the search bottom sheet
    await tester.tap(find.text('Item 1'));
    await tester.pumpAndSettle();

    // Verify that the selected flying from value is updated
    expect(find.text('Item 1'), findsOneWidget);

    // Tap on the Flying To text field
    await tester.tap(find.byKey(Key('toTextField')));
    await tester.pumpAndSettle();

    // Verify that the search bottom sheet is shown
    expect(find.text('SearchBottomSheetFrom'), findsOneWidget);

    // Tap on the first item in the search bottom sheet
    await tester.tap(find.text('Item 2'));
    await tester.pumpAndSettle();

    // Verify that the selected flying to value is updated
    expect(find.text('Item 2'), findsOneWidget);

    // Tap on the Departure Date text field
    await tester.tap(find.byKey(Key('departureDateTextField')));
    await tester.pumpAndSettle();

    // Select a date from the date picker
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify that the selected departure date is updated
    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    expect(find.text(formattedDate), findsOneWidget);

    // Tap on the Search Flights button
    await tester.tap(find.text('Search Flights'));
    await tester.pumpAndSettle();

    // Verify that the FlightOptionPage is pushed to the navigator
    expect(find.byType(FlightOptionPage), findsOneWidget);
  });
}
