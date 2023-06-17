import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;


class form_ui implements WidgetParser {

  List<String> dtag;
  form_ui(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
     m["skey"]=dtag[0];
    return  formui_ex(m,listener,buildContext);

  }


  @override
  String get widgetName => "Form";
}



class formui_ex extends StatefulWidget {

  Map<String, dynamic> m;
  ClickListener listener;
  BuildContext buildContext;
  final fkey = GlobalKey<FormBuilderState>();
  formui_ex(this.m, this.listener,this.buildContext);

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
  formex_state createState() => new formex_state(m);
}
class formex_state extends State<formui_ex> {


  Map<String, dynamic> h= new Map<String, dynamic>();
  Map<String, dynamic> m;
  formex_state(this.m);

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
    return FormBuilder(
      key: widget.fkey,
      child: child,
    );
  }

}



