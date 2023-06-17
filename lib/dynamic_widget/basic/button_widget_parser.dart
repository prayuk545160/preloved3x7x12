import 'dart:developer';
import 'package:date_time_picker/date_time_picker.dart';
import '../../dynamic_widget/basic/container_widget_parser2.dart';
import 'package:intl/intl.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/material.dart';
import '../../g.dart' as g;



class RaisedButtonParser extends WidgetParser {
  RaisedButtonParser(List<String> dtag);


  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {

   return new button_ex(buildContext,map,listener);

  }

  @override
  String get widgetName => "RaisedButton";
}
class button_parse extends WidgetParser {
  button_parse(List<String> dtag);


  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {

    return new button_ex(buildContext,map,listener);

  }

  @override
  String get widgetName => "button";
}
class RaisedButtonParser2 extends WidgetParser {
  RaisedButtonParser2(List<String> dtag);


  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {

    return new button_ex(buildContext,map,listener);

  }

  @override
  String get widgetName => "button";
}
class button_ex extends StatefulWidget {

  final BuildContext _buildContext;
  final Map<String, dynamic> m;
  final ClickListener listener;
  String edit_value = "";



  button_ex( this._buildContext, this.m,this.listener);
  @override
  _button_exState createState() => _button_exState(m);


  String getcmd(){
    return g.null2str(m["click_event"]);
  }
  String id(){
    return g.null2str(m["id"]);
  }
  String skey(){
    return g.null2str(m["skey"]);
  }
  bool config_ok(){
    return (skey()!="" && id()!="");
  }
  String checkbox(){
    return g.null2str(m["checkbox"]);
  }
  String read_editvalue(){
    return edit_value;
  }
  String val(){
    return edit_value;
  }


}

class _button_exState  extends State<button_ex> {
  final Map<String, dynamic> m;
  _button_exState(this.m);




  @override
  void initState() {

    if(m["id"]==null){
      m["id"]=g.createid();
    }
    if(widget.config_ok()){
      g.regiskey(widget.skey());
    }

    super.initState();


  }



  void sendclick(String edit_value){
    String sval="";
    if(m.containsKey("t_click")){
      sval=g.null2str(m["t_click"]);
      sval=sval.replaceAll("{edit_value}", "$edit_value");
      sval=sval.replaceAll("{xval}", widget.edit_value);
      g.t_click=sval;
    }
  }

  @override
  Widget build(BuildContext context) {

    String clickEvent =
    m.containsKey("click_event") ? m['click_event'] : "";
    Color vcolor=parseHexColor("#E1E1E1");
    Color bkcolor=m.containsKey('color') ? parseHexColor(m['color']) : null;
    List arr;
    List<String> a,b,c;
    List<Map<String, dynamic>> tb;
    String xval="";

    String mcheck="";
    String checkbox_type=g.null2str(m["checkbox_type"]);
    var irow=0;
    Map<String, dynamic> l= new   Map<String, dynamic>() ;
    String setval="";
    String field_name="";
    double border_width=1.0;
    double border_radius=20.0;
    bool ischeck=false;
    Color border_color;
    String dbname="";
    String sval="";
    bool is_enable=true;



    if(m.containsKey('color')){
      vcolor=parseHexColor(m['color']);
    }




    border_color=vcolor;

    if(m.containsKey('border_color')){
      border_color=parseHexColor(m['border_color']);
    }
    if(m.containsKey('border_radius')){
      border_radius=double.parse(m['border_radius'].toString());
    }


    if(m.containsKey('border_width')){
      border_width=double.parse(m['border_width'].toString());
    }

    try{
    if(widget.checkbox()!=""){
      arr=widget.checkbox().split(".");
      irow=g.cint(arr[1],0);
      bkcolor = parseHexColor(m["color"]);


      dbname=widget.skey()+"."+arr[0];
      if(!g.db.containsKey(dbname)){
        dbname=arr[0];
      }


      try {
        if(g.db.containsKey(dbname)){
          if(g.db[dbname].length >irow){
            if (g.null2str(g.db[dbname][irow]["checkbox"]) == "1") {
              bkcolor = parseHexColor(m["select_color"]);
              if (m.containsKey('border_color_select')) {
                border_color = parseHexColor(m['border_color_select']);
              }
            }
          }
        }

      }catch(e){}




      if(m.containsKey('row_color')){

        if(g.null2str(g.db[dbname][irow][m["row_color"]])!=""){
          bkcolor=parseHexColor(g.null2str(g.db[dbname][irow][m["row_color"]]));
        }

      }


      }}catch(e){}


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
                   bkcolor = parseHexColor(m["select_color"]);
                   if(m.containsKey('border_color_select')){
                     border_color=parseHexColor(m['border_color_select']);
                   }
                }else {

                   if(m.containsKey("row_color")) {
                     bkcolor = parseHexColor(m["row_color"]);
                   } else if(m.containsKey("color")){
                     bkcolor = parseHexColor(m["color"]);
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
          bkcolor = parseHexColor(m["select_color"]);
          if(m.containsKey('border_color_select')){
            border_color=parseHexColor(m['border_color_select']);
          }
        }else {
          if(m.containsKey("row_color")) {
            bkcolor = parseHexColor(m["row_color"]);
          } else if(m.containsKey("color")){
            bkcolor = parseHexColor(m["color"]);
          }
        }

    }


