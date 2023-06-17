import 'dart:async';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../g.dart';
import '../../main.dart';


class tab_control2 extends WidgetParser {

  final List<String> dtag;
  tab_control2(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return tab_control_ex2(buildContext,m,listener);

  }

  @override
  String get widgetName => "tabcontrol";
}


class tab_control_ex2 extends StatefulWidget  {

  final BuildContext buildContext;
  final  Map<String, dynamic> m;
  final ClickListener listener;
  StreamController<String> eventx =null;

  tab_control_ex2( this.buildContext, this.m,this.listener,{Key key}) : super(key: key);


  String id() {
    return g.null2str(m["id"]);
  }
  @override
  _tab_control_exState createState() => _tab_control_exState(m);

}

class _tab_control_exState  extends State<tab_control_ex2>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  final  Map<String, dynamic> m;
  TabController tab_control=null;
  int tab_index_last=0;

  _tab_control_exState(this.m);
  String clickEvent;


  List<Widget> tab_wg= new List<Widget>();
  String skey="";
  String tp;
  String tpx;
  String s="";
  List<String> a;


  @override
  void initState() {
    skey=m["skey"];

    super.initState();

   // _tabController = new TabController(vsync: this, length: 4);


  }




  @override
  void dispose() {

    tab_control.dispose();
    super.dispose();
  }

 void _setActiveTabIndex() {
   on_tabchange(tab_control.index);
  }

  /*void tab_change(int index){

    var vdelay=g.cint(g.null2str(m["time_delay"]),100);
    Future.delayed( Duration(milliseconds: vdelay), () {
      if(g.null2str(m["change2click"])!=""){
        g.t_click=g.null2str(m["change2click"])+"${index}";
      }
    });
  }*/

  double getHeight() {
    return 800;
  }



  on_tabchange(int index){

   // g.tmsg("table change...${index} ${a}");

    try{

// reset last tp
      s=tp;
      s=s.replaceAll("{tab_label}",a[tab_index_last]);
      s=s.replaceAll("{tab_index}","${tab_index_last}");



      tab_wg[tab_index_last]= Container(
          key: g.getnewkey(),
          child: IgnorePointer(ignoring: true,child:DynamicWidgetBuilder.build(s, context,widget.listener,skey)));


      s=tpx;
      s=s.replaceAll("{tab_label}",a[index]);
      s=s.replaceAll("{tab_index}","${index}");
      tab_wg[index]= Container(
          key: g.getnewkey(),
          child: IgnorePointer(ignoring: true,child:DynamicWidgetBuilder.build(s, context,widget.listener,skey)));



  tab_index_last=index;


    }catch(e){
     // g.tmsg("on_tabchange.error.${e}");
    }





  }

    get_tabview(){

    var ui_chilren=DynamicWidgetBuilder.buildWidgets(m['tabview'], widget.buildContext, widget.listener);
    var ui_header=DynamicWidgetBuilder.buildWidgets(m['tabview_header'], widget.buildContext, widget.listener);
    var ih=g.cdbl(m["body_height"], 300.0);
     a=g.null2str(m["tab_label"]).split(",");


    if(tab_control==null){
      tab_control = new TabController(vsync: this, length: ui_chilren.length);
    }
    tab_control.addListener(_setActiveTabIndex);


    tp = read_json(json_ui,"${m["tab_bar"]}");
    tpx = read_json(json_ui,"${m["tab_bar"]}x");
    a=g.null2str(m["tab_label"]).split(",");


    tab_wg.clear();

    if(m["header_pin"]==true){

      var tab_count=ui_chilren.length;
      for(int i=0; i<tab_count; i++){

        s=tp;
        if(i==tab_index_last){
          s=tpx.replaceAll("{v}","x");
        }else {
          s=s.replaceAll("{v}","");
        }
        s=s.replaceAll("{tab_label}",a[i]);
        s=s.replaceAll("{tab_index}","${i}");
        tab_wg.add(Container(child: IgnorePointer(ignoring: true,child:DynamicWidgetBuilder.build(s, context,widget.listener,skey))));
      }


      return

        DefaultTabController(
          length: tab_wg.length,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverPersistentHeader(
                  pinned: false,
                  delegate: h_delegate(
                    min_height: 100,
                    max_height: 100,
                    child: Container(
                      height: 100.0,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: h_delegate(
                    min_height: 50,
                    max_height: 50,
                    child: Container(
                      height: 50.0,
                      color: Colors.brown,
                    ),
                  ),
                ),


                SliverPersistentHeader(
                  pinned: true,
                  delegate: h_delegate(
                    min_height: 50,
                    max_height: 50,
                    child: Container(
                      child: TabBar(
                        onTap: (int index){
                          on_tabchange(index);
                        },
                        controller: tab_control,
                        tabs:tab_wg,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body:

            TabBarView(
              controller: tab_control,
              children: ui_chilren
            )



          ),
        );





    }else {
      return
        DefaultTabController(
            length: ui_chilren.length, // length of tabs
            initialIndex: g.cint(g.null2str(m["tab_index"]),0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
              Container(
                child: TabBar(
                  isScrollable: true,
                  controller: tab_control,
                  indicatorWeight:g.cdbl(g.null2str(m["indicator_height"]), 1.0),
                  indicatorColor:g.getcolor2(g.null2str(m["indicator_color"]), "#000000"),
                  labelColor:g.getcolor2(g.null2str(m["label_color"]), "#000000"),
                  unselectedLabelColor:g.getcolor2(g.null2str(m["select_label_color"]), "#808080"),
                  onTap: (index) {

                    Future.delayed( Duration(milliseconds: 10), () {

                      if(g.null2str(m["tab_click"])!=""){
                        g.t_click=g.null2str(m["tab_click"]);
                      }
                      if(g.null2str(m["tab_click2"])!=""){
                        g.t_click=g.null2str(m["tab_click2"])+"_${index}";
                      }
                      // g.bmsg(g.t_click);
                    });

                  },
                  tabs:ui_header,
                ),
              ),
              Expanded(
                  child: TabBarView(
                    controller: tab_control,
                    children: ui_chilren
                    ,
                  )
              )
            ])
        );

    }




  }

  @override
  Widget build(BuildContext context) {
    return get_tabview();

    }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

