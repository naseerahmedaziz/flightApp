import 'package:flutter_test/flutter_test.dart';
import '../lib/Screens/FlightBookingPage.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('FlightBookingPage displays the correct UI',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FlightBookingPage()));

    // Verify that the app bar is displayed
    expect(find.byType(AppBar), findsOneWidget);

    // Verify that the text fields are displayed
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Verify that the search button is displayed
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify that the bottom navigation bar is displayed
    expect(find.byType(BottomAppBar), findsOneWidget);
  });

  testWidgets('FlightBookingPage updates flyingFrom and flyingTo variables',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FlightBookingPage()));

    // Tap on the "Flying From" text field and enter a value
    await tester.tap(find.widgetWithText(TextFormField, 'Flying From'));
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Flying From'), 'New York');
    await tester.pump();

    // Verify that the flyingFrom variable is updated
    final flightBookingPageState =
        tester.state<FlightBookingPageState>(find.byType(FlightBookingPage));
    expect(flightBookingPageState.flyingFrom, 'New York');

    // Tap on the "Flying To" text field and enter a value
    await tester.tap(find.widgetWithText(TextFormField, 'Flying To'));
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Flying To'), 'London');
    await tester.pump();

    // Verify that the flyingTo variable is updated
    expect(flightBookingPageState.flyingTo, 'London');
  });
}
