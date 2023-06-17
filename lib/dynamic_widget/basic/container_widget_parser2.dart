import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

import '../../dynamic_widget.dart';
import '../../g.dart' as g;
import '../utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as vui;
import 'package:path/path.dart' as path;


class ContainerWidgetParser2 extends WidgetParser {
  ContainerWidgetParser2(List<String> dtag);
  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    return Container2_ex(buildContext, m,listener);
  }

  @override
  String get widgetName => "Container2";

}


class Container2_ex extends StatefulWidget {

  final ClickListener  listener;
  final BuildContext buildContext;
  final  Map<String, dynamic> m;
  StreamController<String> eventx =null;

  Container2_ex(this.buildContext,this.m,this.listener);

  String id() {
    return g.null2str(m["id"]);
  }
  @override
  Container_exstate createState() => Container_exstate(m);

}



class Container_exstate  extends State<Container2_ex> {

  final  Map<String, dynamic> m;
  Container_exstate(this.m);
  List<String> a;

  Alignment alignment;
  Color color;
  BoxConstraints constraints;
  EdgeInsetsGeometry margin;
  EdgeInsetsGeometry padding;
  Map<String, dynamic> childMap;
  Widget child;
  String clickEvent;
  var ui=null;
  String sval="";
  var scr= new GlobalKey();
  int index_stack=0;

  ExpandableController exp_control = null;
  Widget hd_select = null;

  bool isshow=true;
  String vscroll2hide="";


  @override
  void initState() {

    try{

       vscroll2hide=g.null2str(widget.m["scroll2hide"]);
      if(m.containsKey("eventx")){
        widget.eventx = new StreamController();
        widget.eventx.stream.listen((data) async {
          if(mounted){
            a=data.split(".");
            if(a.length>=3){
              switch(a[1]){
                case "toggle":
                  exp_control.toggle();
                  break;

                case "open":
                  if(!exp_control.expanded){
                    exp_control.toggle();
                  }
                  break;
                case "close":
                  if(exp_control.expanded){
                    exp_control.toggle();
                  }
                  break;
                case "color":
                  setState(() {
                    color = parseHexColor(a[2]);
                  });
                  break;
                case "save_screenshot":

               await Permission.storage.request();
                RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
                var image = await boundary.toImage();
                var byteData = await image.toByteData(format: ImageByteFormat.png);
                var pngBytes = byteData.buffer.asUint8List();



                  final dir = await g.get_dir_download();
                  final sfile = path.join(dir.path, "file_${g.get_datetime_id()}.png");


                  File imgFile =new File(sfile);
                imgFile.writeAsBytes(pngBytes);
                if(g.null2str(m["auto_share"])=="true"){
                  await Share.shareFiles([sfile],
                      subject: 'Share',
                      text: 'Share');
                }
                break;
              }
            }
          }
        });
      }
    }catch(e){}



    alignment = parseAlignment(m['alignment']);
    color = parseHexColor(m['color']);
    constraints = parseBoxConstraints(m['constraints']);
    margin = parseEdgeInsetsGeometry(m['margin']);
    padding = parseEdgeInsetsGeometry(m['padding']);


    childMap = m['child'];
    child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, widget.buildContext, widget.listener);

    clickEvent =
    m.containsKey("click_event") ? m['click_event'] : "";
    ui=null;
    sval="";



   // Map<String, dynamic> hdmap = m['h'];

   if(g.null2str(m["ui"])=="toggle_panel"){

     bool is_expand=false;
     try{
       if(m.containsKey("expand_if")){
         a=g.null2str(m["expand_if"]).split(",");
         if(a[0]==a[1]){
           is_expand=true;
         }
       }
     }catch(e){}

     exp_control = new  ExpandableController(initialExpanded: is_expand);

     if(is_expand){
       hd_select=
           Container(key: g.getnewkey(),
               child:
               DynamicWidgetBuilder.buildFromMap(jsonDecode(g.hashmap2json(m['h']).replaceAll("@open_status","1")),widget.buildContext, widget.listener));
     }else {
       hd_select=
           Container(key: g.getnewkey(),
               child:
               DynamicWidgetBuilder.buildFromMap(jsonDecode(g.hashmap2json(m['h']).replaceAll("@open_status","0")),widget.buildContext, widget.listener));
      }


    }






