import 'package:flutter/material.dart';
import 'package:flutter_app_testing/data/flower_repository.dart';

import 'models/flower.dart';
import 'ui/flowers_list.dart';

Future main() async => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFB71C1C),
        primaryColorDark: const Color(0xFF01579B),
        accentColor: const Color(0xFF2196F3),
      ),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List data;
  FlowerRepository repository = FlowerRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Flowers",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          child: Center(
            child: FutureBuilder(
                future: repository.readFromAssets(context),
                builder: (context, snapshot) {
                  if (snapshot.data != null &&
                      snapshot.data.toString().isNotEmpty) {
                    return _buildFlowersList(snapshot);
                  } else {
                    return _buildProgressBar();
                  }
                }),
          ),
        ));
  }

  Widget _buildFlowersList(AsyncSnapshot snapshot) {
    List<Flower> flowersList = repository.getFlowersList(snapshot.data.toString());

    if (flowersList != null && flowersList.isNotEmpty) {
      return Center(
        child: FlowersList(flower: flowersList),  key: Key('list')
      );
    } else {
      return _buildProgressBar();
    }
  }

  Widget _buildProgressBar() {
    return Center(child: CircularProgressIndicator(),  key: Key('progressBar'),);
  }
}
