import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_testing/models/flower.dart';

class FlowerRepository {

  List<Flower> getFlowersList(String data) {
    return jsonDecode(data).map<Flower>((i) => Flower.fromMap(i)).toList();
  }

  Future<String> readFromAssets(BuildContext context) {
    return DefaultAssetBundle.of(context).loadString('assets/flowers.json');
  }
}
