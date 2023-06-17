
import 'dart:convert';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';



class template_ui extends WidgetParser {

  final List<String> dtag;
  template_ui(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return template_ex(buildContext,m,listener);

  }

  @override
  String get widgetName => "tp";
}
class template_ex extends StatefulWidget {

  final ClickListener link_click;
  final BuildContext link_context;
  final  Map<String, dynamic> m;
  template_ex( this.link_context, this.m,this.link_click);

  String id() {
    return g.null2str(m["id"]);
  }

  @override
  _template_exState createState() => _template_exState(m);

}

class _template_exState  extends State<template_ex> {

  final  Map<String, dynamic> m;
  _template_exState(this.m);


String sui="";

  @override
  void initState() {
    super.initState();

  }



  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    try{
      return    DynamicWidgetBuilder.build(g.page_replace( g.getlayout(m["tp"]), "", ""),widget.link_context, widget.link_click,m["skey"]);
    }catch(e){}
    return   Container();

  }


}






