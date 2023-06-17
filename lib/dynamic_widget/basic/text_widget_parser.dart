import 'dart:async';
import 'dart:io' as io;

import 'package:any_link_preview/any_link_preview.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rich_text/custom_rich_text.dart';
import 'package:custom_rich_text/models/read_more_less_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hash_at_links_detector/hash_at_links_detector.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../g.dart' as g;


class TextWidgetParser implements WidgetParser {

  List<String> dtag;
  TextWidgetParser(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

     m["skey"]=dtag[0];

    return  text_ex(m,listener,buildContext);

  }


  @override
  String get widgetName => "Text";
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

class text_ex extends StatefulWidget {

  Map<String, dynamic> m;
  BuildContext ctx;
  ClickListener listener;
  String edit_value="";

  String xval="";
  bool isfound_id=false;

  StreamController<String> eventx = null;
  text_ex(this.m, this.listener, this.ctx);







  String getcmd(){
    return g.null2str(m["click_event"]);
  }
  String skey() {
    return g.null2str(m["skey"]);
  }

  String id() {
    return g.null2str(m["id"]);
  }
  String getvid(){
    return m["skey"]+"."+g.null2str(m["id"]);
  }
  setval(String edit_val){
    try {
      eventx.add(edit_val);
      print("text_eventx=${edit_val}");
    }catch(e){}

  }
  String val() {
    try{
      return edit_value;
    }catch(e){
    }
    return "";
  }




  @override
  text_exState createState() => new text_exState(m);
}
class text_exState extends State<text_ex> {

  String id;
  String skey="";
  var row;
  String vkey="";
  String update_id="";
  String qloop_key="";
  //String gval="";

  List<String> ids;
  Map<String, dynamic> m;
  text_exState(this.m);
  var bindval="";
  String sval="";


  List<String> a,b,c;
  Map<String, dynamic> h= new Map<String, dynamic>();
  var vstyle;
 String url_fromtext="";
 double ipadding=0;
  var vcolor= Colors.transparent;
  EdgeInsetsGeometry vpadding =EdgeInsets.all(0.0);
  EdgeInsetsGeometry vmargin =EdgeInsets.all(0.0);


  Map<String, dynamic> childMap;
  Widget child ;


  int tag = 0;
  List<String> tags = [];
  List<String> data ;
  String s="";

  Widget lui=null;
  Widget rui=null;
  int ival;
  int ia,ib;
  int step_number=1;

  String clickEvent;
  List<String> dd_list ;
  String dropdownValue ;
  String vuitag;
  String tp="";
  bool reqhide=false;


  @override
  void initState() {

     vuitag=g.null2str(m["ui"]);

     if(g.str_in(vuitag,"dropdown,dropdown_field,menu")){
       dd_list = g.null2str(m["text"]).split(",");
       dropdownValue = dd_list.first;
     }

     clickEvent = m.containsKey("click_event") ? m['click_event'] : "";
     childMap = m['child'];
     child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, widget.ctx, widget.listener);


    if(m["lui"]!=null){
      lui=DynamicWidgetBuilder.buildFromMap(m['lui'], widget.ctx, widget.listener);
    }
    if(m["rui"]!=null){
      rui=DynamicWidgetBuilder.buildFromMap(m['rui'], widget.ctx, widget.listener);
    }


    if(m.containsKey("id")){
      widget.isfound_id=true;
    }

    if(m["id"]==null){
       m["id"]=g.createid();
    }

    id=widget.id();
    skey=widget.skey();

    if(!id.contains(".")){
      id=m["skey"]+"."+m["id"];
      print("id:"+id);
    }
    g.regiskey(m["skey"]);
    ids=id.split(".");
    // if(m.containsKey("data")){
    //   g.f[skey][id]=widget.editval;
    // }


    try{

      // g.f[m["skey"]][m["id"]]=g.null2str(m["data"]);
       //print("setf"+ g.f[m["skey"]].toString());

     }catch(e){
      print("set_f.error"+e.toString());
    }

