
import 'dart:convert';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';



class xui extends WidgetParser {

  final List<String> dtag;
  xui(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return xui_ex(buildContext,m,listener);

  }

  @override
  String get widgetName => "xui";
}


class xui_ex extends StatefulWidget {

  final ClickListener link_click;
  final BuildContext link_context;
  final  Map<String, dynamic> m;
  xui_ex( this.link_context, this.m,this.link_click);

  String id() {
    return g.null2str(m["id"]);
  }

  @override
  _xui_exState createState() => _xui_exState(m);

}

class _xui_exState  extends State<xui_ex> {

  final  Map<String, dynamic> m;
  _xui_exState(this.m);


  Map<String, dynamic> h = new Map<String, dynamic>(); //focus row


String skey="";




  @override
  void initState() {
    super.initState();
    skey=m["skey"];

  }



  @override
  void dispose() {
    super.dispose();

  }



  @override
  Widget build(BuildContext context) {

    String strui = "";
    strui=g.getlayout(m["row_ui"]);
    String tp=g.getlayout(m["row_loop"]);
    String s="";
    String stp="";

    List<String> b;

    //


    if(m.containsKey("tp")){
      strui=g.page_replace(g.hashmap2json(m["tp"]),"","");
    }

    if(m.containsKey("loop_tp")){
      tp=g.page_replace(g.hashmap2json(m["loop_tp"]),"","");
    }
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
          stp=stp.replaceAll("{row_index}","${i}");
          s+=stp;
        }else {
          stp=stp.replaceAll("{row_index}","${i}");
          s+=stp.replaceAll("{data}", v1)+",";
        }
        i+=1;
      });
      s=g.rcut(s);
      strui=strui.replaceAll('[{"":""}]',"["+s+"]");
    }


    if(m.containsKey("json_db")){
      List dt = m["json_db"];
      s='';
      dt.forEach((dr) {
        h=dr;
        stp=tp;
        h.forEach((k, v) {
          stp=stp.replaceAll("{"+k+"}",v);
        });
        s+=stp+",";
      });
      s=g.rcut(s);
      strui=strui.replaceAll('[{"":""}]',"["+s+"]");
    }


   if(m.containsKey("loop_database")){
      // d0,d1,d2,d3
      List<String> a=g.null2str(m["loop_database"]).split(",");
      int i=0;
      stp=tp;
      a.forEach((v1) {
        stp=stp.replaceAll("{row_index}","${i}");
        s+=stp.replaceAll("{d${i}", v1)+",";
        i+=1;
      });
      s=g.rcut(s);
      strui=strui.replaceAll('[{"":""}]',"["+s+"]");
    //  print("strui=${strui}");
    }

if(m.containsKey("jsdb")){


  List<String> a=m["jsdb"].toString().split(".");

  List l=g.db[a[0]][g.cintx(a[1])][a[2]];
  s="";
  l.forEach((dr) {
    stp=tp;
    h=dr;
    h.forEach((key, value) {
      stp=stp.replaceAll("{"+key+"}", g.null2str(value));
    });
    s+=stp+",";
  });
  s=g.rcut(s);
  strui=strui.replaceAll('[{"":""}]',"["+s+"]");


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
          allrow = jsonDecode(g.read_json(g.jsonx, a[0]))[a[1]] as List;
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
        strui=strui.replaceAll('[{"":""}]',"["+s+"]");

      }catch(e){}
    }

    if(g.null2str(m["k"])!=""){


      //g.bmsg("k:${m["k"]}");

      if(g.page_db.containsKey(m["k"]+"_json")){
        if(m.containsKey("database_json")){
          List dt = jsonDecode(g.page_db[m["k"]+"_json"])[m["database_json"]] as List;
          s='';
          dt.forEach((dr) {
            h=dr;
            stp=tp;
            h.forEach((k, v) {
              stp=stp.replaceAll("{"+k+"}",v);
            });
            s+=stp+",";
          });
          s=g.rcut(s);
          strui=strui.replaceAll('[{"":""}]',"["+s+"]");
        }
      }
    }


    strui=strui.replaceAll('[{"":""}]',"["+s+"]");
    print("str_Ui:${strui}");

    Widget ui=DynamicWidgetBuilder.buildFromMap(jsonDecode(strui), widget.link_context, widget.link_click);
    return ui;


  }


}






