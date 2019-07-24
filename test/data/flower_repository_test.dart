import 'package:flutter_app_testing/data/flower_repository.dart';
import 'package:flutter_app_testing/models/flower.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import '../helper/data_helper.dart';

void main() {

  test('JSON File is decoded and length matches', () {
    FlowerRepository repository = FlowerRepository();

    List<Flower> flowersList = repository.getFlowersList(DataHelper().getTestJSON());
    expect(flowersList.length, 1);
  });

  test('Category name matches', () {
    FlowerRepository repository = FlowerRepository();

    List<Flower> flowersList = repository.getFlowersList(DataHelper().getTestJSON());
    expect(flowersList.first.category, "Shrubs");
  });
}
