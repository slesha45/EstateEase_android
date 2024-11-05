import 'package:final_assignment/features/booking/presentation/view/booking_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    testWidgets('renders BookingView', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: BookingView('property123'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that the BookingView is rendered
      expect(find.byType(BookingView), findsOneWidget);
    });

    testWidgets('displays all text fields', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: BookingView('property123'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that all the text fields are displayed
      expect(find.byType(TextFormField), findsNWidgets(5));
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Phone'), findsOneWidget);
      expect(find.text('Preferred Date'), findsOneWidget);
      expect(find.text('Preferred Time'), findsOneWidget);
    });

    testWidgets('shows validation error if fields are invalid', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: BookingView('property123'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Clear the fields and input invalid data
      await tester.enterText(find.byType(TextFormField).at(0), ''); // Name
      await tester.enterText(find.byType(TextFormField).at(1), ''); // Email
      await tester.enterText(find.byType(TextFormField).at(2), ''); // Phone
      await tester.enterText(find.byType(TextFormField).at(3), ''); // Date
      await tester.enterText(find.byType(TextFormField).at(4), ''); // Time

      // Tap on the Submit Booking button
      await tester.tap(find.text('Submit Booking'));
      await tester.pumpAndSettle();

      // Verify that validation errors are shown
      expect(find.text('Please enter your name'), findsOneWidget);
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your phone number'), findsOneWidget);
      expect(find.text('Please select a preferred date'), findsOneWidget);
      expect(find.text('Please select a preferred time'), findsOneWidget);
    });
}
