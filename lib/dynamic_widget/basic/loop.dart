
import 'dart:convert';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';



class loop_ui extends WidgetParser {

  final List<String> dtag;
  loop_ui(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return loop_ex(buildContext,m,listener);

  }

  @override
  String get widgetName => "loopx";
}
class loop_ex extends StatefulWidget {

  final ClickListener link_click;
  final BuildContext link_context;
  final  Map<String, dynamic> m;
  loop_ex( this.link_context, this.m,this.link_click);

  String id() {
    return g.null2str(m["id"]);
  }

  @override
  _loop_exState createState() => _loop_exState(m);

}

class _loop_exState  extends State<loop_ex> {

  final  Map<String, dynamic> m;
  _loop_exState(this.m);


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

    sui=jsonEncode(m["tp"]).toString();
    return    DynamicWidgetBuilder.build(sui,widget.link_context, widget.link_click,m["skey"]);



    /*

    String strui = "";
    strui=g.getlayout(m["row_ui"]);
    String tp=g.getlayout(m["row_loop"]);
    String s="";
    String stp="";

    List<String> b;

    //
    if(m.containsKey("row_database")){
      List<String> a=g.null2str(m["row_database"]).split(",");


      int i=0;
      int l=0;

      a.forEach((v1) {
        stp=tp;
        if(v1.contains("[")){
          // loop column
          // fix field
          if(m.containsKey("row_field")){
            b=g.null2str(m["row_field"]).split(",");
            l=0;
            b.forEach((v1) {
              stp=stp.replaceAll(b[l], v1);
              l+=1;
            });
          }else {
            // auto create field d0,d1,d2
            b=v1.split("[");
            l=0;
            b.forEach((v1) {
              stp=stp.replaceAll("{d${l}", v1);
              l+=1;
            });
          }
          s+=stp;
        }else {
          s+=stp.replaceAll("{data}", v1)+",";
        }
      });
      s=g.rcut(s);
      strui=strui.replaceAll("{*}",s);
    }
    if(m.containsKey("loop_database")){
      // d0,d1,d2,d3
      List<String> a=g.null2str(m["loop_database"]).split(",");
      int i=0;
      stp=tp;
      a.forEach((v1) {
        s+=stp.replaceAll("{d${i}", v1)+",";
        i+=1;
      });
      s=g.rcut(s);
      strui=strui.replaceAll("{*}",s);
    }
    if(m.containsKey("js_fromfile")||
        m.containsKey("js_fromapi")||
        m.containsKey("js_database")||
        m.containsKey("js_fromdb")){

      try {
        s = "";
        List<String> a;
        List allrow;
        // from file ui
        if (m.containsKey("js_fromfile")) {
          a = g.null2str(m["js_fromfile"]).split(".");
          allrow = jsonDecode(g.read_json(g.json_ui, a[0]))[a[1]] as List;
        }
        // from last api
        if (m.containsKey("js_fromapi")) {
          a = g.null2str(m["js_fromapi"]).split(".");
          allrow = jsonDecode(g.read_json(g.g_json, a[0]))[a[1]] as List;
        }
        // from g.db
        if (m.containsKey("js_fromdb")) {
          a = g.null2str(m["js_fromdb"]).split(".");
          allrow = g.db[a[0]][0][a[1]];
        }
        //from tag
        if (m.containsKey("js_database")) {
          allrow = jsonDecode(g.null2str(m["js_database"])) as List;
        }


        Map<String, dynamic> h = Map<String, dynamic>();
        allrow.forEach((row) {
          Map<String, dynamic> h = row as Map<String, dynamic>;
          stp = tp;
          h.forEach((k1, v1) {
            stp = stp.replaceAll("{${k1}", v1);
          });
          s += stp + ",";
        });
        s = g.rcut(s);
        strui = strui.replaceAll("{*}", s);

      }catch(e){}
    }

    Widget ui=DynamicWidgetBuilder.buildFromMap(jsonDecode(strui), widget.link_context, widget.link_click);
    return ui;*/


  }


}