    if(widget.isfound_id){
      widget.eventx = new StreamController();
      widget.eventx.stream.listen((data) {
        setState(() {
          widget.edit_value=data;
         // g.tmsg("new data:${data}");
        });
      });
    }


    super.initState();

  }



qloop(int deftime){
  if (this.mounted) {
    try {
      if(qloop_key!=g.qloop_key){
        qloop_key=g.qloop_key;
        try{
          setState(() {
            widget.edit_value=g.null2str(m["bind_field"]);
          });
        }catch(e){}
      }
    }catch(e){}
    Future.delayed( Duration(milliseconds: deftime), () {
      qloop(deftime);
    });
  }
}



  @override
  void dispose() {
    try {
      if(m.containsKey("bindx")){
        g.app_stream.onCancel();
      }
    } catch (e) {}

if(widget.eventx!=null){
  widget.eventx.close();
}

    //Streams must be closed when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var txt;

    try {
      String s1;

      try {
        if (m.containsKey("data_switch")) {
          a = g.null2str(m["data_switch"]).split("=");
          b = a[1].split(",");
          b.forEach((s) {
            c = s.split("[");
            if (a[0] == c[0]) {
              m["data"] = c[1];
            }
          });
        }
      } catch (e) {}


      widget.edit_value = g.null2str(m["data"]);

      if (m.containsKey("edit_value")) {
        widget.edit_value = g.null2str(m["edit_value"]);
        print(
            "text_updatebuild.edit_value= " + id + "   :" + widget.edit_value);
      }

      if (g.isfoundfield(m["id"])) {
        widget.edit_value = g.getdatafield(m["id"]);
        print("text_updatebuild.field= " + id + "   :" + widget.edit_value);
        print("iform:" + g.active_key + ":" + g.iform[g.active_key].toString());
      }

      if (m.containsKey("null_value")) {
        if (widget.edit_value == "") {
            widget.edit_value = g.null2str(m["null_value"]);
        }
      }

      if (m.containsKey("bind_field")) {
        int deftime = 1000;
        if (g.null2str(m["deftime"]) != "") {
          deftime = g.cint(m["deftime"], 0);
        }
        qloop(deftime);
      }

      if (m.containsKey("data_select")) {
        g.selectx(m["data_select"], m["skey"]);
        g.q.forEach((key, value) {
          widget.edit_value=value;
        });

      }

      if (m.containsKey("qdata")) {
          widget.edit_value=g.getfval(skey, m["qdata"]);
      }

      if (m.containsKey("bindx")) {
        try {
          widget.edit_value = g.null2str(g.papp[m["bindx"]]);
          g.app_stream.stream.listen((s) {
            try{
              setState(() {
                widget.edit_value = g.null2str(g.papp[m["bindx"]]);
              });
            }catch(e){}
          });
        } catch (e) {}
      }

      try {
        if (m.containsKey("dateformat")) {
          widget.edit_value = DateFormat(m["dateformat"]).format(
              DateTime.parse(widget.edit_value));
        }
      } catch (e) {}


      if (m.containsKey("bind_data")) {
        a = g.null2str(m["bind_data"]).split(".");
        if (g.db.containsKey(a[0])) {
          try {
            h = g.db[a[0]][g.cint(a[1], 0)];
            widget.edit_value = g.null2str(h[a[2]]);
          } catch (e) {}
        }
      }


      if (m.containsKey("bind_xdb")) {
        a = g.null2str(m["bind_xdb"]).split(".");
        if (g.xdb.containsKey(a[0])) {
          try {
            h = g.xdb[a[0]][g.cint(a[1], 0)];
            widget.edit_value = g.null2str(h[a[2]]);
          } catch (e) {}
        }
      }


      // auto decode string
      if(g.null2str(m["decode_str"])!="false"){
        widget.edit_value = g.decode_url(widget.edit_value);
      }



      if(m.containsKey("ltext")){
        widget.edit_value=m["ltext"]+ widget.edit_value;
      }
      if(m.containsKey("rtext")){
        widget.edit_value= widget.edit_value+m["rtext"];
      }

      if (m.containsKey("debug")) {
        print("text_data:${widget.edit_value}");
      }


      if (m['uicolor'] == null) {
        m['uicolor'] = "#FF0000";
      }
      Color bkcolor = parseHexColor(m['uicolor']);

      if(vuitag==""){
        vuitag=g.null2str(m["ui"]);
      }

      vstyle = m.containsKey('style') ? parseTextStyle(m['style']) : null;


      switch (vuitag) {


        case "dropdown_field":
         txt=DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder( //<-- SEE HERE
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              focusedBorder: OutlineInputBorder( //<-- SEE HERE
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              filled: true,
              fillColor: Colors.greenAccent,
            ),
            dropdownColor: Colors.greenAccent,
            value: dropdownValue,
            onChanged: (String value) {
              setState(() {
                widget.edit_value=value;
                dropdownValue = value;
              });
              g.saveiform(skey, value);
            },
            items: dd_list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
          );
          break;

        case "dropdown":

          txt= DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            underline: Container(
              height: 1,
              color: g.getcolor("#000000"),
            ),
            onChanged: (String value) {
              // This is called when the user selects an item.
              setState(() {
                widget.edit_value=value;
                dropdownValue = value;
              });
              g.saveiform(skey, value);
              g.click_cmd(m);

            },
            items: dd_list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );

          break;
        case "menu":

          List<String> dlist=m["text"].split(",");
          txt=  PopupMenuButton(
            initialValue: 0,
            onSelected: (int index) {
              setState(() {
                widget.edit_value=dlist[index];
                dropdownValue=dlist[index];
              });
              g.saveiform(skey, dlist[index]);
              g.click_cmd(m);
              if(m.containsKey("b${index}_click")){
                 g.b_click=g.null2str(m["b${index}_click"]);
              }
              if(m.containsKey("b${index}_cmd")){
                g.run_cmd=g.null2str(m["b${index}_cmd"]);
              }
            },
            child: Center(
              child: Text(g.null2str(m['button_text']),style:  m.containsKey('style') ? parseTextStyle(m['style']) : null,),),
            itemBuilder: (context) {
              return List.generate(dlist.length, (index) {
                return PopupMenuItem(
                  value: index,
                  child: Text(dlist[index]),
                );
              });
            },
          );

          break;

        case "html":
          txt = Html(
            data: widget.edit_value,
          );
          break;

        case "spin":


          if(m.containsKey("rank")){
            a=m["rank"].toString().split(",");
            ia=g.str2int(a[0]);
            ib=g.str2int(a[1]);
          }
          if(m.containsKey("step_number")){
            step_number=g.str2int(m["step_number"]);
          }
          txt = Text(
            widget.edit_value,
            textAlign: parseTextAlign(m['textAlign']),
            overflow: parseTextOverflow(m['overflow']),
            maxLines: m['maxLines'],
            semanticsLabel: m['semanticsLabel'],
            softWrap: m['softWrap'],
            textDirection: parseTextDirection(m['textDirection']),
            style: vstyle,
            textScaleFactor: m['textScaleFactor'],
          );

          txt=Row(
            children: <Widget>[
              InkWell(
                onTap: () {

                  try {
                    ival =int.parse(widget.edit_value);
                    ival = ival - step_number;

                    if(m.containsKey("rank")){
                      if(ival<ia){
                        ival=ia;
                      }
                    }

                   setState(() {
                      widget.edit_value = ival.toString();
                    });
                    g.saveiform(id,widget.edit_value );

                  /*  if(m.containsKey("bind_data")){
                      a=m["bind_data"].toString().split(".");
                      setState(() {
                        g.db[a[0]][g.cint(a[1], 0)][a[1]]=widget.edit_value;
                      });
                    }
*/





                  }catch(e){
                    g.bmsg("Error.${e}");
                  }

                },
                child: lui,
              )

              ,Container(
                alignment: Alignment.center,
                width: 40.0,
                child: txt,
               padding: EdgeInsets.all(5),
              ),
              InkWell(
                onTap: () {

                  try {
                    ival =int.parse(widget.edit_value);
                    ival = ival +step_number;

                    if(m.containsKey("rank")){
                      if(ival>ib){
                        ival=ib;
                      }
                    }


                    setState(() {
                      widget.edit_value = ival.toString();
                    });
                    g.saveiform(id, widget.edit_value );



                   /* if(m.containsKey("bind_data")){
                      a=m["bind_data"].toString().split(".");

                      g.alert("${a}  ${widget.edit_value}");
                      setState(() {
                        g.db[a[0]][g.cint(a[1], 0)][a[1]]=widget.edit_value;
                      });
                    }*/




                  }catch(e){
                    g.bmsg("Error.${e}");
                  }

                  },
                child: rui,
              )



            ],
          );
          break;

        case "select_one":
          try {
            data = g.null2str(m["edit_value"]).split(",");
          } catch (e) {}


          if (data.length > 0) {
            setState(() {
              widget.edit_value = data[0];
            });
          }
          if (m.containsKey("set_value")) {
            setState(() {
              sval = g.null2str(m["set_value"]);
              widget.edit_value = sval;
            });
            int i = 0;
            data.forEach((sx) {
              if (sx == sval) {
                tag = i;
              }
              i += 1;
            });
            m.remove("set_value");
          }


          /*  try {
          g.saveiform(id, data[0]);
        }
        catch(e){}*/
          var i_spacing = g.cdbl(g.null2str(m["spacing"]), 2.0);
          var cstyle = C2ChoiceStyle(showCheckmark: false,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              borderWidth: 0.0,
              elevation: 0.0,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              brightness: Brightness.dark,
              color: g.getcolor(g.strx(m["background_color"], "#D0D0D0")),
              labelStyle: TextStyle(
                  color: g.getcolor(g.strx(m["text_color"], "#000000"))),
              borderShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  side: BorderSide(
                      color: g.getcolor(g.strx(m["border_color"], "#FFFFFF")))
              ));

          var cstyle_active = C2ChoiceStyle(showCheckmark: false,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              borderWidth: 0.0,
              elevation: 0.0,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              brightness: Brightness.dark,
              color: g.getcolor(
                  g.strx(m["select_background_color"], "#735FB0")),
              labelStyle: TextStyle(
                  color: g.getcolor(g.strx(m["select_color"], "#FFFFFF"))),
              borderShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  side: BorderSide(
                      color: g.getcolor(g.strx(m["select_border_color"], "#FFFFFF")))
              ));