    try {
      if (m.containsKey('value2color')) {
        a = g.null2str(m["value2color"]).split("=");
        b = a[1].split(",");
        b.forEach((s1) {
          c = s1.split("[");
          if (a[0] == c[0]) {
            m["color"] = c[1];
            bkcolor=g.getcolor(m["color"]);
          }
        });
      }
    }catch(e){}
    if (m.containsKey('disable_check')) {
      a=g.null2str(m["disable_check"]).split("[");
      if(a[0].contains(a[1])){
        is_enable=false;
      }
    }

    if(!is_enable){
      bkcolor=g.getcolor(g.strx(m["color_disable"],"#A5A5A5"));
      border_color=bkcolor;
    }


    var  vshape  =RoundedRectangleBorder(borderRadius: BorderRadius.circular(border_radius),side: BorderSide(color: border_color,width:border_width));
    var raised_Button ;


    bool isbutton=true;
    if(m.containsKey("uitag")){
      var uitag=g.null2str(m["ui"]);

      isbutton=false;

      //dropdownbutton
      if(uitag=="dropdownbutton"){
        List<String> dlist=m["text"].split(",");
        if(widget.edit_value==""){
          widget.edit_value=dlist[0];
        }
        raised_Button=DropdownButton<String>(
          isExpanded: true,
          value: widget.edit_value,
            onChanged: (String newValue) {
              setState(() {
                widget.edit_value = newValue;
                g.sys["dropdown_value"]=widget.edit_value;
                sendclick(widget.edit_value);

              });
            },
            items: dlist
                .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
                value: value,
                child: Text(value),);}).toList(),
        );

      }
      if(uitag=="menu"){

        //String button_click=g.null2str(m["button_click"]);
        List<String> dlist=m["text"].split(",");
        return  PopupMenuButton(
              initialValue: 0,
              onSelected: (int index) {
                setState(() {
                  widget.edit_value = dlist[index];
                  g.sys["dropdown_value"]=widget.edit_value;
                  sendclick("$index");
                });
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
      }


      }

    if(isbutton){



      raised_Button= ElevatedButton (
        /*
        color: bkcolor,
        disabledColor: m.containsKey('disabledColor')
            ? parseHexColor(m['disabledColor'])
            : null,
        disabledElevation:
        m.containsKey('disabledElevation') ? m['disabledElevation'] : 0.0,
        disabledTextColor: m.containsKey('disabledTextColor')
            ? parseHexColor(m['disabledTextColor'])
            : null,
        elevation: m.containsKey('elevation') ? m['elevation'] : 0.0,
        padding: m.containsKey('padding')
            ? parseEdgeInsetsGeometry(m['padding'])
            : null,
        splashColor: m.containsKey('splashColor')
            ? parseHexColor(m['splashColor'])
            : null,
        shape: vshape,
        key:
        m.containsKey('id') ? Key(m['id']) :null,
        textColor:
        m.containsKey('textColor') ? parseHexColor(m['textColor']) : null,*/


        child: DynamicWidgetBuilder.buildFromMap(
            m['child'], widget._buildContext, widget.listener),
        onPressed: () {
          try {

            if(mounted && is_enable){


              if(checkbox_type!="") {
                arr = widget.checkbox().split(".");
                irow = g.cint(arr[1], 0);
                dbname = widget.skey() + "." + arr[0];
                if (!g.db.containsKey(dbname)) {
                  dbname = arr[0];
                }
                List xdb;
                if (g.db.containsKey(dbname)) {
                  xdb = g.db[dbname];
                  if (g.g_resetcheckbox) {
                    setval = "0";
                  }
                  if (checkbox_type == "1" || checkbox_type == "x") {
                    // reset
                    int trow = xdb.length;
                    for (int i = 0; i < trow; i++) {
                      xdb[i]["checkbox"] = 0;
                      xdb[i]["rcheck"] = "";
                    }
                    if (checkbox_type == "x") {
                      setval = "1";
                    }
                    // set val
                    xdb[irow]["checkbox"] = setval;
                    xdb[irow]["rcheck"] = g.null2str(m["rdata"]);
                    xdb[irow]["rdata"] = g.null2str(m["rdata"]);

                    if (checkbox_type == "1" || checkbox_type == "x") {
                      g.grid_update = dbname;
                    }
                  }
                  if (checkbox_type == "rowx") {
                    xdb[irow]["row_data"] = "x";
                    g.grid_update = dbname;
                    print("row_data:" + xdb[irow].toString());
                  }
                }

                if (m.containsKey("setval")) {
                  List a1 = m["setval"].split(",");
                  List a2;
                  a1.forEach((s1) {
                    try {
                      a2 = s1.split("=");
                      g.pvar[a2[0]] = a2[1];
                    } catch (e) {}
                  });
                }

                if (m.containsKey("b_click")) {
                  g.b_click = g.null2str(m["b_click"]);
                  print("trigger bclick:" + g.b_click);
                }
                if (m.containsKey("t_click")) {
                  g.t_click = g.null2str(m["t_click"]);
                }

                if (m.containsKey("click_event")) {
                  g.run_cmd = g.null2str(m["click_event"]);
                }
                print(g.pkey.toString());
              }


            }
          }catch(e){
            print("button.onPressed.error."+e.toString());
          }
          if(mounted){
            widget.listener.onClicked(clickEvent);
          }
        },
      );
    }




    if(m.containsKey("null2hide")){
       if(g.null2str(m["null2hide"])==""){
         return  Container(width: 0,height: 0,);
       }
    }

    if(m.containsKey("fill")){
      sval=g.null2str(m["fill"]);
      if(sval.contains("xy")){
        return SizedBox(child: raised_Button,width:double.infinity,height: double.infinity,);
      }else if(sval.contains("x")){
        return SizedBox(child: raised_Button,width:double.infinity);
      }else if(sval.contains("y")){
        return SizedBox(child: raised_Button,height: double.infinity);
      }
    }

    if(m.containsKey("center")){
      raised_Button= Center(child:raised_Button);
    }

    if(m.containsKey("fullwidth")){
      return SizedBox(child: raised_Button,width:double.infinity);
    }else if(m.containsKey("width")){
      return SizedBox(child: raised_Button,width:g.null2dbl(m["width"], 100),);
    }
    else if(m.containsKey("set_width")){
      return SizedBox(child: raised_Button,width:g.null2dbl(m["set_width"], 100),);
    }
    else if(m.containsKey("set_height")){
      return Container(child: raised_Button,height: g.null2dbl(m["set_height"],30));
     }
    else if(m.containsKey("auto_width")){
      return Container( width: double.infinity,child: raised_Button,height: g.null2dbl(m["set_height"],30));
    }
    else {
      return raised_Button;
    }




  }
}