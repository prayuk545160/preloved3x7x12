import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/material.dart';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;


class panel_exp implements WidgetParser {

  List<String> dtag;
  panel_exp(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]=dtag[0];
    return  panel_exp_ex(m,buildContext,listener);

  }
  @override
  String get widgetName => "panel_exp";
}

class panel_exp_ex extends StatefulWidget {

  Map<String, dynamic> m;
  ClickListener listener;
  BuildContext ctx;
  panel_exp_ex(this.m, this.ctx,this.listener);

  TextEditingController txtc =  TextEditingController();

  toggle_panel(String sval){
    txtc.text=sval;
  }

  @override
  panelx_ex_state createState() => new panelx_ex_state(m);
}
class panelx_ex_state extends State<panel_exp_ex> {

  Map<String, dynamic> m;
  panelx_ex_state(this.m);

  List<String> a;


  @override
  void initState() {
    widget.txtc.text="false";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Widget ui_header = m['h'] == null ? null : DynamicWidgetBuilder
        .buildFromMap(m['h'], widget.ctx, widget.listener);
    Widget ui_header2 = m['h2'] == null ? null : DynamicWidgetBuilder
        .buildFromMap(m['h2'], widget.ctx, widget.listener);


    return


      ConfigurableExpansionTile(
        kExpand: const Duration(milliseconds: 50),
        initiallyExpanded: false,
        header: ui_header,
        headerExpanded: ui_header2,
        children: DynamicWidgetBuilder.buildWidgets(
            m['children'], widget.ctx, widget.listener),
      );
  }
}








/*
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/material.dart';

import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import '../utils.dart';




class muti_chipui extends WidgetParser {

  final List<String> dtag;
  muti_chipui(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    m["skey"]= dtag[0];

    return muti_chipex(m);


  }

  @override
  String get widgetName => "muti_select";
}


class muti_chipex extends StatefulWidget {

  final  Map<String, dynamic> m;

  muti_chipex(this.m);


  String id() {
    return g.null2str(m["id"]);
  }

  @override
  muti_chipexstate createState() => muti_chipexstate();

}

class muti_chipexstate  extends State<muti_chipex> {




  muti_chipexstate();

  Map<String, dynamic> childMap = widget.m['ui_title'];
  Widget child = childMap == null
      ? null
      : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);


  Widget ui_header = m['h'] == null ? null : DynamicWidgetBuilder.buildFromMap(m['h'] , buildContext, listener);
  Widget ui_header2 = m['h2'] == null ? null : DynamicWidgetBuilder.buildFromMap(m['h2'] , buildContext, listener);



  if(ui_header==null){
  ui_header=Text("^Toggle");
  }
  if(ui_header2==null){
  ui_header2=ui_header;
  }






  @override
  Widget build(BuildContext context) {




    return



      ConfigurableExpansionTile(
        kExpand: const Duration(milliseconds: 50),
        initiallyExpanded: true,
        header: ui_header,
        headerExpanded: ui_header2,
        children: DynamicWidgetBuilder.buildWidgets(
            m['children'], buildContext, listener),
      );



  }
}











class expansionpanel_ui extends WidgetParser {
  expansionpanel_ui(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {



    Map<String, dynamic> childMap = m['ui_title'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);


    Widget ui_header = m['h'] == null ? null : DynamicWidgetBuilder.buildFromMap(m['h'] , buildContext, listener);
    Widget ui_header2 = m['h2'] == null ? null : DynamicWidgetBuilder.buildFromMap(m['h2'] , buildContext, listener);



if(ui_header==null){
  ui_header=Text("^Toggle");
}
if(ui_header2==null){
  ui_header2=ui_header;
}



    return



      ConfigurableExpansionTile(
        kExpand: const Duration(milliseconds: 50),
        initiallyExpanded: true,
        header: ui_header,
        headerExpanded: ui_header2,
        children: DynamicWidgetBuilder.buildWidgets(
            m['children'], buildContext, listener),
      );






    */
/*  ConfigurableExpansionTile(
      key: PageStorageKey(g.newkey()),
      title:Container(height:20.0,child: Text("Menu")),
      children:DynamicWidgetBuilder.buildWidgets(
          m['children'], buildContext, listener),
    );*//*



  }
  @override
  String get widgetName => "exp_panel";
}
*/
