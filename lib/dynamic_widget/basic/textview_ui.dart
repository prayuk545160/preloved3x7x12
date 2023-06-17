import 'package:any_link_preview/any_link_preview.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:custom_rich_text/custom_rich_text.dart';


class textview_ui implements WidgetParser {

  List<String> dtag;
  textview_ui(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
     m["skey"]=dtag[0];
    return  textview(m,listener);

  }
  @override
  String get widgetName => "textview";
}
class textview2_ui implements WidgetParser {

  List<String> dtag;
  textview2_ui(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]=dtag[0];
    return  textview(m,listener);

  }
  @override
  String get widgetName => "text";
}

class TextSpanParser {
  TextSpan parse(Map<String, dynamic> map, ClickListener listener) {
    String clickEvent = map.containsKey("recognizer") ? map['recognizer'] : "";
    var textSpan = TextSpan(
        text: map['text'],
        style: parseTextStyle(map['style']),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            listener.onClicked(clickEvent);

          },
        children: []);

    if (map.containsKey('children')) {
      parseChildren(textSpan, map['children'], listener);
    }

    return textSpan;
  }

  void parseChildren(
      TextSpan textSpan, List<dynamic> childrenSpan, ClickListener listener) {
    for (var childmap in childrenSpan) {
      textSpan.children.add(parse(childmap, listener));
    }
  }
}

class textview extends StatefulWidget {

  Map<String, dynamic> m;
  ClickListener listener;
  var edit_value="";

  textview(this.m, this.listener);

  String getcmd(){
    return g.null2str(m["click_event"]);
  }
  String skey() {
    return g.null2str(m["skey"]);
  }
  setval(String edit_val){
    edit_value=edit_val;
  }



  @override
  text_exState createState() => new text_exState(m);
}
class text_exState extends State<textview> {


  Map<String, dynamic> h= new Map<String, dynamic>();
  Map<String, dynamic> m;
  text_exState(this.m);
  List<String> a;



  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    String s1;



    if(m.containsKey("bind_data")){
      a=g.null2str(m["bind_data"]).split(".");
      if(g.db.containsKey(a[0])){
        try {
          h = g.db[a[0]][g.cint(a[1],0)];
          widget.edit_value =g.null2str(h[a[2]]);
        }catch(e){}
      }
    }
    if(m.containsKey("bind_xdb")){
      a=g.null2str(m["bind_xdb"]).split(".");
      if(g.xdb.containsKey(a[0])){
        try {
          h = g.xdb[a[0]][g.cint(a[1],0)];
          widget.edit_value =g.null2str(h[a[2]]);
        }catch(e){}
      }
    }




    var txt;
    var url_fromtext="";
    if(m['uicolor']==null){
      m['uicolor']="#FF0000";
    }
    Color bkcolor = parseHexColor(m['uicolor']);



      // maincase



      txt =  Text(
        widget.edit_value,
        textAlign: parseTextAlign(m['textAlign']),
        overflow: parseTextOverflow( m['overflow']),
        maxLines: m['maxLines'],
        semanticsLabel: m['semanticsLabel'],
        softWrap:  m['softWrap'],
        textDirection: parseTextDirection(m['textDirection']),
        style: m.containsKey('style') ? parseTextStyle(m['style']) : null,
        textScaleFactor: m['textScaleFactor'],
      );







   if (m.containsKey("click_event")) {
      String clickEvent =
      m.containsKey("click_event") ? m['click_event'] : "";
      return GestureDetector(
        onTap: () {
          widget.listener.onClicked(clickEvent);
        },
        child: txt,
      );
    } else {
       return txt;
    }

  }

}



