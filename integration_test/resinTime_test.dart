import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genshin_calculator/main.dart';
import 'package:genshin_calculator/views/resinTimeView.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Resin Time Calculate Page', () {
    testWidgets("validate empty field", (WidgetTester tester) async {
      // final Finder resinField = find.byKey(Key('resinField'));
      final Finder calculateButton = find.byKey(Key('calculateButton'));

      await tester.pumpWidget(MyApp());

      await tester.pumpAndSettle();

      await tester.pumpWidget(MaterialApp(
        home: ResinTimeView(),
      ));

      await tester.pumpAndSettle();

      // await tester.enterText(resinField, "");

      await tester.tap(calculateButton);

      await tester.pumpAndSettle(Duration(seconds: 1));

      expect(
          find.byWidgetPredicate((widget) =>
              widget is Text &&
              widget.data.contains("Resin field cannot be empty.")),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is Text &&
              widget.data.contains("Resin needed field cannot be empty.")),
          findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 1));
    });

    testWidgets("Resin Calculator Test", (WidgetTester tester) async {
      /* Setups the finder*/
      final Finder resinField = find.byKey(Key('resinField'));
      final Finder resinNeededField = find.byKey(Key('resinNeededField'));
      final Finder calculateButton = find.byKey(Key('calculateButton'));

      await tester.pumpWidget(MyApp());

      /* pump and settle is same like waitfor in flutter_driver */
      await tester.pumpAndSettle();

      await tester.pumpWidget(MaterialApp(
        home: ResinTimeView(),
      ));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('resinField')));
      await tester.enterText(resinField, "0");

      await tester.tap(resinNeededField);
      await tester.enterText(resinNeededField, "20");

      await tester.tap(calculateButton);
      print("button tapped");

      // wait for 1 sec
      await tester.pumpAndSettle(Duration(seconds: 1));

      expect(find.text("Result: 2 hours and 40 mins"), findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is Text &&
              widget.data.startsWith("Result: ") &&
              widget.data.contains("Result: 2 hours and 40 mins")),
          findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 1));
    });
  });
}