          // if(m.containsKey("data")){

          // }
/*
        try {
          setState(() {
            g.saveiform(id,data[0]);
          });
        }
        catch(e){}*/

          txt = ChipsChoice<int>.single(
            spacing: i_spacing,
            padding: EdgeInsets.all(0),
            choiceStyle: cstyle,
            key: Key( g.null2str(m["skey"])+"_"+id),
            choiceActiveStyle: cstyle_active,
            value: tag,
            wrapped: true,
            onChanged: (vindex) {
              try {
                setState(() {
                  tag = vindex;
                });
                tag = vindex;
                widget.edit_value = data[vindex];
                g.plink["edit_value"] = data[vindex];
                g.saveiform(id, data[vindex]);

                // g.alert("${g.iform[g.active_key]}");
              } catch (e) {
                g.alert("select_one.error:${e}");
              }

              if (m.containsKey("t_click")) {
                g.t_click = m["t_click"];
              }
              if (m.containsKey("t_click2")) {
                g.t_click =
                    (g.null2str(m["t_click2"]) + "_" + widget.edit_value)
                        .toLowerCase();
              }
            },
            choiceItems: C2Choice.listFrom<int, String>(
              source: data,
              value: (i, v) => i,
              label: (i, v) => v,
            ),

          );

          break;
        case "select_mutiple":
        /*   g.saveiform(id,"");
*/
          if (m.containsKey("set_value2")) {
             m["set_value"]=g.null2str(m["set_value2"]).replaceAll(" ", ",");
             m.remove("set_value2");
          }

