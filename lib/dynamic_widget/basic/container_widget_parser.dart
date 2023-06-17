import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../dynamic_widget.dart';
import '../../g.dart' as g;
import '../../g.dart';
import '../utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ContainerWidgetParser extends WidgetParser {
  ContainerWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {


    Alignment alignment = parseAlignment(m['alignment']);
    Color vcolor = parseHexColor(m['color']);
    BoxConstraints constraints = parseBoxConstraints(m['constraints']);
    //TODO: decoration, foregroundDecoration and transform properties to be implemented.
    EdgeInsetsGeometry margin = parseEdgeInsetsGeometry(m['margin']);
    EdgeInsetsGeometry padding = parseEdgeInsetsGeometry(m['padding']);
    Map<String, dynamic> childMap = m['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);



    Map<String, dynamic> hdmap = m['h'];
    Widget hd = hdmap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(hdmap, buildContext, listener);




    List<Widget> header=null;


    String clickEvent =
    m.containsKey("click_event") ? m['click_event'] : "";

    var ui=null;
    var xval="";
    List<String> a;
    String field_name="";
    bool ischeck=false;
    String dbname="";
    Color border_color;
    int irow=0;



    ExpandableController exp_control = null;
    StreamSubscription sub=null;

    if(m.containsKey("height")){
      m["height"]=g.get_height(m["height"]);
    }
    if(m.containsKey("width")){
      m["width"]=g.get_width(m["width"]);
    }


    xval=g.null2str(m["child_select"]);
    if(xval!=""){
      childMap = m[xval];
      child = childMap == null ? null : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);
    }


    try {


      if (m['hideif'] != null) {
        List<String> a = g.replace_var(g.null2str(m["hideif"]),g.active_key).split("[");
        if (a[0]==a[1]) {
          m['height'] = 0.0;
          m['width'] = 0.0;
        }
      }

      if (m['hidenotif'] != null) {
        List<String> a = g.replace_var(g.null2str(m["hidenotif"]),g.active_key).split("[");
        if (a[0]!=a[1]) {
          m['height'] = 0.0;
          m['width'] = 0.0;
        }
      }
      if (m['hide_strin'] != null) {
        List<String> a = g.replace_var(g.null2str(m["hideif"]),g.active_key).split("[");
        if (a[0].contains(a[1])) {
          m['height'] = 0.0;
          m['width'] = 0.0;
        }
      }

      if (m['hide_strnotin'] != null) {
        List<String> a = g.replace_var(g.null2str(m["hidenotif"]),g.active_key).split("[");
        if (!a[0].contains(a[1])) {
          m['height'] = 0.0;
          m['width'] = 0.0;
        }
      }



      if (m['hide_if'] != null) {
        String tval = "";
        List<String> a = g.null2str(m["hide_if"]).split("[");
        g.selectx(a[0], g.active_key);
        if (g.q.length > 0) {
          g.q.forEach((k1, v1) {
            tval = v1;
          });
        }
        print("hide_if_check" + tval + "_" + a[1]);
        if (tval == a[1]) {
          m['height'] = 0.0;
          m['width'] = 0.0;
        }
      }


      if (m['hide_notif'] != null) {
        String tval = "";
        List<String> a = g.null2str(m["hide_notif"]).split("[");
        g.selectx(a[0], g.active_key);
        if (g.q.length > 0) {
          g.q.forEach((k1, v1) {
            tval = v1;
          });
        }
        print("hide_notif_check" + tval + "_" + a[1]);
        if (tval != a[1]) {
          m['height'] = 0.0;
          m['width'] = 0.0;
        }
      }
      if (g.null2str(m["hide"]) == "true" || g.null2str(m["display"]) == "none") {
        m['height'] = 0.0;
        m['width'] = 0.0;
      }

    }catch(e){}


    if(m.containsKey("fill")){
      xval=g.null2str(m["fill"]);
      m['width']=g.screen_w;
    }
    if(m.containsKey("fill_parent")){
      xval=g.null2str(m["fill_parent"]);
      if(xval.contains("y")){
        m['height']=double.infinity;
      }
      if(xval.contains("x")){
        m['width']=double.infinity;
      }
    }

    double w,h;
    w= g.get_mobilesize(m['width']);
    h= g.get_mobilesize(m['height']);

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

// xy
    if(m.containsKey("cfgsize")){
      List<String> a=g.null2str(m["cfgsize"]).split(",");
      if(a.length==2){
        //x
        if(a[0]=="full"){
          w=MediaQuery.of(g.ctx()).size.width;
        }
        if(a[0]=="fill"){
          w= double.maxFinite;
        }
        //y
        if(a[1]=="full"){
          h=MediaQuery.of(g.ctx()).size.height;
        }
        if(a[1]=="fill"){
          h= double.maxFinite;
        }
      }

    }






    if(m.containsKey("center")){
      // if(g.null2str(m["center"])=="true" || m["center"]){
      child=Center(child: child,);
      //}
    }


    var decoration=null;



    if(m.containsKey('checkbox_data')){
      a=g.null2str(m["checkbox_data"]).split(",");
      if(a.length>=2){
        dbname=a[0];
        if(g.db.containsKey(dbname)){
          if(m.containsKey("rowindex")){
            irow=g.cint(m["rowindex"],0);
          }

          xval="0";
          // print("xrow_"+irow.toString()+g.db[dbname][irow].toString()+a.toString());

          field_name=a[1];
          if(g.db.containsKey(dbname)){
            if(g.db[dbname].length>irow){
              xval=g.null2str(g.db[dbname][irow][field_name]);
            }
          }
          if(g.str_in(field_name, "checkbox,rcheck") ){
            if(g.str_in(xval, ",0,false") ){
              ischeck=false;
            }else {
              ischeck=true;
            }
          }else {
            ischeck=(xval==a[2]);
          }



          if(ischeck){
            vcolor = parseHexColor(m["select_color"]);
            if(m.containsKey('border_color_select')){
              border_color=parseHexColor(m['border_color_select']);
            }
          }else {

            if(m.containsKey("row_color")) {
              vcolor = parseHexColor(m["row_color"]);
            } else if(m.containsKey("color")){
              vcolor = parseHexColor(m["color"]);
            }

          }
        }else {
          print("checkbox_data_not_found:"+dbname);
        }
      }
    }
    if(m.containsKey("ischeckbox")){
      xval=g.null2str(m["ischeckbox"]);
      if(xval=="1"){
        vcolor = parseHexColor(m["select_color"]);
        if(m.containsKey('border_color_select')){
          border_color=parseHexColor(m['border_color_select']);
        }
      }else {
        if(m.containsKey("row_color")) {
          vcolor = parseHexColor(m["row_color"]);
        } else if(m.containsKey("color")){
          vcolor = parseHexColor(m["color"]);
        }
      }

    }





    if(m['style']!=null){

      Color border_color=vcolor;
      if(m.containsKey("border_color")){
        border_color=g.getcolor(m["border_color"]);
      }
      decoration=new BoxDecoration(
        color: vcolor,
        border: Border.all(
          color: border_color ,
          width:(m.containsKey("border_width")? m["border_width"]:0.0),
        ),
        borderRadius: BorderRadius.circular(m.containsKey("border_radius")? m["border_radius"]:0.0),
      );

      if(m.containsKey("border_box")){
        List<String> r=m["border_box"].toString().split(",");
        if(m.containsKey("box_shadow_color")){
          decoration = BoxDecoration(
              color: border_color,
              borderRadius: new BorderRadiusDirectional.only(
                topStart   :  Radius.circular(g.cdbl(r[0],0.0)),
                topEnd  :  Radius.circular(g.cdbl(r[1],0.0)),
                bottomStart:  Radius.circular(g.cdbl(r[2],0.0)),
                bottomEnd: Radius.circular(g.cdbl(r[3],0.0)),
              ),
              boxShadow: [BoxShadow(
                color:g.getcolor(m["box_shadow_color"]),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              )]
          );
        }else {
          decoration = BoxDecoration(
              color: border_color,
              borderRadius: new BorderRadiusDirectional.only(
                topStart   :  Radius.circular(g.cdbl(r[0],0.0)),
                topEnd  :  Radius.circular(g.cdbl(r[1],0.0)),
                bottomStart:  Radius.circular(g.cdbl(r[2],0.0)),
                bottomEnd: Radius.circular(g.cdbl(r[3],0.0)),
              ),
          );
        }


      }




      ui = Container(
        decoration: decoration,
        alignment: alignment,
        padding: padding,
        margin: margin,
        width: w,
        height:h,
        constraints: constraints,
        child: child,
      );
    }else {





      if(m.containsKey("ui")){




        switch(g.null2str(m["ui"])){


          case "DraggableScrollableSheet":

            var xborder =  BorderRadius.all(Radius.circular(0.0));
            if(m.containsKey("color")){
              vcolor=g.getcolor(m["color"]);
            }
            if(m.containsKey("border_box")){
              List<String> r = m["border_box"].toString().split(",");
              xborder = new BorderRadius.only(
                topLeft: Radius.circular(g.cdbl(r[0], 0.0)),
                topRight: Radius.circular(g.cdbl(r[1], 0.0)),
                bottomLeft: Radius.circular(g.cdbl(r[2], 0.0)),
                bottomRight: Radius.circular(g.cdbl(r[3], 0.0)),
              );
            }


            Widget hx=Container();

            if(m.containsKey("ui_header")){
              hx= DynamicWidgetBuilder.buildFromMap(m['ui_header'], buildContext, listener);
            }

            ui=

                DraggableScrollableSheet(
                  minChildSize: g.cdbl(m["min_y"],0.2),
                  initialChildSize: g.cdbl(m["min_y"],0.2),
                  maxChildSize: g.cdbl(m["max_y"],0.8),
                  builder: (context, scrollController) {
                    return
                        ClipRRect(
                        borderRadius:xborder,
                        child:
                        Container(
                            color: vcolor,
                            child:
                            Column(children: [
                              Expanded(child:SingleChildScrollView(
                                controller: scrollController,
                                child: child,
                              ) )

                            ],))
                        ,
                      );
                  },
                );

            break;

          case "SliverPersistentHeader":
            if(m.containsKey("height")){
              if (!m.containsKey("min_height")){
                    m["min_height"]=m["height"];
              }
              if (!m.containsKey("max_height")){
                  m["max_height"]=m["height"];
              }
            }
            ui= SliverPersistentHeader(
                pinned: m.containsKey("pinned")? m["pinned"]:false, //true固定 false不固定
                delegate: h_delegate(
                  min_height: m.containsKey("min_height")? m["min_height"]:120.0,
                  max_height:m.containsKey("max_height")? m["max_height"]:120.0,
                  child: child,
                ));
            return ui;
            break;
          case "NestedScrollView":

            header=DynamicWidgetBuilder.buildWidgets(m['header'], buildContext, listener);
            ui=  NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return header;
              },
              body: child,
            );

    break;

          case "toggle_panel":

            exp_control = new  ExpandableController();

            sub=  g.event_bus.stream.listen((data) {
              if(g.null2str(m["id"])+".toggle"==data){
                exp_control.toggle();
              }
              if(g.null2str(m["id"])+".close"==data){
                if(exp_control.expanded){
                  exp_control.toggle();
                }
              }
              if(g.null2str(m["id"])+".open"==data){
                if(!exp_control.expanded){
                  exp_control.toggle();
                }
              }
            });
            ui=

                Column(children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      exp_control.toggle();
                    },
                    child: Row(children:[hd]),
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
                        color: vcolor,
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
            color: vcolor,
            constraints: constraints,
            child: child,
          );




      }
    }



    if(m.containsKey("box_style")) {
      switch (g.null2str(m["box_style"])) {
        case "OvalBottomBorderClipper":
          ui = ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: ui
          );
          break;
        case "OvalTopBorderClipper":
          ui = ClipPath(
              clipper: OvalTopBorderClipper(),
              child: ui

          );
          break;

        case "MovieTicketClipper":
          ui = ClipPath(
              clipper: MovieTicketClipper(),
              child: ui

          );
          break;
        case "MovieTicketBothSidesClipper":
          ui = ClipPath(
              clipper: MovieTicketBothSidesClipper(),
              child: ui

          );
          break;

        case "PointsClipper":
          ui = ClipPath(
              clipper: PointsClipper(),
              child: ui

          );
          break;

        case "PointsClipper":
          ui = ClipPath(
              clipper: PointsClipper(),
              child: ui

          );
          break;

        case "TriangleClipper":
          ui = ClipPath(
              clipper: TriangleClipper(),
              child: ui

          );
          break;

        case "TriangleClipper":
          ui = ClipPath(
              clipper: TriangleClipper(),
              child: ui

          );
          break;

        case "MovieTicketClipper":
          ui = ClipPath(
              clipper: MovieTicketClipper(),
              child: ui

          );
          break;


        case "MovieTicketClipper":
          ui = ClipPath(
              clipper: MovieTicketClipper(),
              child: ui

          );
          break;

        case "MovieTicketBothSidesClipper":
          ui = ClipPath(
              clipper: MovieTicketBothSidesClipper(),
              child: ui
          );
          break;
        case "MultiplePointedEdgeClipper":
          ui = ClipPath(
              clipper: MultiplePointedEdgeClipper(),
              child: ui
          );
          break;

        case "DiagonalPathClipperOne":
          ui = ClipPath(
              clipper: DiagonalPathClipperOne(),
              child: ui
          );
          break;
        case "DiagonalPathClipperTwo":
          ui = ClipPath(
              clipper: DiagonalPathClipperTwo(),
              child: ui
          );
          break;

        case "WaveClipperOne":
          ui = ClipPath(
              clipper: WaveClipperOne(),
              child: ui
          );
          break;

        case "WaveClipperOner":
          ui = ClipPath(
              clipper: WaveClipperOne(reverse: true),
              child: ui
          );
          break;
        case "WaveClipperTwo":
          ui = ClipPath(
              clipper: WaveClipperTwo(),
              child: ui
          );
          break;
        case "WaveClipperTwor":
          ui = ClipPath(
              clipper: WaveClipperTwo(reverse: true),
              child: ui
          );
          break;

        case "WaveClipperOne":
          ui = ClipPath(
              clipper: WaveClipperOne(),
              child: ui
          );
          break;

        case "WaveClipperTwo":
          ui = ClipPath(
              clipper: WaveClipperTwo(),
              child: ui
          );
          break;
        case "border_box":
        case "ClipRRect":
          List<String> r = m["border_box"].toString().split(",");
          var xborder = new BorderRadius.only(
            topLeft: Radius.circular(g.cdbl(r[0], 0.0)),
            topRight: Radius.circular(g.cdbl(r[1], 0.0)),
            bottomLeft: Radius.circular(g.cdbl(r[2], 0.0)),
            bottomRight: Radius.circular(g.cdbl(r[3], 0.0)),
          );


          ui = ClipRRect(
              borderRadius: xborder,
              child: ui);
          break;
      }}




    if(m.containsKey("background_img")){

      var fit=BoxFit.cover;

      if(m.containsKey("boxFit")){
        fit=parseBoxFit(m['boxFit']);
      }
      int img_width=600;
      if(m.containsKey("img_width")){
        img_width=g.cint(m["img_width"],img_width);
      }
      decoration=BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
              g.null2str(m["background_img"]),
            maxWidth:img_width
          ),
          fit: fit,
        ),
      );

      ui=Container(
        decoration: decoration,
        alignment: alignment,
        padding: padding,
        margin: margin,
        width: w,
        height:h,
        constraints: constraints,
        child: child,
      );

    }

    if(m.containsKey("maxwidth")){
      ui=ConstrainedBox(
        constraints: BoxConstraints(maxHeight: g.cdbl(m["maxheight"],200), maxWidth:  g.cdbl(m["maxwidth"],200)),
        child: ui,
      );
    }



    if(m.containsKey("null2hide")){
      if(g.null2str(m["null2hide"])==""){
        ui=  Container(width: 0,height: 0,child: ui,);
      }
    }
    // default  show
    if(m.containsKey("value2hide")){
      a=g.null2str(m["value2hide"]).split(",");
      if(a.length>=2){
        if(a[0]==a[1]){
          ui=  Container(width: 0,height: 0,child: ui,);
        }
      }
    }
    if(m.containsKey("null2hide")){
      if(g.null2str(m["null2hide"])==""){
        return  Container(width: 0,height: 0,);
      }
    }







    if(g.null2str(m["isclick"])=="false"){
      return IgnorePointer(ignoring: true,child: ui);
    }



    if (listener != null && clickEvent != null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: ui,
      );
    } else {
      return ui;
    }
  }

  @override
  String get widgetName => "Container";
}
