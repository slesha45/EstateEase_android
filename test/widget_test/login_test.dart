import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LoginView Widget Tests", () {
    testWidgets('renders LoginView', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that the LoginView is rendered
      expect(find.byType(LoginView), findsOneWidget);
    });

    testWidgets('displays email and password text fields', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that the email and password fields are displayed
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Enter your email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });
  });

  testWidgets('navigates to RegisterView when Sign Up is tapped',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Tap on the 'Sign Up' button
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    // Verify that the RegisterView is now present
    expect(find.byType(RegisterView), findsOneWidget);
  });

   testWidgets('shows validation error if email and password are invalid', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Clear the email and password fields
      await tester.enterText(find.byType(TextFormField).at(0), 'invalid_email');
      await tester.enterText(find.byType(TextFormField).at(1), '123');

      // Tap on the Sign In button
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      // Verify that validation errors are shown
      expect(find.text('Please enter a valid email'), findsOneWidget);
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });
}
