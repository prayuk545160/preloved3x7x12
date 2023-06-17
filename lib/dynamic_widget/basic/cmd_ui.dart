import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rich_text/custom_rich_text.dart';
import 'package:custom_rich_text/models/read_more_less_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../g.dart' as g;

class cmd_ui implements WidgetParser {
  List<String> dtag;
  cmd_ui(this.dtag);
  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
     m["skey"]=dtag[0];
    return  cmd_ex(m,listener);

  }
  @override
  String get widgetName => "cmd";


}


class cmd_ex extends StatefulWidget {

  Map<String, dynamic> m;
  ClickListener listener;

  cmd_ex(this.m, this.listener);

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
  cmd_exState createState() => new cmd_exState();
}

class cmd_exState extends State<cmd_ex> {



  @override
  Widget build(BuildContext context) {


    var txt = Text("",key: Key(widget.m["this_key"]));
    if (widget.m.containsKey("click_event")) {
      String clickEvent =
      widget.m.containsKey("click_event") ? widget.m['click_event'] : "";
      return GestureDetector(
        onTap: () {
          if (mounted) {
            widget.listener.onClicked(clickEvent);
          }
        },
        child: txt,
      );
    } else {
      return txt;
    }
  }


}