            if (m.containsKey("set_value")) {
            setState(() {
              sval = g.null2str(m["set_value"]);
              widget.edit_value = sval;
            });
            widget.edit_value.split(",").forEach((sx) {
              tags.add(sx);
            });
            m.remove("set_value");
            widget.edit_value= widget.edit_value.replaceAll(","," ");
          }



          var i_spacing = g.cdbl(g.null2str(m["spacing"]), 2.0);

          var cstyle = C2ChoiceStyle(showCheckmark: false,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              borderWidth: 0.0,
              elevation: 0.0,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              brightness: Brightness.dark,
              color: g.getcolor(g.strx(m["background_color"], "#D0D0D0")),
              labelStyle: TextStyle(
                  color: g.getcolor(g.strx(m["text_color"], "#000000"))),
              borderShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  side: BorderSide(
                      color: g.getcolor(g.strx(m["border_color"], "#FFFFFF")))
              ));

          var cstyle_active = C2ChoiceStyle(showCheckmark: false,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              borderWidth: 0.0,
              elevation: 0.0,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              brightness: Brightness.dark,
              color: g.getcolor(
                  g.strx(m["select_background_color"], "#735FB0")),
              labelStyle: TextStyle(
                  color: g.getcolor(g.strx(m["select_color"], "#FFFFFF"))),
              borderShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  side: BorderSide(
                      color: g.getcolor(g.strx(m["select_border_color"], "#FFFFFF")))
              ));

          // if(m.containsKey("data")){
          try {
            data = g.null2str(m["edit_value"]).split(",");
          } catch (e) {}
          // }

          txt = ChipsChoice<String>.multiple(
            spacing: i_spacing,
            padding: EdgeInsets.all(0),
            value: tags,
            choiceStyle: cstyle,
            choiceActiveStyle: cstyle_active,
            wrapped: true,
            onChanged: (val) =>
                setState(() {
                  try {
                    tags = val;
                  } catch (e) {}
                  try {
                    s = "";

                    data.forEach((s1) {
                      if(val.contains(s1)){
                        s += s1 + ",";
                      }
                    });
                   /* val.forEach((s1) {
                      s += s1 + ",";
                    });*/

                    s = g.rcut(s).replaceAll(","," ");
                    widget.edit_value = s;
                    g.plink["edit_value"] = s;
                    g.saveiform(id, s);

                    if (m.containsKey("vid")) {
                      g.savevfield(m["vid"], widget.edit_value);
                    }
                    if (m.containsKey("vname")) {
                      g.plink[m["vname"]] = widget.edit_value;
                    }

                    if (m.containsKey("t_click")) {
                      g.t_click = m["t_click"];
                    }
                    if (m.containsKey("t_click2")) {
                      g.t_click =
                          (g.null2str(m["t_click2"]) + "_" + widget.edit_value)
                              .toLowerCase();
                    }
                  } catch (e) {}
                }),
            choiceItems: C2Choice.listFrom<String, String>(
              source: data,
              value: (i, v) => v,
              label: (i, v) => v,
            ),
          );

          break;
        case "badge":
          if (m.containsKey("badge_padding")) {
            ipadding = g.cdbl(g.null2str(m["badge_padding"]), 0);
          }
          txt =Container(child: child,);
