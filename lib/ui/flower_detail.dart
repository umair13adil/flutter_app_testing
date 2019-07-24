import 'package:flutter/material.dart';
import 'package:flutter_app_testing/models/flower.dart';

class FlowerDetails extends StatefulWidget {
  final Flower flower;

  FlowerDetails({Key key, this.flower}) : super(key: Key('FlowersDetails'));

  @override
  _FlowerDetailsState createState() => _FlowerDetailsState();
}

class _FlowerDetailsState extends State<FlowerDetails> {
  final double imageSize = 150.0;

  Widget get flowerDetails {
    return Container(
      height: imageSize,
      width: imageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          const BoxShadow(
              offset: const Offset(1.0, 2.0),
              blurRadius: 2.0,
              spreadRadius: -1.0,
              color: const Color(0x33000000)),
          const BoxShadow(
              offset: const Offset(2.0, 1.0),
              blurRadius: 3.0,
              spreadRadius: 0.0,
              color: const Color(0x24000000)),
          const BoxShadow(
              offset: const Offset(3.0, 1.0),
              blurRadius: 4.0,
              spreadRadius: 2.0,
              color: const Color(0x1F000000)),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.flower.photo),
        ),
      ),
    );
  }

  Widget get price {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.attach_money,
          size: 40.0,
        ),
        Text(' ${widget.flower.price}',
            style: Theme.of(context).textTheme.display2),
      ],
    );
  }

  Widget get details {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.green[800],
            Colors.green[700],
            Colors.green[600],
            Colors.green[400],
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          flowerDetails,
          Text(
            '${widget.flower.name}',
            style: TextStyle(fontSize: 32.0),
            key: Key('detailTitle'),
          ),
          Text(
            widget.flower.category,
            style: TextStyle(fontSize: 20.0),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Text(widget.flower.instructions),
          ),
          price
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.flower.name}'),
      ),
      body: details,
    );
  }
}
