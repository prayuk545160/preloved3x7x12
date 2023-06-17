import 'package:flutter/material.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;

class RowWidgetParser extends WidgetParser {

  List<String> a;


  RowWidgetParser(List<String> dtag);
  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {


    if(m.containsKey("null2remove")){
      if(g.null2str(m["null2remove"])==""){
        return  Container(width: 0,height: 0);
      }
    }
    if(m.containsKey("if_login2")){
      if(g.null2str(m["if_login2"])=="true"){
        if(!g.check_login()){
          return Container(height: 0,width:0);
        }
      }else {
        if(g.check_login()){
          return  Container(height: 0,width:0);
        }
      }
    }




    String clickEvent =
    m.containsKey("click_event") ? m['click_event'] : "";



    var rx;
    rx=Row(
      crossAxisAlignment: m.containsKey('crossAxisAlignment')
          ? parseCrossAxisAlignment(m['crossAxisAlignment'])
          : CrossAxisAlignment.center,
      mainAxisAlignment: m.containsKey('mainAxisAlignment')
          ? parseMainAxisAlignment(m['mainAxisAlignment'])
          : MainAxisAlignment.start,
      mainAxisSize: m.containsKey('mainAxisSize')
          ? parseMainAxisSize(m['mainAxisSize'])
          : MainAxisSize.max,
      textBaseline: m.containsKey('textBaseline')
          ? parseTextBaseline(m['textBaseline'])
          : null,
      textDirection: m.containsKey('textDirection')
          ? parseTextDirection(m['textDirection'])
          : null,
      verticalDirection: m.containsKey('verticalDirection')
          ? parseVerticalDirection(m['verticalDirection'])
          : VerticalDirection.down,
      children: DynamicWidgetBuilder.buildWidgets(
          m['children'], buildContext, listener),
    );





    if (m.containsKey("padding")) {
      EdgeInsetsGeometry spadding = parseEdgeInsetsGeometry(m['padding']);
      rx=Padding(padding:spadding,child: rx);
    }

    if(m.containsKey("height")){
      rx=Container(height: m["height"],child: rx,);
    }

    if(m.containsKey("hide")){
      if(g.null2str(m["hide"])=="true"){
        rx=Container(height: 0,width:0,child: rx,);
      }
    }
    if(m.containsKey("display")){
      if(g.null2str(m["display"])=="none"){
        rx=Container(height: 0,width:0,child: rx,);
      }
    }

    if(m.containsKey("filter_in")){
      a=g.null2str(m["filter_in"]).split("[");
      print("compare_x${a[0]}  ${a[1]}");

      if(!(g.str_in2(a[0], a[1]))){
        rx=Container(height: 0,width:0,child: rx,);
      }
    }
    if(m.containsKey("value2hide")){
      List<String> a= g.null2str(m["value2hide"]).split(",");
      if(a.length>=2){
        if(a[0]==a[1]){
          rx=Container(height: 0,width:0,child: rx,);
        }
      }
    }


    if(m.containsKey("if_login")){
      if(g.null2str(m["if_login"])=="true"){
        if(!g.check_login()){
          rx=Container(height: 0,width:0,child: rx,);
        }
      }else {
        if(g.check_login()){
          rx=Container(height: 0,width:0,child: rx,);
        }
      }
    }

    if(m.containsKey("noclick")){
      return IgnorePointer(ignoring: true,child: rx);
    }
    if(g.null2str(m["isclick"])=="false"){
      return IgnorePointer(ignoring: true,child: rx);
    }
    if(g.null2str(m["isclick_child"])=="false"){
      return IgnorePointer(ignoring: true,child: rx);
    }

      if (listener != null && clickEvent != null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child:  rx,
      );
    } else {
      return rx;
    }

  }

  @override
  String get widgetName => "Row";
}

class ColumnWidgetParser extends WidgetParser {
  ColumnWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {


    List<String> a;
    String sval="";
    if(m.containsKey("null2remove")){
      if(g.null2str(m["null2remove"])==""){
        return  Container(width: 0,height: 0);
      }
    }


    if(m.containsKey("if_login2")){
      if(g.null2str(m["if_login2"])=="true"){
        if(!g.check_login()){
          return Container(height: 0,width:0);
        }
      }else {
        if(g.check_login()){
          return  Container(height: 0,width:0);
        }
      }
    }





    String clickEvent =
    m.containsKey("click_event") ? m['click_event'] : "";


    var rx;

     rx= Column(
      crossAxisAlignment: m.containsKey('crossAxisAlignment')
          ? parseCrossAxisAlignment(m['crossAxisAlignment'])
          : CrossAxisAlignment.center,
      mainAxisAlignment: m.containsKey('mainAxisAlignment')
          ? parseMainAxisAlignment(m['mainAxisAlignment'])
          : MainAxisAlignment.start,
      mainAxisSize: m.containsKey('mainAxisSize')
          ? parseMainAxisSize(m['mainAxisSize'])
          : MainAxisSize.max,
      textBaseline: m.containsKey('textBaseline')
          ? parseTextBaseline(m['textBaseline'])
          : null,
      textDirection: m.containsKey('textDirection')
          ? parseTextDirection(m['textDirection'])
          : null,
      verticalDirection: m.containsKey('verticalDirection')
          ? parseVerticalDirection(m['verticalDirection'])
          : VerticalDirection.down,
      children: DynamicWidgetBuilder.buildWidgets(
          m['children'], buildContext, listener),
    );
    if (m.containsKey("padding")) {
      EdgeInsetsGeometry spadding = parseEdgeInsetsGeometry(m['padding']);
      rx=Padding(padding:spadding,child: rx);
    }




    if(m.containsKey("width")){
      rx=Container(width: m["width"],child: rx,);
    }

    if(m.containsKey("center")){
      rx=Center(child:rx);
    }


    if(m.containsKey("hide")){
      if(g.null2str(m["hide"])=="true"){
        rx=Container(height: 0,width:0,child: rx,);
      }
    }
    if(m.containsKey("display")){
      if(g.null2str(m["display"])=="none"){
        rx=Container(height: 0,width:0,child: rx,);
      }
    }
    if(m.containsKey("filter_in")){
      a=g.null2str(m["filter_in"]).split("[");
      if(!(g.str_in2(a[0], a[1]))){
        rx=Container(height: 0,width:0,child: rx,);
      }
    }



    if(m.containsKey("value2hide")){
      List<String> a= g.null2str(m["value2hide"]).split(",");
      if(a.length>=2){
        if(a[0]==a[1]){
          rx=Container(height: 0,width:0,child: rx,);
        }
      }
    }


    if(m.containsKey("if_login")){
      if(g.null2str(m["if_login"])=="true"){
        if(!g.check_login()){
          rx=Container(height: 0,width:0,child: rx,);
        }
      }else {
        if(g.check_login()){
          rx=Container(height: 0,width:0,child: rx,);
        }
      }
    }

    if(m.containsKey("noclick")){
      return IgnorePointer(ignoring: true,child: rx);
    }
    if(g.null2str(m["isclick"])=="false"){
      return IgnorePointer(ignoring: true,child: rx);
    }
    if(g.null2str(m["clickable"])=="false"){
      return IgnorePointer(ignoring: true,child: rx);
    }
    if(g.null2str(m["isclick_child"])=="false"){
      return IgnorePointer(ignoring: true,child: rx);
    }


    if (listener != null && clickEvent != null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          listener.onClicked(clickEvent);
        },
         child: rx,
      );
    } else {
      return rx;
    }

  }

  @override
  String get widgetName => "Column";
}
