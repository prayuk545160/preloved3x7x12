import 'dart:async';
import '../../dynamic_widget.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;



class tabx_ui extends WidgetParser {

  final List<String> dtag;
  tabx_ui(this.dtag);


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
    return tabx_ex(buildContext,m,listener);

  }

  @override
  String get widgetName => "tabx";
}

class tabx_ex extends StatefulWidget {

  final BuildContext ctx;
  final ClickListener listener;
  final  Map<String, dynamic> m;
  String cmdtag="";
  StreamController<String> eventx = null;


  tabx_ex( this.ctx, this.m,this.listener);

  String id() {
    return g.null2str(m["id"]);
  }
  String get_uitag() {
    return g.null2str(m["ui"]);
  }
  String val(){
    return "";
  }
  String setval(String val){
    cmdtag="";

  }
  String setcmd(String val){
    cmdtag="cmd";

  }

  String add_event(String val){
    cmdtag="";
    try {
      if(eventx!=null){
        eventx.add(val);
      }
    }catch(e){}
  }


  @override
  _tabx_exState createState() => _tabx_exState(m);

}

class _tabx_exState  extends State<tabx_ex> {



  final  Map<String, dynamic> m;

  _tabx_exState(this.m);



  List<Widget> tab_wg = new List<Widget>();
  List<String> d_list;
  List<String> d_listimg;
  String split_chat=" ";
  int i_index_stack=0;
  var tabview_ui=null;
  String skey;


  @override
  void initState() {


    skey =g.null2str(m["skey"]);
    if(m.containsKey("split_char")){
      split_chat=g.null2str(m["split_char"]);
    }
    if(m.containsKey("tabview")){
      tabview_ui=DynamicWidgetBuilder.buildWidgets(m['tabview'], widget.ctx, widget.listener);
    }else {
      tabview_ui=[Container()];
    }
    super.initState();


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

    d_list = g.null2str(m["data_select"]).split(split_chat);
    d_listimg = g.null2str(m["data_img"]).split(",");


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
                  });
                  widget.listener.onClicked(g.null2str(m["cmd${i}"]));
                },
                child: IgnorePointer(child:DynamicWidgetBuilder.build(tp, context, new tclick(skey),skey)),
              )));
    }
  }


  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    crete_tabx();
    return
      Column(children: [Row(children: tab_wg),
        IndexedStack(
            index: i_index_stack,
            children:tabview_ui)
      ]);


  }
}
