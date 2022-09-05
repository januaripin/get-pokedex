import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_pokedex/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('home', (WidgetTester tester) async {
      // arrange
      app.main();
      await tester.pumpAndSettle();

      // act
      final titleFinder = find.text('Pokedex');
      final listFinder = find.byType(Scrollable);
      final itemFinder = find.text('caterpie');

      await tester.scrollUntilVisible(
        itemFinder,
        500.0,
        scrollable: listFinder,
      );

      // assert
      expect(titleFinder, findsOneWidget);
      expect(itemFinder, findsOneWidget);
    });
  });
}
