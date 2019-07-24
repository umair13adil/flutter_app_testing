import 'package:flutter/material.dart';
import 'package:flutter_app_testing/ui/flowers_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/data_helper.dart';

void main() {
  group('FlowersList', () {
    testWidgets('List is shown', (WidgetTester tester) async {
      var flowersList = DataHelper().getFlowersList();

      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: FlowersList(flower: flowersList)));

      // Build a MaterialApp with the testKey.
      await tester.pumpWidget(testWidget);

      // Define the test key.
      final cardKey = Key('card');
      final titleKey = Key('title');

      expect(find.byType(FlowerCard), findsOneWidget);

      // Find the MaterialApp widget using the testKey,
      expect(find.byKey(cardKey), findsOneWidget);
      expect(find.byKey(titleKey), findsOneWidget);
    });

    testWidgets('List size matches', (WidgetTester tester) async {
      var flowersList = DataHelper().getFlowersList();

      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: FlowersList(flower: flowersList)));

      // Build a MaterialApp with the testKey.
      await tester.pumpWidget(testWidget);

      final Finder listItems = find.byType(FlowerCard);
      expect(listItems, findsNWidgets(1));
    });

    testWidgets('List item title matches', (WidgetTester tester) async {
      var flowersList = DataHelper().getFlowersList();

      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: FlowersList(flower: flowersList)));

      // Build a MaterialApp with the testKey.
      await tester.pumpWidget(testWidget);

      final titleKey = Key('title');

      Text f = tester.widget(find.byKey(titleKey));
      expect(f.data, equals('Azalea'));
    });
  });
}
