import 'dart:async';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';


class muti_chipui extends WidgetParser {

  final List<String> dtag;
  muti_chipui(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    m["skey"]= dtag[0];

    return muti_chipex(m);


  }

  @override
  String get widgetName => "muti_select";
}


class muti_chipex extends StatefulWidget {

  final  Map<String, dynamic> m;

  muti_chipex(this.m);


  String id() {
    return g.null2str(m["id"]);
  }

  @override
  muti_chipexstate createState() => muti_chipexstate();

}

class muti_chipexstate  extends State<muti_chipex> {


  muti_chipexstate();

  var tags = [
    "love",
    "instagood",
    "photooftheday",
    "beautiful",
    "fashion",
    "happy",
    "tbt",
    "cute",
    "followme",
    "like4like",
    "follow",
    "picoftheday",
    "me",
    "selfie",
    "summer",
    "instadaily"
  ];

  var selected_tags = ["love", "me", "summer"];


  generate_tags() {
    return tags.map((tag) => get_chip(tag)).toList();
  }

  get_chip(name) {
    return FilterChip(
        selected: selected_tags.contains(name),
        selectedColor: Colors.blue.shade800,
        disabledColor: Colors.blue.shade400,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        label: Text("#${name}"));
  }





  @override
  Widget build(BuildContext context) {
    return

      Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        children: <Widget>[generate_tags()],
      );


  }
}
