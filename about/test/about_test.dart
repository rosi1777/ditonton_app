import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:about/about.dart';

void main() {
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Description app text should display',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(const AboutPage()));

    expect(find.text(descriptionAboutPage), findsOneWidget);
  });
}
