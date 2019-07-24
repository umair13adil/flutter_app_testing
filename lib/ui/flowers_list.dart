import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_testing/models/flower.dart';
import 'package:flutter_app_testing/ui/flower_detail.dart';
import 'package:flutter_app_testing/utils/key_helper.dart';

class FlowersList extends StatefulWidget {
  final List<Flower> flower;

  FlowersList({Key key, this.flower}) : super(key: Key('FlowersList'));

  @override
  State<StatefulWidget> createState() => FlowersListState(flower: flower);
}

class FlowersListState extends State<FlowersList> {
  final List<Flower> flower;

  FlowersListState({this.flower}) : super();

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: new List.generate(flower.length, (int index) {
      return Material(
          child: ListTile(
        title: FlowerCard(
            key: Key(KeyHelper.getStringKeyForListItem('FlowerCard', index)), flower: flower, index: index),
        onTap: () {
          _showDetailPage(context, flower[index]);
        },
      ));
    }));
  }

  _showDetailPage(BuildContext context, Flower flower) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return FlowerDetails(flower: flower);
        },
      ),
    );
  }
}

class FlowerCard extends StatelessWidget {
  const FlowerCard({@required Key key, @required this.flower, this.index})
      : super(key: key);

  final List<Flower> flower;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
        key: Key('card'),
        child: Container(
          child: Center(
              child: Row(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  flower[index].name,
                  style: TextStyle(fontSize: 20.0, color: Colors.red),
                  key: Key('title'),
                ),
                Text(
                  "Price: " + flower[index].price.toString() + " \$",
                  // set some style to text
                  style: TextStyle(fontSize: 14.0, color: Colors.deepOrange),
                ),
                Text(
                  "Category: " + flower[index].category,
                  // set some style to text
                  style: TextStyle(fontSize: 14.0, color: Colors.green),
                ),
              ],
            )
          ])),
          padding: const EdgeInsets.all(15.0),
        ));
  }
}
