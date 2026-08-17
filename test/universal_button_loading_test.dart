import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hadith_app/app/core/widgets/universal_button.dart';

void main() {
  testWidgets('shows a loading indicator instead of the label while loading', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UniversalButton(
            onTap: () {},
            title: 'تسجيل الدخول',
            color: Colors.blue,
            textColor: Colors.white,
            borderColor: Colors.blue,
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('تسجيل الدخول'), findsNothing);
  });
}
