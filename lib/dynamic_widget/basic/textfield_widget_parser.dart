import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
//import 'package:scan/scan.dart';
import 'package:signature/signature.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../dynamic_widget.dart';
import '../../g.dart';
import '../../main.dart';
import '../utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'dart:io' as io;
//import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';



class TextFieldParser extends WidgetParser {

  final List<String> dtag;
  TextFieldParser(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    if(m["id"]==null){
      m["id"]=g.createid();
    }
    m["skey"]= dtag[0];
    if(!m["id"].toString().contains(".")){
      m["id"]=m["skey"]+"."+m["id"];
    }
    return textfield_ex(buildContext,m,listener);

  }

  @override
  String get widgetName => "TextField";
}

class textfield_ex extends StatefulWidget {

  final BuildContext ctx;
  final ClickListener listener;
  final  Map<String, dynamic> m;
  String cmdtag="";

  TextEditingController txtc =  TextEditingController();
  textfield_ex( this.ctx, this.m,this.listener);
  StreamController<String> eventx = null;



  String id() {
    return g.null2str(m["id"]);
  }
  String val(){
    // if(g.f[m["skey"]].containsKey(id())){
    //   txtc.text=g.f[m["skey"]][id()];
    // }
    return txtc.text;
  }
  String setval(String val){
    cmdtag="";
    txtc.text=val;
    try {
      if(eventx!=null){
        eventx.add(val);
      }
    }catch(e){}
  }
  String setcmd(String val){
    cmdtag="cmd";
    txtc.text=val;
    try {
      if(eventx!=null){
        eventx.add(val);
      }
    }catch(e){}
  }

  @override
  _textfield_exState createState() => _textfield_exState(m,txtc);

}

class _textfield_exState  extends State<textfield_ex> {

  final  Map<String, dynamic> m;
  String skey;

  String id="";
  String sval="";
  TextEditingController txtc = TextEditingController();
  _textfield_exState(this.m,this.txtc);
  int idatareq=0;

  String clickEvent="";
  EdgeInsetsGeometry vpadding =EdgeInsets.all(0.0);


  String last_edit_value="";
  List<String> tags = [];
  int tag = 0;
  String xval="";
  String tval="";
  var s="";
  int i_index_stack=0;

  int tab_index=0;


  String str_ui="";
  String split_chat=" ";

  Map<String, String> db= Map<String, String>();

  SignatureController pen_ctrl=null ;
  var btnx =null;
  var tabview_ui=null;
  String uitag="";

  List<String> select_value;

  List<bool> isSelected = [true, false];
  PageController pageview_control;
  //ScanController controller = ScanController();
  String ui_box="";
  var ui;
  List<Widget> tab_wg = new List<Widget>();


  List<String> d_list;
  List<String> v_list;

  List<String> d_listimg;


  int last_tab_index=-1;
  List<String> a;
  Map<String, dynamic> h= new Map<String, dynamic>();


  var tabview=null;

  @override
  void initState() {

    try{



      skey =g.null2str(m["skey"]);
      id=g.null2str(m["id"]);
      if(m.containsKey("vid")){
        id=g.null2str(m["vid"]);
      }

      if(m.containsKey("split_char")){
        split_chat=g.null2str(m["split_char"]);
      }



      id=g.getid(id);
      uitag=g.getuitag(m);


      // read data_value
      try{

        create_datalist();

      }catch(e){}



      if(uitag=="pen"){
        pen_ctrl = SignatureController(
          penStrokeWidth: m["pen_width"],
          penColor: Colors.black,
          exportBackgroundColor: Colors.white,
        );
      }

      pageview_control = PageController(
        keepPage: true,
      );

      // defalut data
      if(m.containsKey("data")){
        if(g.null2str(m["data"])!=""){
          txtc.text=g.null2str(m["data"]);
          g.saveiform(id, g.null2str(m["data"]));
        }
      }
      if(m.containsKey("edit_value")){
        txtc.text=g.null2str(m["edit_value"]);
        g.saveiform(id, g.null2str(m["edit_value"]));
      }
      if(m.containsKey("select_value")){
        select_value=g.null2str(m["select_value"]).toString().split(",");
      }






      if(m.containsKey("tabview")){
        tabview_ui=DynamicWidgetBuilder.buildWidgets(m['tabview'], widget.ctx, widget.listener);
      }else {
        tabview_ui=[Container()];
      }


      clickEvent = m.containsKey("click_event") ? m['click_event'] : "";
      if(g.null2str(m["follow_event"])=="true"||g.null2str(m["stream"])=="true" || g.str_in(uitag,"select_one,select_single,select_mutiple,image_picker")){
        widget.eventx = new StreamController();
        widget.eventx.stream.listen((data) {
          if(widget.cmdtag==""){
            setState(() {
              txtc.text=data;
            });
          }
        });

      }

      if(uitag=="switch"){
        if(m.containsKey("edit_value")){
          List<String> l=m["edit_value"].toString().split(" ");
          l.forEach((s) {
            db[s]=s;
          });
        }
        btnx = ValueNotifier("");
        btnx.addListener((){
          txtc.text=btnx.value;
          g.saveiform(id, txtc.text);
          run_cmd();
        });
      }

      if(m.containsKey("tabview")){
        tabview;
        tabview_ui=DynamicWidgetBuilder.buildWidgets(m['tabview'], widget.ctx, widget.listener);

      }





    }catch(e){}

    // g.savevfield(id, txtc.text);
    super.initState();


  }