    super.initState();






  }

  void loop_cmd(){

    if(g.scroll_tag==""){
      setState(() {
        isshow=true;
      });
    }else {
      setState(() {
        isshow=(g.scroll_tag==vscroll2hide);
      });
    }


    Future.delayed(const Duration(milliseconds: 100), () {
      loop_cmd();
    });
  }



  @override
  void dispose() {

    try{
      if(m.containsKey("eventx")){
        widget.eventx.close();
      }
    }catch(e){}
    super.dispose();
  }

  build_ui(){

    var w,h;
    w=m['width'];
    h=m['height'];

    var vscroll2hide=g.null2str(m["scroll2hide"]);

    if(m.containsKey("fill")){
      sval=g.null2str(m["fill"]);
      m['width']=MediaQuery.of(g.ctx()).size.width;
    }
    if(m.containsKey("fill_parent")){
      sval=g.null2str(m["fill_parent"]);
      if(sval.contains("y")){
        m['height']=double.infinity;
      }
      if(sval.contains("x")){
        m['width']=double.infinity;
      }
    }



    if(m.containsKey("widthp")){
      w=g.screen_w*m["widthp"];
    }
    if(m.containsKey("heightp")){
      h=g.screen_h*m["heightp"];
    }

    if(m.containsKey("height_d")){
      h=g.screen_h-g.cdbl(m["height_d"], 0);
    }
    if(m.containsKey("width_d")){
      w=g.screen_w-g.cdbl(m["width_d"], 0);
    }



    var decoration=null;

    if(m['style']!=null){
      ui = Container(
        decoration: new BoxDecoration(borderRadius:
        BorderRadius.circular(35.0),
            color: color),
        alignment: alignment,
        padding: padding,
        margin: margin,
        width: w,
        height: h,
        constraints: constraints,
        child: child,
      );
    }else {

      if(m.containsKey("ui")){
        switch(g.null2str(m["ui"])){
          case "click2layout":
            ui=  IndexedStack(
                index: index_stack,
                children: <Widget>[
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          index_stack=1;
                        });
                      },
                      child: DynamicWidgetBuilder.buildFromMap(m["a"],widget.buildContext, widget.listener)),
                  DynamicWidgetBuilder.buildFromMap(m["b"],widget.buildContext, widget.listener)
                ]);
            break;
          case "toggle_panel":








            ui= Column(children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {

                  exp_control.toggle();
                    setState(() {
                      if(exp_control.expanded){
                        hd_select=
                        Container(key: g.getnewkey(),
                            child:
                            DynamicWidgetBuilder.buildFromMap(jsonDecode(g.hashmap2json(m['h']).replaceAll("@open_status","1")),widget.buildContext, widget.listener));
                      }else {
                        hd_select=
                            Container(key: g.getnewkey(),
                                child:
                                DynamicWidgetBuilder.buildFromMap(jsonDecode(g.hashmap2json(m['h']).replaceAll("@open_status","0")),widget.buildContext, widget.listener));
                      }
                    });





                },
                child:hd_select,
              ),
              ExpandableTheme(
                data: ExpandableThemeData(
                    animationDuration:  Duration(milliseconds: g.cint(g.null2str(m["time_speed"]), 100))
                ),
                child: ExpandablePanel(
                  controller: exp_control,
                  expanded: Container(
                    decoration: decoration,
                    alignment: alignment,
                    padding: padding,
                    margin: margin,
                    width: w,
                    height: h,
                    color: color,
                    constraints: constraints,
                    child: child,
                  ),
                ),
              )

            ],);



            break;
        }

      }else {
        ui = Container(
          decoration: decoration,
          alignment: alignment,
          padding: padding,
          margin: margin,
          width: w,
          height: h,
          color: color,
          constraints: constraints,
          child: child,
        );
      }

    }

    if(m.containsKey("save_screen_shot")){
      ui=RepaintBoundary(
          key: scr,
          child: ui);
    }


    if(vscroll2hide!=""){
      ui=Visibility(
        child:ui,
        visible: isshow,
      );
      loop_cmd();


    }

  }

  @override
  Widget build(BuildContext context) {



    build_ui();





    if (widget.listener != null && clickEvent != null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.listener.onClicked(clickEvent);
        },
        child: ui,
      );
    } else {
      return ui;
    }
  }



}


