import 'dart:async';

import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';


class show_ui extends WidgetParser {

  final List<String> dtag;
  show_ui(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return show_ex(m,buildContext,listener);

  }
  @override
  String get widgetName => "showui";
}


class show_ex extends StatefulWidget {
  final  Map<String, dynamic> m;
  final  BuildContext bd;
  final ClickListener cclick;
  StreamController<String> eventx =null;

  String getid(){
    return g.null2str(m["id"]);
  }

  show_ex(this.m,this.bd,this.cclick);

  @override
  _show_exState createState() => _show_exState();

}

class _show_exState  extends State<show_ex> {

bool isshow=true;
Map<String, dynamic> childMap;
Widget child;

StreamController<String> eventx =null;

@override
void initState() {

  childMap= widget.m['child'];
  child = childMap == null
      ? null
      : DynamicWidgetBuilder.buildFromMap(childMap, widget.bd, widget.cclick);
  isshow=(g.null2str(widget.m["isshow"])=="true");


  try{
    widget.eventx = new StreamController();
    widget.eventx.stream.listen((data) {

      if(data=="x"){
        setState(() {
          isshow=!isshow;
        });
      }
      else if(data=="true"){
           setState(() {
             isshow=true;
           });
      }else {
        setState(() {
           isshow=false;
        });
      }
    });
  }catch(e){}
}

@override
void dispose() {
  try{
    widget.eventx.close(); //Streams must be closed when not needed
  }catch(e){}
  super.dispose();
}


  @override
  Widget build(BuildContext context) {

    var wg;
    if(isshow){
      wg= Visibility(
        child: child,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: true,
      );
    }else {
      wg=Visibility(
        child: child,
        visible: false,
      );
    }

    return wg;


  }
}
