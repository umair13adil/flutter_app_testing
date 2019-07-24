import 'package:flutter_app_testing/data/flower_repository.dart';
import 'package:flutter_app_testing/models/flower.dart';

class DataHelper {
  //Mocked JSON data
  String getTestJSON() {
    return '[{"category": "Shrubs","price": 15.99,"instructions": "Large double. Good grower, heavy bloomer. Early to mid-season, acid loving plants. Plant in moist well drained soil with pH of 4.0-5.5.","photo": "california_snow.jpg","name": "Azalea","productId": 1}]';
  }

  List<Flower> getFlowersList() {
    return FlowerRepository().getFlowersList(getTestJSON());
  }
}