  crete_tab(){

    setState(() {
      tab_wg.clear();
    });

    String stp = g.hashmap2json(m["ui_button"]);
    String stp_active = stp;
    if(m.containsKey("ui_buttonx")){
      stp_active=g.hashmap2json(m["ui_buttonx"]);
    }

    String tp;

    create_datalist();


    if(m.containsKey("value_select")){
      v_list = g.null2str(m["value_select"]).split(split_chat);
    }


    // tab_wg.clear();
    for(var i=0; i<d_list.length; i++){
      if(i==i_index_stack){
        tp=stp_active;
      }else {
        tp=stp;
      }
      tp=tp.replaceAll("{ui_index}","${i}");
      tp=tp.replaceAll("{text}",d_list[i]);

      tab_wg.add(
          Expanded(
              key: g.getnewkey(),
              child:
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  i_index_stack=i;
                  setState(() {
                    i_index_stack=i;
                  });
                  widget.listener.onClicked(g.null2str(m["cmd${i}"]));

                },
                child: IgnorePointer(child:DynamicWidgetBuilder.build(tp, context, new tclick(skey),skey)),
              )));
    }
  }

  crete_tabx(){

    setState(() {
      tab_wg.clear();
    });

    String stp = g.hashmap2json(m["ui_button"]);
    String stp_active = stp;
    if(m.containsKey("ui_buttonx")){
      stp_active=g.hashmap2json(m["ui_buttonx"]);
    }


    String tp;

    create_datalist();

    d_listimg = g.null2str(m["data_img"]).split(",");

    if(m.containsKey("value_select")){
      v_list = g.null2str(m["value_select"]).split(split_chat);
    }else {
      v_list=d_list;
    }


    for(var i=0; i<d_list.length; i++){

      // switch custom tab
      if(i==i_index_stack){
        tp=stp_active;
        if(m.containsKey("ui_button${i}x")){
          tp=g.hashmap2json(m["ui_button${i}x"]);
        }
      }else {
        tp=stp;
        if(m.containsKey("ui_button${i}")){
          tp=g.hashmap2json(m["ui_button${i}"]);
        }
      }


      tp=tp.replaceAll("{ui_index}","${i}");
      tp=tp.replaceAll("{text}",d_list[i]);
      if(d_list.length==d_listimg.length){
        tp=tp.replaceAll("{img}",d_listimg[i]);
      }
      tab_wg.add(
          Expanded(
              key: g.getnewkey(),
              child:
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  i_index_stack=i;
                  setState(() {
                    i_index_stack=i;
                    try{
                      txtc.text=v_list[i];
                    }catch(e){}
                  });
                  widget.listener.onClicked(g.null2str(m["cmd${i}"]));
                },
                child: IgnorePointer(child:DynamicWidgetBuilder.build(tp, context, new tclick(skey),skey)),
              )));
    }
  }




  void dispose() {

    try{

      if(widget.eventx!=null){
        widget.eventx.close();
      }
      if(btnx.eventx!=null){
        btnx=null;
      }
      txtc.dispose();

    }catch(e){}




    super.dispose();
  }


  getkeyboardtype(){

    switch(g.null2str(m["keyboardType"])){
      case "multiline":
        return TextInputType.multiline;
        break;
      case "datetime":
        return TextInputType.datetime;
        break;
      case "emailAddress":
        return TextInputType.emailAddress;
        break;
      case "name":
        return TextInputType.name;
        break;
      case "number":
        return TextInputType.number;
        break;
      case "phone":
        return TextInputType.phone;
        break;
      case "streetAddress":
        return TextInputType.streetAddress;
        break;
      case "text":
        return TextInputType.text;
        break;
      case "url":
        return TextInputType.url;
        break;
      case "values":
        return TextInputType.values;
        break;
      case "visiblePassword":
        return TextInputType.visiblePassword;
        break;
      case "values":
        return TextInputType.values;
        break;
      default:
        return TextInputType.text;
        break;
    }
  }

  save_field(String val){
    if(txtc.text!=val){
      setState(() {
        txtc.text=val;
      });
    }
    g.saveiform(m["id"], val);
    g.plink["active_value"]=val;
  }
  void data_change(int treq){
    if(m.containsKey("change2click")||m.containsKey("change2cmd")){
      int delay_time=g.cint(g.null2str(m["delay_time"]), 1000);
      Future.delayed(Duration(milliseconds: delay_time), () async {
        if(idatareq==treq){
          if(m.containsKey("change2click")){
            g.b_click=g.null2str(m["change2click"]);
          }
          if(m.containsKey("change2cmd")){
            g.run_cmd=g.null2str(m["change2cmd"]);
          }
        }
      });
    }
  }

  int getireq(){
    idatareq+=1;
    return idatareq;
  }
  get_align(){

    var r=TextAlign.start;
    switch(m["textAlign"]){
      case "start":
        r=TextAlign.start;
        break;
      case "left":
        r=TextAlign.left;
        break;
      case "right":
        r=TextAlign.right;
        break;
      case "center":
        r=TextAlign.center;
        break;
    }
    return r;
  }

  gettextver(){
    var r=TextAlignVertical.center;
    switch(m["textAlignVertical"]){
      case "top":
        r=TextAlignVertical.top;
        break;
      case "center":
        r=TextAlignVertical.center;
        break;
      case "bottom":
        r=TextAlignVertical.bottom;
        break;
    }
    return r;
  }


  run_cmd(){
    if (m.containsKey("run_cmd")) {
      g.run_cmd = g.null2str(m["run_cmd"]);
    }
  }
  /*
  rebuild_tab(int itap){


    setState(() {
      tab_wg.clear();
    });




    g.bmsg("rebuild tab ${itap}");
    String stp = g.hashmap2jsonstring(m["ui_button"]);
    String tp;
     create_datalist();
    for(var i=0; i<=d_list.length; i++){
      tp=stp;
      if(i==itap+1){
        tp=tp.replaceAll("{tab_color}","#FF0000");
      }else {
        tp=tp.replaceAll("{tab_color}","#303030");
      }
      tp=tp.replaceAll("{ui_index}","${i} ${g.getrunseq()}");


      tab_wg.add(
        get_tab(i)
          );

    }
    return tab_wg;

  }*/
  tab_change(int index,String tag){


    try{

      g.plink["this_value"]=select_value[index].toLowerCase();
      if(m.containsKey("one_cmd${index}")){
        g.run_cmd=g.null2str(m["one_cmd${index}"]);
        g.tmsg(g.run_cmd);
        m.remove("one_cmd${index}");
      }
      if(m.containsKey("run_cmd${index}")){
        g.run_cmd=g.null2str(m["run_cmd${index}"]);
        //g.tmsg(g.run_cmd);
      }
      run_cmd();

    }catch(e){}
  }

  value_change(String r){
    g.plink["f_editvalue"]=r;
    setState(() {
      g.plink["f_editvalue"]=r;
      txtc.text = r;
    });
  }

  get_tab(int ix){




    String stp = g.hashmap2json(m["ui_button"]);
    String tp;
    tp=tp.replaceAll("{ui_index}","${i} ${g.getrunseq()}");


    if(last_tab_index!=-1){
      tab_wg[last_tab_index]=get_tab(last_tab_index);
    }


    last_tab_index=ix;

    return  Expanded(child:
    GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          tab_wg[ix]=get_tab(ix);
        });
      },
      child: IgnorePointer(child:DynamicWidgetBuilder.build(tp, context, new tclick(skey),skey)),
    ));


  }




  change_cmd(){

    try{
      if(m.containsKey("edit2click")){
        g.t_click=g.null2str(m["edit2click"]);
      }
      if(m.containsKey("edit2cmd")){
        g.run_cmd=g.null2str(m["edit2cmd"]);
      }

    }catch(e){}

  }


  create_datalist(){
      try {
        d_list = g.null2str(m["data_select"]).split(split_chat);
      }catch(e){}
      if(m.containsKey("value_select")){
        v_list = g.null2str(m["value_select"]).split(split_chat);
      }


  }

  bool check_value_list(){
    try{
      if(v_list.length==d_list.length){
        return true;
      }
    }catch(e){}
    return false;
  }

  @override
  Widget build(BuildContext context) {


    // if(id.contains(".")){
    //   if(ids.length==2){
    //     if(g.f[ids[0]].containsKey(ids[1])){
    //       txtc.text=g.null2str(g.f[ids[0]][ids[1]]);
    //     }
    //   }
    // }


    /*  if(g.isfoundfield(m["id"])){
      setState(() {
        txtc.text=g.getdatafield(m["id"]);
      });
    }*/




    if (m.containsKey("bind_data")) {
      a = g.null2str(m["bind_data"]).split(".");
      if (g.db.containsKey(a[0])) {
        try {
          h = g.db[a[0]][g.cint(a[1], 0)];
          txtc.text = g.null2str(h[a[2]]);
        } catch (e) {}
      }
    }


    bool fieldenable=true;
    if(g.null2str(m["enabled"])=="false"){
      fieldenable=false;
    }

    Color border_color=g.getcolor("#BBBCB9");

    if(m.containsKey("border_color")){
      border_color=g.getcolor(m["border_color"]);
    }



    bool is_secut=(m["obscureText"]=="true");

    var rui,lui;
    lui=null;
    rui=null;
    if(g.null2str(m["clear_button"])=="true"){
      rui=IconButton(
        onPressed: () {

          try{
            txtc.clear();
            g.saveiform(m["id"], txtc.text);
            data_change(getireq());
          }catch(e){
            print("printTextField.error."+e.toString());
          }
        },
        icon: Icon(Icons.clear,size: 20.0),
      );
    }
    var r_icon;
    if(m.containsKey("r_ui")){
      rui=  DynamicWidgetBuilder.build(jsonEncode(m["r_ui"]).toString(), widget.ctx, widget.listener,skey);
    }
    if(m.containsKey("l_ui")){
      lui=  DynamicWidgetBuilder.build(jsonEncode(m["l_ui"]).toString(), widget.ctx, widget.listener,skey);
    }

    var vh=g.cdbl(g.null2str(m["height"]),48);
    if(g.null2str(m["height"])=="fill"){
      vh=double.infinity;
    }






    switch(uitag){




      case "rating_bar":


        ui=
            IgnorePointer(
                ignoring:g.null2str(m["readonly"])=="true"?true:false,
                child: RatingBar.builder(
                  itemSize:  g.cdbl(m["item_size"], 30.0),
                  initialRating: g.cdbl(txtc.text,4.0),
                  minRating: g.cdbl(m["min_rating"], 0),
                  direction: Axis.horizontal,
                  itemCount: g.cint(m["item_count"], 5),
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    value_change(rating.toString());
                    if(m.containsKey("fclick_event")){
                      widget.listener.onClicked(m["fclick_event"]);
                    }
                  },
                ));
        break;
      case "scanview":
        ui=Text("scanview");
        /*
        ui=ScanView(
          controller: controller,
          scanAreaScale: 1.0,
          scanLineColor: Colors.green.shade400,
          onCapture: (data) {
            g.plink["get_barcode"]=data;
            run_cmd();

            Future.delayed(Duration(milliseconds: 1000), () async {
              controller.resume();

            });
            // do something
          },
        );*/
        break;
      case "slider":
        ui=  Slider(
          value:  g.cdbl( txtc.text,1),
          min: m.containsKey("min")?m["min"]:0.0,
          max: m.containsKey("max")?m["max"]:100.0,
          divisions: m.containsKey("divisions")?g.cintx(m["divisions"]):100,
          label:txtc.text,
          onChanged: (double value) {
            setState(() {
              txtc.text = value.toString();
            });
          },
        );
        break;
      case "button_switch":
        try {
          tab_index = g.getvalue_index(txtc.text, select_value);
          ui = Container(
              height: g.cdbl(m["ui_height"], 40.0),
              child:
              ToggleSwitch(
                initialLabelIndex: tab_index,
                minWidth: g.cdbl(m["min_width"], 72.0),
                borderColor: [g.getcolor2(m["border_color"], "#EEAE5C")],
                cornerRadius: g.cdbl(m["border_raduis"], 8.0),
                borderWidth: g.cdbl(m["border_width"], 1.0),
                activeBgColor: [g.getcolor2(m["bk_color_active"], "#5AA778")],
                inactiveBgColor: g.getcolor2(m["bk_color"], "#FFFFFF"),
                activeFgColor: g.getcolor2(m["text_color_active"], "#000000"),
                inactiveFgColor: g.getcolor2(m["text_color"], "#303030"),
                dividerColor: Colors.transparent,
                totalSwitches: select_value.length,
                labels: select_value,
                onToggle: (index) {

                  setState(() {
                    tab_index = index;
                    txtc.text = select_value[index];
                  });



                  if(m.containsKey("run_cmd${index}")){
                    g.run_cmd=g.null2str(m["run_cmd${index}"]);
                  }
                  run_cmd();
                  /* pageview_control.animateToPage(
                      index, duration: Duration(milliseconds: 10),
                      curve: Curves.ease);*/



                  //tab_change(tab_index);
                },
              ));

          if (m.containsKey("tabview")) {
            ui = Column(
                children: [ui, Expanded(child:

                IndexedStack(
                    index: tab_index,
                    children: tabview_ui))

                ]);
          }
        }catch(e){}
        break;
      case "radio_button":
        ui=
            Column(
              children: [

                RadioListTile(
                  title: Text("Male"),
                  value: "male",
                  groupValue: txtc.text,
                  onChanged: (value){
                    setState(() {
                      txtc.text = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: Text("Female"),
                  value: "female",
                  selected: true,
                  groupValue: txtc.text,
                  onChanged: (value){
                    setState(() {
                      txtc.text = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: Text("Other"),
                  value: "other",
                  groupValue: txtc.text,
                  onChanged: (value){
                    setState(() {
                      txtc.text = value.toString();
                    });
                  },
                )
              ],
            );



        break;

      case "checkbox":
        ui= Checkbox(
          checkColor: g.getcolor2(m["checkColor"], "#33C559"),
          activeColor: g.getcolor2(m["activeColor"], "#E1E1E1") ,
          value: txtc.text=="1"||txtc.text=="true"? true:false,
          onChanged: (bool value) {
            setState(() {
              if(value){
                txtc.text="1";
              }else {
                txtc.text="0";
              }
            });


          },
        );
        break;
      case "toggle_switch":
        ui=CupertinoSwitch(
          trackColor: g.getcolor2(m["trackColor"], "#33C559"),
          activeColor: g.getcolor2(m["activeColor"], "#E1E1E1") ,
          value: txtc.text=="1"||txtc.text=="true"? true:false,
          onChanged: (value) {
            setState(() {
              if(value){
                txtc.text="1";
              }else {
                txtc.text="0";
              }
            });
            g.plink["f_editvalue"]= txtc.text;
            change_cmd();
            run_cmd();
          },
        );

        break;
      case "switch":

        Map<String, String> d=Map<String, String>();
        double border_radius=12.0;
        double h_space=  g.cdbl(m["h_space"],20.0);
        double v_space=g.cdbl(m["v_space"],10.0);
        double border_width=1.0;
        Color text_color_active=g.getcolor2(m["text_color_active"],"#000000");
        Color text_color=g.getcolor2(m["text_color"],"#303030");
        Color select_bk_color=g.getcolor2(m["select_bk_color"],"#303030");
        Color bk_color=Colors.white70;
        Color border_color=g.getcolor2(m["border_color"],"#F3F3F3");




        /* Color text_color_active=g.getcolor2(m["text_color_active"],"#000000");
      Color text_color=g.getcolor2(m["text_color"],"#303030");
      Color select_bk_color=g.getcolor2(m["select_bk_color"],"#F3F3F3");
      Color bk_color=g.getcolor2(m["bk_color"],"#FFFFFF");
      Color border_color=g.getcolor2(m["border_color"],"#5AB9C1");*/





        ui= Container(
            decoration: BoxDecoration(
                borderRadius:  BorderRadius.all(Radius.circular(border_radius)), // BorderRadius
                border: Border.all(width:border_width,color: border_color)
            ),

            child:AdvancedSegment(
              controller: btnx, // AdvancedSegmentController
              segments: db,

              activeStyle: TextStyle( // TextStyle
                color: text_color_active,
                fontWeight: FontWeight.w600,
              ),
              inactiveStyle: TextStyle( // TextStyle
                color: text_color,
              ),
              backgroundColor: bk_color, // Color
              sliderColor:select_bk_color, // Color
              sliderOffset: 2.0, // Double
              borderRadius:  BorderRadius.all(Radius.circular(border_radius)), // BorderRadius
              itemPadding:  EdgeInsets.symmetric( // EdgeInsets
                horizontal: h_space,
                vertical: v_space,
              ),
              /*shadow: const <BoxShadow>[
                 BoxShadow(
                   color: Colors.black26,
                   blurRadius: 0.0,
                 ),
               ],*/
              animationDuration: Duration(milliseconds: 100),
            ));


        break;



      case "image":

        var isoimg=g.null2str(m["oimg"]);
        int img_width=g.cint(m["img_width"], 300);
        var border_width=null;

        if(m.containsKey("border_width")){
          border_width=Border.all(
            color: g.getcolor2(g.null2str(m["border_color"]), "#FFFFFF"),
            width: g.cdbl(g.null2str(m["border_width"]),4.0),
          );
        }

        if(isoimg=="true"){
          ui= Container(
            width:  m.containsKey("width") ? m["width"] : 30.0,
            height: m.containsKey("height") ? m["height"] : 30.0,
            decoration: BoxDecoration(
              color: g.getcolor2(g.null2str(m["border_color"]), "#FFFFFF"),
              image: DecorationImage(
                image: CachedNetworkImageProvider(txtc.text,maxWidth: img_width,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all( Radius.circular(50.0)),
              border: border_width,
            ),
          );
        }else {

          ui= SizedBox(
              width: m.containsKey("width") ? m["width"] : 30.0,
              height: m.containsKey("height") ? m["height"] : 30.0,
              child: CachedNetworkImage(
                  fadeOutDuration:  const Duration(milliseconds: 0),
                  fadeInDuration: const Duration(milliseconds: 0),
                  maxWidthDiskCache: img_width,
                  fit: BoxFit.cover,
                  imageUrl:  widget.txtc.text
              )
          );
        }

        break;

      case "image_picker":

        try{

          sval = g.null2str(m["ui_img"]);
          sval = sval.replaceAll("{v}", txtc.text);

          String defimg=g.null2str(m["defimg"]);
          if(defimg==""){
            defimg=g.null2str(m["nullimg"]);
          }



          if(txtc.text==""){
            ui=Container(
                width: m["width"],
                height: m["height"],
                child: Image.network(defimg));
          }else {

            int img_width=g.cint(g.null2str(m["img_width"]),400);
            ui=Image.file(
              io.File(txtc.text),
              fit:BoxFit.cover,
              width: m["width"],
              height: m["height"],
              cacheWidth: img_width,
              filterQuality: FilterQuality.medium,
              scale: 0.75,
            );
          }
        }catch(e){}



        break;


      case "image_pickerx":
      //sval =jsonEncode(m['child']).toString();
      // sval = sval.replaceAll("{v}",txtc.text);

        ui =

            Column(children: [
              SizedBox(
                  width: m.containsKey("width") ? m["width"] : 30.0,
                  height: m.containsKey("height") ? m["height"] : 30.0,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(),
                    imageUrl:txtc.text ,
                    errorWidget: (context, url, error) => Image.network(txtc.text ),
                  )
              ),

              Container(height: vh,
                  padding: EdgeInsets.fromLTRB(0,2,0,2),
                  child:
                  TextField(
                      autofocus:  m.containsKey("autofocus") ? m['autofocus'] : false,
                      textAlign:get_align(),
                      textAlignVertical: gettextver(),
                      autocorrect:false,
                      key: g.getnewkey(),
                      enabled:fieldenable,
                      obscureText: is_secut,
                      maxLines: m["maxLines"],
                      expands: true,
                      style: TextStyle(),
                      controller: txtc))

            ],);


        /*
            SizedBox(
                width: m.containsKey("width") ? m["width"] : 30.0,
                height: m.containsKey("height") ? m["height"] : 30.0,
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(),
                  imageUrl: sval,
                  errorWidget: (context, url, error) => Image.network(sval),
                )
            );*/


        /*  str_ui=jsonEncode(m['child']).toString();
      str_ui=str_ui.replaceAll("{src}", txtc.text);
      ui=DynamicWidgetBuilder.buildFromMap(jsonDecode(str_ui),  widget.ctx,widget.listener);

    */
        break;

      case "pen":

        var img_reset,img_save,img_redo,img_undo;

        img_reset=Container(width: 0,height: 0,);
        img_save=Container(width: 0,height: 0,);
        img_redo=Container(width: 0,height: 0,);
        img_undo=Container(width: 0,height: 0,);

        if(m.containsKey("img_reset")){
          img_reset=InkWell(
              onTap: () {
                pen_ctrl.clear();
              },
              child: CachedNetworkImage( width:32.0,height:32.0,imageUrl: m["img_reset"]));
        }
        if(m.containsKey("img_save")){
          img_save=InkWell(
              onTap: () async {
                try {

                  if(pen_ctrl.isNotEmpty){
                    txtc.text = await g.save2photofile(await pen_ctrl.toPngBytes());
                    if (m.containsKey("t_click")) {
                      g.t_click = g.null2str(m["t_click"]);
                    }
                    run_cmd();
                  }
                }catch(e){}


              },
              child: CachedNetworkImage( width:32.0,height:32.0,imageUrl: m["img_save"]));
        }
        if(m.containsKey("img_redo")){
          img_redo=InkWell(
              onTap: () {
                pen_ctrl.redo();
              },
              child: CachedNetworkImage( width:32.0,height:32.0,imageUrl: m["img_redo"]));
        }
        if(m.containsKey("img_undo")){
          img_undo=InkWell(
              onTap: () {
                pen_ctrl.undo();
              },
              child: CachedNetworkImage( width:32.0,height:32.0,imageUrl: m["img_undo"]));
        }




        ui=
            Column(children: [
              Signature(
                controller: pen_ctrl,
                width:g.get_width(m["width"]),
                height: m["height"],
                backgroundColor: g.getcolor2(m["backgrond_color"], "#FFFFFF"),
              ),
              Container(height: 1,color: g.getcolor("#F3F3F3"),),
              Row(
                children: [
                  img_reset,
                  img_redo,
                  img_undo,
                  Spacer(),
                  Container(height: 5,),
                  Row(
                    children: [
                      img_save
                    ],)
                ],)

            ],);



        break;

      case "dropdown2":
        d_list=m["data_select"].split(",");
        if(txtc.text==""){
          txtc.text=d_list[0];
        }

        var dmode=Mode.MENU;
        if(g.null2str(m["mode"])=="dialog"){
          dmode=Mode.DIALOG;
        }
        if(g.null2str(m["mode"])=="bottom_sheet"){
          dmode=Mode.BOTTOM_SHEET;
        }


        ui=
            Container(
                height: 44.0,
                child:DropdownSearch<String>(
                  mode: dmode,
                  showSearchBox:m["show_searchbox"]=="false"?false:true,
                  dropdownSearchDecoration:InputDecoration(labelText: g.cstr(m["label"], "Select")),
                  showSelectedItems: true,
                  items:d_list,
                  onChanged: print,
                  selectedItem: txtc.text,
                ) );
        break;

      case "dropdown_textfield":

        d_list=m["data_select"].split(",");
        if(txtc.text==""){
          txtc.text=d_list[0];
        }

        ui=   DropdownButtonFormField<int>(
            hint: Text("hintText"),
            isExpanded: true,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                isDense: true),
            items: d_list
                .map<DropdownMenuItem<int>>((String value) {
              return DropdownMenuItem<int>(
                value: 0,
                child: TextOneLine(value),);}).toList());
        break;

      case "dropdown":
        d_list=m["data_select"].split(",");
        if(txtc.text==""){
          txtc.text=d_list[0];
        }
        ui=
            Container( height: vh-5,
                padding: EdgeInsets.fromLTRB(5,0,0,0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color:border_color, style: BorderStyle.solid, width: 1.0),
                ),
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  isExpanded: true,
                  value:txtc.text,
                  onChanged: (String val) {

                    g.saveiform(m["id"], val);
                    setState(() {
                      txtc.text=val;
                    });
                  },
                  items: d_list
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),);}).toList(),
                ));
        break;


      case "tab":
        try {
          ui= Column(children: [Row(children: tab_wg),
            IndexedStack(
                index: i_index_stack,
                children:tabview_ui)
          ]);

        }catch(e){}
        break;
      case "select_one":
      case "select_single":

      create_datalist();


        if(txtc.text==""){
          if(d_list.length>0){
            txtc.text = d_list[0];
          }
        }



        // set default value
        int i = 0;
        if(txtc.text!=""){
          d_list.forEach((sx) {
            if (sx == txtc.text) {
                tag = i;
            }
            i += 1;
          });
        }


        var i_spacing = g.cdbl(g.null2str(m["spacing"]), 2.0);
        var border_radius=g.cdbl(g.null2str(m["border_radius"]), 25.0);


        var vmargin=EdgeInsets.fromLTRB(0,0,3,0);
        var vpadding= EdgeInsets.fromLTRB(3,0,3,0);

        if(m.containsKey("margin")){
          vmargin=parseEdgeInsetsGeometry(m['margin']);
        }
        if(m.containsKey("padding")){
          vpadding=parseEdgeInsetsGeometry(m['padding']);
        }


        var cstyle = C2ChoiceStyle(showCheckmark: false,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            borderWidth: g.cdbl(m["border_width"], 0),
            margin: vmargin,
            padding:vpadding,
            brightness: Brightness.dark,
            color: g.getcolor(g.strx(m["background_color"], "#D0D0D0")),
            labelStyle: TextStyle(
                color: g.getcolor(g.strx(m["text_color"], "#000000"))),
            borderShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(border_radius)),
                side: BorderSide(
                    color: g.getcolor(g.strx(m["border_color"], "#FFFFFF")))
            ));

        var cstyle_active = C2ChoiceStyle(showCheckmark: false,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            borderWidth: g.cdbl(m["border_width"], 0),
            margin: vmargin,
            padding:vpadding,
            brightness: Brightness.dark,
            color: g.getcolor(
                g.strx(m["select_background_color"], "#735FB0")),
            labelStyle: TextStyle(
                color: g.getcolor(g.strx(m["select_color"], "#FFFFFF"))),
            borderShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(border_radius)),
                side: BorderSide(
                    color: g.getcolor(g.strx(m["select_border_color"], "#FFFFFF")))
            ));


        ui = Container(
            padding: EdgeInsets.fromLTRB(0,10,0,0),
            child:
            ChipsChoice<int>.single(
              spacing: i_spacing,
              padding: EdgeInsets.all(0),
              choiceStyle: cstyle,
              choiceActiveStyle: cstyle_active,
              value: tag,
              wrapped: m.containsKey("wrapped")? m["wrapped"]:false,
              direction:g.null2str(m["dir"])=="v"? Axis.vertical:Axis.horizontal,
              onChanged: (vindex) {

                try {
                  setState(() {
                    tag = vindex;
                    i_index_stack=vindex;
                    txtc.text = d_list[vindex];
                  });

                  tval= d_list[vindex];

                  if(check_value_list()){
                    tval= v_list[vindex];
                  }


                  g.plink["edit_value"] = tval;
                  g.saveiform(id, tval);

                  try{
                    if(m.containsKey("saveto")){



                      if(check_value_list()){
                        xval=g.null2str(m["saveto"]).replaceAll("{this_value}",v_list[vindex].toString());
                      }else {
                        xval=g.null2str(m["saveto"]).replaceAll("{this_value}",d_list[vindex].toString());
                      }
                      g.savedata("",xval);
                    }
                  }catch(e){}

                  // g.alert("${g.iform[g.active_key]}");
                } catch (e) {
                  g.alert("select_one.error:${e}");
                }

                if (m.containsKey("t_click")) {
                  g.t_click = m["t_click"];
                }
                if (m.containsKey("t_click2")) {
                  g.t_click =
                      (g.null2str(m["t_click2"]) + "_" + txtc.text)
                          .toLowerCase();
                }
                if (m.containsKey("run_cmd")) {
                  g.run_cmd =g.null2str(m["run_cmd"]);
                }
                // by name
                tval="cmd_"+d_list[vindex].toLowerCase();
                print("find_cmd:${tval}");
                if (m.containsKey(tval)) {
                  g.run_cmd =g.null2str(m[tval]);
                }
                // by index
                tval="cmd_"+vindex.toString();
                print("find_cmd:${tval}");

                if (m.containsKey(tval)) {
                  g.run_cmd =g.null2str(m[tval]);
                }


              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: d_list,
                value: (i, v) => i,
                label: (i, v) => v,
              ),

            ));


        if(m.containsKey("tabview")){
          i_index_stack=tag;
          double vspace=g.cdbl(g.null2str(m["tab_body_space"]),0);
          if(g.null2str(m["wrap_by"])=="row"){
            ui= Row(
                children: [ui,
                  Container(height: vspace),
                  IndexedStack(
                      index: i_index_stack,
                      children: tabview_ui)
                ]);
          }else {
            ui= Column(
                children: [ui,
                  Container(height: vspace),
                  IndexedStack(
                      index: i_index_stack,
                      children: tabview_ui)
                ]);
          }
        }



        /*  ui=Column(children: [ui,
        TextField(controller: txtc,)
      ],);*/


        break;



      case "select_mutiple":
        create_datalist();

        tags.clear();
        txtc.text.split(" ").forEach((sx) {
          tags.add(sx.trim());
        });


        var i_spacing = g.cdbl(g.null2str(m["spacing"]), 2.0);
        var border_radius=g.cdbl(g.null2str(m["border_radius"]), 25.0);


        var vmargin=EdgeInsets.fromLTRB(0,0,3,0);
        var vpadding= EdgeInsets.fromLTRB(3,0,3,0);

        if(m.containsKey("margin")){
          vmargin=parseEdgeInsetsGeometry(m['margin']);
        }
        if(m.containsKey("padding")){
          vpadding=parseEdgeInsetsGeometry(m['padding']);
        }

        var cstyle = C2ChoiceStyle(showCheckmark: false,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            borderWidth: g.cdbl(m["border_width"], 0),
            elevation: 0.0,
            margin: vmargin,
            padding:vpadding,
            brightness: Brightness.dark,
            color: g.getcolor(g.strx(m["background_color"], "#D0D0D0")),
            labelStyle: TextStyle(
                color: g.getcolor(g.strx(m["text_color"], "#000000"))),
            borderShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(border_radius)),
                side: BorderSide(
                    color: g.getcolor(g.strx(m["border_color"], "#FFFFFF")))
            ));

        var cstyle_active = C2ChoiceStyle(showCheckmark: false,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            borderWidth: g.cdbl(m["border_width"], 0),
            elevation: 0.0,
            margin: vmargin,
            padding:vpadding,
            brightness: Brightness.dark,
            color: g.getcolor(
                g.strx(m["select_background_color"], "#735FB0")),
            labelStyle: TextStyle(
                color: g.getcolor(g.strx(m["select_color"], "#FFFFFF"))),
            borderShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(border_radius)),
                side: BorderSide(
                    color: g.getcolor(g.strx(m["select_border_color"], "#FFFFFF")))
            ));

        // if(m.containsKey("data")){

        // }

        ui = Container(
            padding: EdgeInsets.fromLTRB(0,10,0,0),
            child:
            ChipsChoice<String>.multiple(
              spacing: i_spacing,
              padding: EdgeInsets.all(0),
              value: tags,
              choiceStyle: cstyle,
              choiceActiveStyle: cstyle_active,
              wrapped: m.containsKey("wrapped")? m["wrapped"]:false,
              direction:g.null2str(m["dir"])=="v"? Axis.vertical:Axis.horizontal,
              onChanged: (val) =>

                  setState(() {

                    try{

                      tags = val;
                      s = "";
                      d_list.forEach((s1) {
                        if(val.contains(s1)){
                          s += s1 + split_chat;
                        }
                      });
                      s = g.rcut(s);
                      txtc.text = s;


                      if(m.containsKey("select_limit")){
                        if(s.split(" ").length>m["select_limit"]){
                          txtc.text = last_edit_value;
                          if (m.containsKey("ncmd")) {
                            g.t_click = m["ncmd"];
                          }
                          if(m.containsKey("nalert")){
                            g.bmsg(m["nalert"]);
                          }
                        }else {
                          last_edit_value=s;
                        }
                      }


                      g.plink["edit_value"] = s;
                      g.saveiform(id, s);

                      if (m.containsKey("vid")) {
                        g.savevfield(m["vid"], txtc.text);
                      }
                      if (m.containsKey("vname")) {
                        g.plink[m["vname"]] = txtc.text;
                      }

                      if (m.containsKey("t_click")) {
                        g.t_click = m["t_click"];
                      }
                      if (m.containsKey("t_click2")) {
                        g.t_click =
                            (g.null2str(m["t_click2"]) + "_" + txtc.text)
                                .toLowerCase();
                      }


                    } catch (e) {}



                  }),
              choiceItems: C2Choice.listFrom<String, String>(
                source: d_list,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
            ));
        /*   ui=Column(children: [ui,
        TextField(controller: txtc,)
      ],);*/

        break;

      case "date":
      case "time":
      case "datetime":
      case "datetime2":

        String sformat="dd/MM/yyyy hh:mm";
        var dtype=DateTimePickerType.date;

        switch(uitag){
          case "date":
            sformat="dd/MM/yyyy";
            dtype=DateTimePickerType.date;
            if(txtc.text==""){
              setState(() {
                txtc.text= DateFormat('dd/MM/yyyy'). format(DateTime.now());
              });
            }
            break;
          case "time":
            sformat="hh:mm";
            dtype=DateTimePickerType.time;
            if(txtc.text==""){
              setState(() {
                txtc.text= DateFormat('hh:mm'). format(DateTime.now());
              });
            }
            break;
          case "datetime":
            sformat="dd/MM/yyyy hh:mm";
            dtype=DateTimePickerType.dateTime;
            if(txtc.text==""){
              setState(() {
                txtc.text= DateFormat('dd/MM/yyyy hh:mm'). format(DateTime.now());
              });
            }

            break;
          case "datetime2":
            sformat="dd/MM/yyyy hh:mm";
            dtype=DateTimePickerType.dateTimeSeparate;
            if(txtc.text==""){
              setState(() {
                txtc.text= DateFormat('dd/MM/yyyy hh:mm'). format(DateTime.now());
              });
            }
            break;
        }

        if(m.containsKey("format")){
          sformat=m["format"];
        }



        // g.tmsg("datetime_value=${txtc.text}");
        ui =

            Container(
                padding: EdgeInsets.fromLTRB(5,0,0,0),
                height: 45,
                decoration: BoxDecoration(
                  color: m.containsKey("background_color")? g.getcolor(m["background_color"]):Colors.transparent,
                  border: Border.all(
                    color: border_color,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child:
                DateTimePicker(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  type: dtype,
                  dateMask:sformat ,
                  dateHintText:m.containsKey("hintText")?m["hintText"]:"" ,
                  use24HourFormat: true,
                  initialValue: "02/02/2022",
                  firstDate: DateTime(g.cint(g.null2str(m["start_year"]), DateTime.now().year-150)),
                  lastDate: DateTime(g.cint(g.null2str(m["end_year"]), DateTime.now().year+150)),
                  dateLabelText:g.null2str2(m["date_label"], ""),
                  timeLabelText:g.null2str2(m["time_label"], ""),
                  selectableDayPredicate: (date) {
                    return true;
                  },
                  onChanged: (val) {
                    g.saveiform(m["id"], val);
                    txtc.text = val;
                    g.pvar["dropdown_value"]=val;
                    if(m.containsKey("save2link")){
                      g.plink[g.null2str(m["save2link"])]=val;
                    }
                    data_change(getireq());
                    if(m.containsKey("edit_click")){
                      g.t_click=g.null2str(m["edit_click"]);
                    }

                  },
                  onEditingComplete: (){
                    if(m.containsKey("done_click")){
                      g.t_click=g.null2str(m["done_click"]);
                    }
                    //do your stuff
                  },
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val){
                    txtc.text= val;
                    g.pvar["dropdown_value"]=val;
                    //sendclick(txtc.text);
                  },
                )
            );
        break;
      case "tabx":

        crete_tabx();
        ui=
            Column(children: [Row(children: tab_wg),
              IndexedStack(
                  index: i_index_stack,
                  children:tabview_ui)
            ]);

        break;

      default:
        EdgeInsetsGeometry cpadding =EdgeInsets.fromLTRB(6.0, 0.0, 2.0, 6.0);
        if(m.containsKey("contentPadding")){
          cpadding = parseEdgeInsetsGeometry(m['contentPadding']);
        }


        if(m.containsKey("backgrond_color") && !m.containsKey("border_color")){
          m["border_color"]=m["background_color"];
        }

        Color bkcolor=Colors.transparent;
        if(m.containsKey("background_color")){
          bkcolor=g.getcolor(m["background_color"]);
        }

        var b=InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder:  OutlineInputBorder(
            borderSide:  BorderSide(color: g.getcolor2(g.null2str(m["border_color"]), g.gborder_color), width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(m.containsKey("border_radius")? m["border_radius"] : 9.0)),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide:  BorderSide(color: g.getcolor2(g.null2str(m["border_color"]), g.gborder_color), width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(m.containsKey("border_radius")? m["border_radius"] : 9.0)),
          ),
          border:  OutlineInputBorder(
            borderSide:  BorderSide(color: g.getcolor2(g.null2str(m["border_color"]), g.gborder_color), width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(m.containsKey("border_radius")? m["border_radius"] : 9.0)),
          ),
          filled: true,
          fillColor: bkcolor,
          focusColor:bkcolor,
          hoverColor:bkcolor,

          hintText: g.null2str(m["hintText"]),
          labelText:g.null2str(m["labelText"]),
          contentPadding:cpadding,
          prefixIcon: lui,
          suffixIcon: rui,
        );


        if(g.null2str(m["text_style"])=="noline"){
          b=InputDecoration(

            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:cpadding,
            prefixIcon: lui,
            suffixIcon: rui,
            filled: true,
            fillColor: g.getcolor2(g.null2str(m["background_color"]), "#FFFFFF"),
            focusColor:g.getcolor2(g.null2str(m["background_color"]), "#FFFFFF"),
            hoverColor:g.getcolor2(g.null2str(m["background_color"]), "#FFFFFF"),
            hintText: g.null2str(m["hintText"]),
            labelText:g.null2str(m["labelText"]),
          );
        }


        if(g.null2str(m["text_style"])=="flat"){
          b=InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: g.getcolor(g.cstr(g.null2str(m["border_color"]), "#A0A0A0"))),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:BorderSide(color: g.getcolor(g.cstr(g.null2str(m["border_color"]), "#A0A0A0"))),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: g.getcolor(g.cstr(g.null2str(m["border_color"]), "#A0A0A0"))),
            ),
            hintText: g.null2str(m["hintText"]),
            labelText:g.null2str(m["labelText"]),
            contentPadding:cpadding,
            prefixIcon: lui,
            suffixIcon: rui,

          );

          InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            hintText: g.null2str(m["hintText"]),
            labelText:g.null2str(m["labelText"]),
            contentPadding:cpadding,
            prefixIcon: lui,
            suffixIcon: rui,
          );
        }

        var w=double.infinity;
        if(m.containsKey("width")){
          w=m["width"];
        }
        // maincase
        ui=Container(height: vh,
            width:w ,
            padding: EdgeInsets.fromLTRB(0,2,0,2),
            child:TextField(
                autofocus:  m.containsKey("autofocus") ? m['autofocus'] : false,
                textAlign:get_align(),
                textAlignVertical: gettextver(),
                autocorrect:false,
                key: g.getnewkey(),
                enabled:fieldenable,
                obscureText: is_secut,
                maxLines:m["maxLines"],
                expands: m.containsKey("expands")?m["expands"]:false,
                decoration: b,
                controller: txtc,
                keyboardType:getkeyboardtype(),
                onChanged: (String val) async {
                  try{
                    if(m.containsKey("max_len")){
                      if(val.length > m["max_len"]){
                        setState(() {
                          val=val.substring(0,m["max_len"]);
                          txtc.text=val;
                        });
                        if(m.containsKey("nalert")){
                          g.bmsg(m["nalert"]);
                        }
                        if(m.containsKey("ncmd")){
                          g.t_click=g.null2str(m["ncmd"]);
                        }
                      }

                    }

                    if(txtc.text!=val){
                      txtc.text=val;
                    }
                    g.saveiform(m["id"], val);
                    data_change(getireq());
                    g.plink["active_value"]=val;

                    change_cmd();



                  }catch(e){
                    print("printTextField.error."+e.toString());
                  }
                },
                onEditingComplete: (){
                  if(m.containsKey("done_click")){
                    g.t_click=g.null2str(m["done_click"]);
                  }
                  //do your stuff
                }
            ));

        break;

    }


    ui_box=g.null2str(m["ui_box"]);
    if(g.str_in2(ui_box, "date,datetime,time")){

      ui= GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {

          // reset
          xval="";
          if(ui_box.contains("date")) {
            String date_format = g.cstr(g.cmdval("date_format"), "dd/MM/yyyy");
            DateTime selectedDate = DateTime.now();
            final DateTime dt = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2200)
            );
            xval = DateFormat(date_format).format(dt);
          }
          if(ui_box.contains("time")) {
            TimeOfDay selectedTime = TimeOfDay.now();
            final TimeOfDay pick_time = await showTimePicker(
                context: context,
                initialTime: selectedTime, builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                child: child,
              );});
            xval+=" ${pick_time.hour}:${pick_time.minute}";
          }
          xval=xval.trim();

          setState(() {
            txtc.text=xval;
          });
          save_field(xval);

        },
        child: AbsorbPointer(
            absorbing: true,  //To disable from touch use false while **true** for otherwise
            child: ui
        ),
      );




    }




    if(m.containsKey("label_name")){
      ui=Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(m["label_name"]),
          ui,
          Container( padding:vpadding,height: 1.0,color:g.getcolor("#F3F3F3"))
        ],);
    }

    if(m.containsKey("ui_padding")){
      vpadding = parseEdgeInsetsGeometry(m['ui_padding']);
      ui=Container(child: ui,padding: vpadding);
    }

    if(g.null2str(m["isclick"])=="false"){
      ui=IgnorePointer(child: ui,);
    }

    if (clickEvent != "") {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {

          if(null2str(m["get"]) == "date"){

            // var dtnow=DateTime.now();
            // var vlocate= DateTimePickerLocale.th;
            // var dt = await DatePicker.showSimpleDatePicker(
            //   context,
            //   initialDate: dtnow,
            //   firstDate: DateTime(dtnow.year - 80, dtnow.month, dtnow.day),
            //   lastDate: DateTime(dtnow.year + 100, dtnow.month, dtnow.day),
            //   dateFormat: "dd/MM/yyyy",
            //   locale:vlocate,
            //   looping: true,
            // );
            //
            // setState(() {
            //   txtc.text="${dt.day}/${dt.month}/${dt.year}";
            // });
            //save_field(xval);


          }else {
            g.plink["field"]=id;
            if(btnx!=null){
              setState(() {
              });
            }
            widget.listener.onClicked(clickEvent);
          }
        },
        child: AbsorbPointer(
            absorbing: true,  //To disable from touch use false while **true** for otherwise
            child: ui
        ),
      );
    } else {
      return ui;
    }

  }






}

class TextOneLine extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign textAlign;
  final bool autoSize;

  TextOneLine(
      String data, {
        Key key,
        this.style,
        this.textAlign,
        this.autoSize = false,
      })  : this.data = data,
        assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
      textAlign: textAlign,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}