/*
          Badge(
            padding: EdgeInsets.all(ipadding),
            toAnimate: false,
            badgeColor: bkcolor,
            badgeContent: Text(
              widget.edit_value,
              textAlign: parseTextAlign(m['textAlign']),
              overflow: parseTextOverflow(m['overflow']),
              maxLines: m['maxLines'],
              semanticsLabel: m['semanticsLabel'],
              softWrap: m['softWrap'],
              textDirection: parseTextDirection(m['textDirection']),
              style: m.containsKey('style') ? parseTextStyle(m['style']) : null,
              textScaleFactor: m['textScaleFactor'],
            ),
            child: child,
          );*/
          break;
        case "chip":
          txt = Chip(
            padding: EdgeInsets.all(0),
            backgroundColor: bkcolor,
            label: Text(
              widget.edit_value,
              key: Key( g.null2str(m["skey"])+"_"+id),
              textAlign: parseTextAlign(m['textAlign']),
              overflow: parseTextOverflow(m['overflow']),
              maxLines: m['maxLines'],
              semanticsLabel: m['semanticsLabel'],
              softWrap: m['softWrap'],
              textDirection: parseTextDirection(m['textDirection']),
              style: m.containsKey('style') ? parseTextStyle(m['style']) : null,
              textScaleFactor: m['textScaleFactor'],
            ),
          );
          break;
        case "link_preview":
          try {
            url_fromtext =widget.edit_value;
            if (g.null2str(m["null2hide"]) == "true") {
              if (url_fromtext == "") {
                txt = Container();
                break;
              }
            }
            List<String> l = g.getlinkfromstring(url_fromtext);
            if (l.length > 0) {
              url_fromtext = l[0];
            }
            if (Uri
                .parse(url_fromtext)
                .isAbsolute) {
              try {
                txt =
                    InkWell(
                      onTap: () {



              if(g.cbool(m["openlink"])){
                g.openlink(widget.edit_value);
                          }
                          g.plink["click_link"]=widget.edit_value;
                          widget.listener.onClicked(clickEvent);
                      },
                      child: IgnorePointer(
                        child:
                        AnyLinkPreview(
                          link: url_fromtext,
                          displayDirection: UIDirection.uiDirectionVertical,
                          showMultimedia: true,
                          bodyMaxLines: 3,
                          bodyTextOverflow: TextOverflow.ellipsis,
                          titleStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          bodyStyle: TextStyle(color: Colors.black, fontSize: 12),
                          errorBody: m.containsKey("errorbody")
                              ? m['errorbody']
                              : "...",
                          errorTitle: m.containsKey("errortitle")
                              ? m['errortitle']
                              : "...",
                          errorWidget: Container(
                            color: Colors.transparent,
                            child: Text('Oops!'),
                          ),
                          errorImage: m.containsKey("errorimage")
                              ? m['errorimage']
                              : "https://google.com/",
                          cache: Duration(days: 7),
                          backgroundColor: Colors.transparent,
                          borderRadius: 0,
                          removeElevation: true,
                          //ui_height: m["ui_height"],
                          boxShadow: [
                            BoxShadow(blurRadius: 0, color: Colors.transparent)
                          ],
                        ),),

                    );
              } catch (e) {
                txt = Container();
              }
            } else {
              txt = Container();
            }
          } catch (e) {
            txt = Container();
          }
          break;

        case "textlink":
          String linktype="";
        txt=  CustomSmartText(
          style: TextStyle( fontSize: 18),

            text: widget.edit_value,
          tagStyle: TextStyle( fontSize: 18),
         // linkStyle: TextStyle(color: g.getcolor("#593E31")),
           // atStyle: TextStyle(color: g.getcolor("#235123")),
            disableAt: false,
            onTagClick: (svalue) {
              linktype = "hashtag";
              click_link(linktype,svalue);
            },
            onUrlClicked: (svalue) {
              linktype = "url";
              click_link(linktype,svalue);
            },
            onAtClick: (svalue) {
              linktype = "usertag";
              click_link(linktype,svalue);
            },
          );


    // txt = CustomSmartText(
          //
          //     widget.edit_value,
          //     locale: Locale("th"),
          //     linkStyle: TextStyle(color: Colors.blue),
          //     linkTypes: [
          //       LinkType.email,
          //       LinkType.url,
          //       LinkType.hashTag,
          //       LinkType.userTag
          //     ],
          //     onTap: (link) {
          //       String linktype = "";
          //
          //       if (link.value.startsWith("#")) {
          //         linktype = "hashtag";
          //       }
          //       else if (link.value.startsWith("@")) {
          //         linktype = "usertag";
          //       }
          //       else if (link.value.contains("@")) {
          //         linktype = "email";
          //       }
          //       else if (link.value.startsWith("http") ||
          //           link.value.startsWith("www")) {
          //         linktype = "url";
          //       } else {
          //         linktype = "url";
          //       }
          //
          //       String svalue = link.value.toString();
          //       // /*if(linktype=="url"){
          //       //  // if(svalue.startsWith("_")){
          //       //     svalue.replaceAll("_", "");
          //       //   //}
          //       // }*/
          //
          //
          //       g.plink["link_" + linktype] = linktype;
          //       g.plink["link_value"] = svalue;
          //       g.plink["link_data"] = svalue;
          //       g.plink["link"] = svalue;
          //
          //
          //       //  g.tmsg("link:${svalue} ${linktype}");
          //
          //       if (m.containsKey("link_click")) {
          //         g.t_click = g.null2str(m["link_click"]) + linktype;
          //       }
          //     });


          break;

        case "image_picker":

          sval = g.null2str(m["ui_img"]);
          sval = sval.replaceAll("{v}", widget.edit_value);

          String defimg=g.null2str(m["defimg"]);
          if(defimg==""){
            defimg=g.null2str(m["nullimg"]);
          }
         if(widget.edit_value ==""){
          txt=Container(
              width: m["width"],
              height: m["height"],
              child: Image.network(defimg));
         }else {
           txt=Image.file(
             io.File(widget.edit_value),
             fit:BoxFit.cover,
             width: m["width"],
             height: m["height"],
           );
         }
        break;
        default:
          vstyle = m.containsKey('style') ? parseTextStyle(m['style']) : null;
          if (g.null2str(m["ui_style"]) == "msg") {
            vstyle = TextStyle(
              color: g.getcolor(
                  g.defstr(g.null2str(m["text_color"]), "#000000")),
              fontWeight: FontWeight.w600,
              fontSize: g.cdbl(g.null2str(m["font_size"]), 14.0),
              background: Paint()
                ..color = g.getcolor(
                    g.defstr(g.null2str(m["background_color"]), "#3484C4"))
                ..strokeWidth = 28
                ..strokeJoin = StrokeJoin.round
                ..strokeCap = StrokeCap.round
                ..style = PaintingStyle.stroke,
            );
          }

          txt = Text(
            widget.edit_value,
            key: Key(m["this_key"]),
            textAlign: parseTextAlign(m['textAlign']),
            overflow: parseTextOverflow(m['overflow']),
            maxLines: m['maxLines'],
            semanticsLabel: m['semanticsLabel'],
            softWrap: m['softWrap'],
            textDirection: parseTextDirection(m['textDirection']),
            style: vstyle,
            textScaleFactor: m['textScaleFactor'],
          );
          break;
      }

      if (
          m.containsKey("ui_padding") ||
          m.containsKey("ui_background_color") ||
          m.containsKey("ui_border_color") ||
          m.containsKey("ui_radius")
      ) {



        vpadding = parseEdgeInsetsGeometry(m['ui_padding']);
        if (m.containsKey("ui_margin")) {
          vmargin = parseEdgeInsetsGeometry(m['ui_margin']);
        }


        txt = Container(
            decoration: BoxDecoration(
                color: m.containsKey("ui_background_color") ? g.getcolor(
                    m["ui_background_color"]) : vcolor,
                border: Border.all(
                  width:m.containsKey("ui_border_width")? m["ui_border_width"]:1 ,
                  color: m.containsKey("ui_border_color") ? g.getcolor(
                      m["ui_border_color"]) : vcolor,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(g.cdbl(g.null2str(m["ui_radius"]), 0.0)))
            ),
            padding: vpadding,
            margin: vmargin,
            child: txt);
      }

      if (m.containsKey("null2hide")) {
        if (widget.edit_value == "" ||
            widget.edit_value == "0" ||
            widget.edit_value == null) {
          txt = Container();
        }
      }
      if (m.containsKey("val2hide")) {
        reqhide=false;
        a = g.null2str(m["val2hide"]).split(",");
        a.forEach((s1) {
          if( widget.edit_value==s1){
            reqhide=true;
          }
        });
        if(reqhide){
          txt = Container(height: 0.0, width: 0.0, child: txt,);
        }
      }

      if (m.containsKey("value2hide")) {
        a = g.null2str(m["value2hide"]).split("[");
        if (a.length >= 2) {
          if (a[0] == a[1]) {
            txt = Container(height: 0.0, width: 0.0, child: txt,);
          }
        }
      }
      if (m.containsKey("value2show")) {
        a = g.null2str(m["value2show"]).split("[");
        if (a.length >= 2) {
          if (a[0] != a[1]) {
            txt = Container(height: 0.0, width: 0.0, child: txt,);
          }
        }
      }

      if (m["autofit"]=="true") {
        txt = Expanded(child: txt,);
      }

      if (m.containsKey("wrap")) {
        txt = Wrap(children: [txt],);
      }

      if (m.containsKey("wrap2")) {
        txt = Flexible(child: txt);
      }


      if (widget.edit_value == "") {
        if (m.containsKey("null2value")) {
          widget.edit_value = g.null2str(m["null2value"]);
        }
      }

      if (m["ui_img"] != null) {
        String defimg=g.null2str(m["defimg"]);
        var uidefimg;
        if(defimg==""){
          uidefimg=Container();
        }else {
          uidefimg=Image.network(defimg);
        }
        sval = m["ui_img"];
        sval = sval.replaceAll("{v}", widget.edit_value);
        txt =
            SizedBox(
                width: m.containsKey("width") ? m["width"] : 30.0,
                height: m.containsKey("height") ? m["height"] : 30.0,
                child: CachedNetworkImage(
                  placeholder: (context, url) =>uidefimg,
                  imageUrl: sval,
                  errorWidget: (context, url, error) => uidefimg,
                )
            );
      }




      if(g.null2str(m["display"])=="none"){
        txt= Visibility(
          child:txt,
          visible: false,
        );
      }


    //  if(m.containsKey("data_tag")){
        if(g.null2str(m["data_tag"])=="image"){

          if(tp==""){

            tp=g.hashmap2json(m["tp"]);
            tp=tp.replaceAll("{edit_value}", widget.edit_value);
          }
         txt=DynamicWidgetBuilder.build(tp,widget.ctx, widget.listener,m["skey"]);
        }
      //}




      if (m.containsKey("click_event")) {

        if(m.containsKey("on_touch")){
          return   Listener(
            onPointerDown: (PointerDownEvent event) {
              if (mounted) {
                g.backcmd=g.null2str(m["backcmd"]);
                g.plink["f_editvalue"]=widget.edit_value;
                widget.listener.onClicked(clickEvent);
              }
            },
            child: txt,
          );

        }else {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (mounted) {
                g.backcmd=g.null2str(m["backcmd"]);
                g.plink["f_editvalue"]=widget.edit_value;
                widget.listener.onClicked(clickEvent);
              }
            },
            child: txt,
          );
        }




      } else {
        return txt;
        //return


        // Column(children: [txt,Text(widget.edit_value)]);
      }


    }catch(e){
      return Text("Error."+e.toString());
    }
  }

  click_link(String linktype,String svalue){
    try{

      g.plink["link_" + linktype] = linktype;
      g.plink["link_value"] = svalue;
      g.plink["link_data"] = svalue;
      g.plink["link"] = svalue;


      if (m.containsKey("link_click")) {
        g.t_click = g.null2str(m["link_click"]) + linktype;
      }

    }catch(e){}


  }


}



