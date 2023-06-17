import 'dart:async';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class tabbox extends WidgetParser {

  final List<String> dtag;
  tabbox(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    m["skey"]= dtag[0];

    return tabbox_ex(buildContext,m,listener);


  }

  @override
  String get widgetName => "tabbox";
}


class tabbox_ex extends StatefulWidget  {

  final BuildContext buildContext;
  final  Map<String, dynamic> m;
  final ClickListener listener;
  StreamController<String> eventx =null;

  tabbox_ex( this.buildContext, this.m,this.listener,{Key key}) : super(key: key);


  String id() {
    return g.null2str(m["id"]);
  }
  @override
  _tabbox_exState createState() => _tabbox_exState(m);

}

class _tabbox_exState  extends State<tabbox_ex> with SingleTickerProviderStateMixin  {
  GlobalKey<ContainedTabBarViewState> _key = GlobalKey();

  final  Map<String, dynamic> m;
  final key = UniqueKey();

  List<String> a;


  String url="";
  num position = 1 ;

  String skey;
  _tabbox_exState(this.m);

  String clickEvent;



  void readevent(){
    try{
      widget.eventx = new StreamController();
      widget.eventx.stream.listen((data) {

        a=data.split(".");
        switch(a[1]){
          case "next":
            _key.currentState?.next();
            break;
          case "back":
            _key.currentState?.previous();
            break;
          case "goto":
            _key.currentState?.animateTo(g.cint(a[2],0));
            break;
        }
      });
    }catch(e){}
  }



  @override
  void initState() {
     clickEvent = m.containsKey("click_event") ? m['click_event'] : "";
    super.initState();
     if(m.containsKey("eventx")){
       readevent();
     }
  }


  @override
  void dispose() {
    if(m.containsKey("eventx")){
      try{
        widget.eventx.close();
      }catch(e){}
    }
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

   /* var tab= DynamicWidgetBuilder.buildWidgets(m['view'], widget.buildContext, widget.listener);
    return  Swiper(
        itemBuilder: (BuildContext context, int index) {
      return tab[index];
    },
    loop: false,
    itemCount: tab.length,
    itemWidth: 300.0,
    itemHeight: 400.0,
    layout: SwiperLayout.TINDER,
    );*/







    ContainedTabBarView containedTabBarView =ContainedTabBarView(
        key: _key,
          tabBarViewProperties: TabBarViewProperties(
            physics: m.containsKey("noscroll") ? NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
          ),
        tabBarProperties: TabBarProperties(
          height:0.0,
          indicatorColor: Colors.brown,
          indicatorWeight:0.001,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          position: TabBarPosition.bottom,
        ),
        tabs:DynamicWidgetBuilder.buildWidgets(
            m['tab'], widget.buildContext, widget.listener),
        views: DynamicWidgetBuilder.buildWidgets(
            m['view'], widget.buildContext, widget.listener),
        onChange: (index) {
          String st=clickEvent;
          st=st.replaceAll("{vtab_index}", index.toString());
          widget.listener.onClicked(st);
        });



    return Container(
      padding: const EdgeInsets.all(0.0),
      color: Colors.white,
      child: containedTabBarView,
    );



    }
}
