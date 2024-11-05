import 'package:final_assignment/features/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders RegisterView', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RegisterView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that the RegisterView is rendered
    expect(find.byType(RegisterView), findsOneWidget);
  });

  testWidgets('displays all text fields', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RegisterView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that all the text fields are displayed
    expect(find.byType(TextFormField), findsNWidgets(6));
    expect(find.text('First name'), findsOneWidget);
    expect(find.text('Last name'), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm password'), findsOneWidget);
  });

testWidgets('submits form with valid data', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter valid data
      await tester.enterText(find.byType(TextFormField).at(0), 'Slesha'); // First name
      await tester.enterText(find.byType(TextFormField).at(1), 'Dahal'); // Last name
      await tester.enterText(find.byType(TextFormField).at(2), 'slesha@gmail.com'); // Email
      await tester.enterText(find.byType(TextFormField).at(3), '9876543211'); // Phone
      await tester.enterText(find.byType(TextFormField).at(4), 'password'); // Password
      await tester.enterText(find.byType(TextFormField).at(5), 'password'); // Confirm Password

      // Tap on the Sign Up button
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      // Verify that no validation errors are shown
      expect(find.text('Please enter your first name'), findsNothing);
      expect(find.text('Please enter a valid email address'), findsNothing);
      expect(find.text('Passwords do not match'), findsNothing);

    });
}
