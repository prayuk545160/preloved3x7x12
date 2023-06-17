
//import 'package:draw_graph/draw_graph.dart';
//import 'package:draw_graph/models/feature.dart';

import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

class dgraphParser extends WidgetParser {

  final List<String> dtag;
  dgraphParser(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    m["skey"]= dtag[0];
    return graph_uiex(buildContext,m);
  }

  @override
  String get widgetName => "dgraph";
}


class graph_uiex extends StatefulWidget {
  final BuildContext _buildContext;
  final  Map<String, dynamic> m;
  graph_uiex( this._buildContext, this.m);
  @override
  graph_uiexState createState() => graph_uiexState();

}
class graph_uiexState  extends State<graph_uiex> {


  graph_uiexState();

  /*

  final List<Feature> features = [
    Feature(
      title: "Drink Water",
      color: Colors.blue,
      data: [0.2, 0.8, 0.4, 0.7, 0.6],
    ),
    Feature(
      title: "Exercise",
      color: Colors.pink,
      data: [1, 0.8, 0.6, 0.7, 0.3],
    ),
    Feature(
      title: "Study",
      color: Colors.cyan,
      data: [0.5, 0.4, 0.85, 0.4, 0.7],
    ),
    Feature(
      title: "Water Plants",
      color: Colors.green,
      data: [0.6, 0.2, 0, 0.1, 1],
    ),
    Feature(
      title: "Grocery Shopping",
      color: Colors.amber,
      data: [0.25, 1, 0.3, 0.8, 0.6],
    ),
  ];

*/

  @override
  Widget build(BuildContext context) {

    return Text("x");


/*
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            "",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        LineGraph(
          features: features,
          size: Size(320, 100),
          labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
          labelY: ['20%', '40%', '60%', '80%', '100%'],
          showDescription: false,
          graphColor: Colors.black,
        ),
        SizedBox(
          height: 50,
        )
      ],
    );

 */


  }
}