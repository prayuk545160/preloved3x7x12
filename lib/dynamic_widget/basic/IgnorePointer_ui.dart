import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;


class IgnorePointer_ui implements WidgetParser {

  List<String> dtag;
  IgnorePointer_ui(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]=dtag[0];
    return  IgnorePointer_uiex(m,listener,buildContext);

  }


  @override
  String get widgetName => "IgnorePointer";
}



class IgnorePointer_uiex extends StatefulWidget {

  Map<String, dynamic> m;
  ClickListener listener;
  BuildContext buildContext;
  final fkey = GlobalKey<FormBuilderState>();
  IgnorePointer_uiex(this.m, this.listener,this.buildContext);

  String getcmd(){
    return g.null2str(m["click_event"]);
  }
  String skey() {
    return g.null2str(m["skey"]);
  }
  String id() {
    return g.null2str(m["id"]);
  }

  String set_value(Map<String, dynamic>  h){
    h.forEach((key, value) {
      if(fkey.currentState.value.containsKey(key)){
        fkey.currentState.value[key]=value;
      }
    });

  }

  Map<String, dynamic> get_editvalue(){
    return fkey.currentState.value;
  }
  String val(){
    return fkey.currentState.value.toString();
  }

  getdata(){
    try {
      fkey.currentState.save();
      return fkey.currentState.value;
    }catch(e){
    }
  }



  @override
  IgnorePointer_uiex_state createState() => new IgnorePointer_uiex_state(m);
}
class IgnorePointer_uiex_state extends State<IgnorePointer_uiex> {


  Map<String, dynamic> h= new Map<String, dynamic>();
  Map<String, dynamic> m;
  IgnorePointer_uiex_state(this.m);

  Map<String, dynamic> childMap;
  Widget child;



  @override
  void initState() {
    super.initState();

    childMap = m['child'];
    child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, widget.buildContext, widget.listener);

  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring:true,
      child: child,
    );
  }

}



