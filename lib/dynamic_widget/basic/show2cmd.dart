import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rich_text/custom_rich_text.dart';
import 'package:custom_rich_text/models/read_more_less_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../g.dart' as g;

class show2cmd_ui implements WidgetParser {
  List<String> dtag;
  show2cmd_ui(this.dtag);
  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
     m["skey"]=dtag[0];
    return  show2cmd_ex(m,listener,buildContext);

  }
  @override
  String get widgetName => "show2cmd";


}


class show2cmd_ex extends StatefulWidget {

  Map<String, dynamic> m;
  ClickListener listener;
  BuildContext ctx;

  show2cmd_ex(this.m, this.listener,this.ctx);

  String getcmd(){
    return g.null2str(m["click_event"]);
  }
  String skey() {
    return g.null2str(m["skey"]);
  }

  String id() {
    return g.null2str(m["id"]);
  }
  String getvid(){
    return m["skey"]+"."+g.null2str(m["id"]);
  }


  @override
  show2cmd_exState createState() => new show2cmd_exState();
}

class show2cmd_exState extends State<show2cmd_ex> {


  Widget child;
  bool isrun=false;

  @override
  void initState() {
    child  = DynamicWidgetBuilder.buildFromMap(widget.m['child'], widget.ctx, widget.listener);
  }

  @override
  Widget build(BuildContext context) {

    VisibilityDetector(
      key: Key(g.newkey()),
      onVisibilityChanged: (info) {
        if(!isrun){
          isrun=true;
          if(widget.m.containsKey("run_cmd")){
            g.run_cmd=widget.m["run_cmd"].toString();
          }
        }
      },
      child:child
    );

 }
}
