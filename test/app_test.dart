import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_world_is_comics/app.dart';
import 'package:my_world_is_comics/screens/characters/characters.dart';

pumpWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    App(),
  );
}

void main() {
  group('App', () {
    testWidgets('should display a MaterialApp', (WidgetTester tester) async {
      await pumpWidget(tester);

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should set app title to "My World Is Comics"',
        (WidgetTester tester) async {
      await pumpWidget(tester);

      MaterialApp app = find.byType(MaterialApp).evaluate().first.widget;
      expect(app.title, 'My World Is Comics');
    });

    testWidgets('should set theme primary color to red',
        (WidgetTester tester) async {
      await pumpWidget(tester);

      MaterialApp app = find.byType(MaterialApp).evaluate().first.widget;
      expect(app.theme.primaryColor, Colors.red);
    });

    testWidgets('should set app index route to CharactersScreen',
        (WidgetTester tester) async {
      await pumpWidget(tester);

      expect(find.byType(CharactersScreen), findsOneWidget);
    });
  });
}
