import 'package:flutter/material.dart';
import 'package:flutter_app_testing/ui/flowers_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app_testing/main.dart';

void main() {

  group('MainApp', ()
  {
    testWidgets('Progress bar is shown at start and then list is shown', (
        WidgetTester tester) async {

      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: MyApp())
      );

      // Build a MaterialApp with the testKey.
      await tester.pumpWidget(testWidget);

      // Define the test key.
      final progressBarKey = Key('progressBar');
      final listKey = Key('list');

      // Find the MaterialApp widget using the testKey,
      // make sure that progress bar is shown and list is hidden
      expect(find.byKey(progressBarKey), findsOneWidget);
      expect(find.byKey(listKey), findsNothing);

      //Wait for 2 seconds
      await tester.pumpAndSettle(Duration(seconds: 2));

      // Find the MaterialApp widget using the testKey.
      // make sure that progress bar is hidden and list is shown
      expect(find.byKey(listKey), findsOneWidget);
    });
  });
}
