


import 'dart:convert';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';



class ui extends WidgetParser {

  final List<String> dtag;
  ui(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return ui_ex(buildContext,m,listener);

  }

  @override
  String get widgetName => "ui";
}


class ui_ex extends StatefulWidget {

  final ClickListener link_click;
  final BuildContext link_context;
  final  Map<String, dynamic> m;
  ui_ex( this.link_context, this.m,this.link_click);

  String id() {
    return g.null2str(m["id"]);
  }

  @override
  _ui_exState createState() => _ui_exState(m);

}

class _ui_exState  extends State<ui_ex> {

  final  Map<String, dynamic> m;
  _ui_exState(this.m);

  String sui="";


  @override
  void initState() {
    super.initState();

    sui=g.null2str(m["ui"]);
    switch(sui){
      default:



        break;
    }



  }



  @override
  void dispose() {
    super.dispose();

  }



  @override
  Widget build(BuildContext context) {
    switch(sui){
      default:


        break;
    }

  }


}

