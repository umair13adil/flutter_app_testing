import 'dart:io';

import 'package:flutter_app_testing/utils/key_helper.dart';
import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

//Run Command: flutter drive --target=test_driver/app.dart
void main() {
  group('Test list is loaded from JSON file', () {
    FlutterDriver driver;

    //Widgets
    SerializableFinder flowerListWidget = find.byValueKey('FlowersList');
    SerializableFinder flowerDetailsWidget = find.byValueKey('FlowersDetails');

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check if FLowersList is being displayed', () async {
      await driver.waitFor(flowerListWidget);
    });

    SerializableFinder listItemTitle =
        find.byValueKey(KeyHelper.getStringKeyForListItem('title', 0));

    test('List is loaded and item title matches', () async {
      expect(await driver.getText(listItemTitle), "Azalea");
    });

    SerializableFinder flowerCard =
        find.byValueKey(KeyHelper.getStringKeyForListItem('FlowerCard', 0));
    SerializableFinder detailTitle = find.byValueKey('detailTitle');

    test('Tap card, verify detail screen is shown and title matches', () async {
      await driver.tap(flowerCard, timeout: Duration(seconds: 3));

      sleep(Duration(seconds: 2));

      await driver.waitFor(flowerDetailsWidget, timeout: Duration(seconds: 3));
      await driver.waitForAbsent(listItemTitle);

      await driver.waitFor(find.text("Azalea"));

      expect(await driver.getText(detailTitle), "Azalea");
    },
        timeout: Timeout(
          Duration(minutes: 1),
        ));
  });
}
