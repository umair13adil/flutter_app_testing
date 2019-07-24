import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_testing/models/flower.dart';
import 'package:palette_generator/palette_generator.dart';

class FlowerDetails extends StatefulWidget {
  final Flower flower;

  FlowerDetails({Key key, this.flower}) : super(key: Key('FlowersDetails'));

  @override
  _FlowerDetailsState createState() => _FlowerDetailsState();
}

class _FlowerDetailsState extends State<FlowerDetails> {
  final double imageSize = 150.0;
  Rect region;
  PaletteGenerator paletteGenerator;
  Size imageSizeWidget = Size(150.0, 150.0);
  var isGenerated = false;

  @override
  void initState() {
    super.initState();
    region = Offset.zero & imageSizeWidget;
  }

  ImageProvider getImage() {
    return AssetImage('assets/images/${widget.flower.photo}');
  }

  Widget get flowerDetails {
    return Container(
      height: imageSize,
      width: imageSize,
      margin: EdgeInsets.only(bottom: 20.0),
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
          image: getImage(),
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

  Decoration getBackgroundGradient(List<Color> list) {
    if (list.isNotEmpty) {
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.3, 0.4, 0.5, 0.7, 0.8, 0.9],
          colors: [
            list[0],
            list[1],
            list[2],
            list[3],
            list[4],
            list[5],
            list[6]
          ],
        ),
      );
    } else {
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.3, 0.4, 0.5, 0.7, 0.8, 0.9],
          colors: [Color(0x33000000)],
        ),
      );
    }
  }

  Widget getDetails(List<Color> list) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      decoration: getBackgroundGradient(list),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          flowerDetails,
          Text(
            '${widget.flower.name}',
            style: TextStyle(fontSize: 28.0),
            key: Key('detailTitle'),
            textAlign: TextAlign.center,
          ),
          Text(
            "(" + widget.flower.category + ")",
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
        body: Container(
            child: FutureBuilder<List<Color>>(
                future: _updatePaletteGenerator(region),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      var list = snapshot.data as List<Color>;
                      return getDetails(list);
                    } else {
                      return _buildProgressBar();
                    }
                  } else {
                    return _buildProgressBar();
                  }
                })));
  }

  Future<List<Color>> _updatePaletteGenerator(Rect newRegion) async {
    List<Color> listOfColors = new List();

    if (!isGenerated) {
      isGenerated = true;
      await PaletteGenerator.fromImageProvider(
        getImage(),
        size: imageSizeWidget,
        region: newRegion,
        maximumColorCount: 10,
      ).then((values) {
        listOfColors.add(values.dominantColor?.color ?? Colors.green[100]);
        listOfColors.add(values.lightVibrantColor?.color ?? Colors.green[200]);
        listOfColors.add(values.vibrantColor?.color ?? Colors.green[300]);
        listOfColors.add(values.lightMutedColor?.color ?? Colors.green[400]);
        listOfColors.add(values.mutedColor?.color ?? Colors.green[500]);
        listOfColors.add(values.darkMutedColor?.color ?? Colors.green[800]);
        listOfColors.add(values.darkVibrantColor?.color ?? Colors.green[900]);
      });
    }
    return listOfColors;
  }

  Widget _buildProgressBar() {
    return Center(
      child: CircularProgressIndicator(),
      key: Key('progressBar'),
    );
  }
}
