import 'dart:async';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../main.dart';


class tab_control extends WidgetParser {

  final List<String> dtag;
  tab_control(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return tab_control_ex(buildContext,m,listener);


  }

  @override
  String get widgetName => "tab_control";
}


class tab_control_ex extends StatefulWidget  {

  final BuildContext buildContext;
  final  Map<String, dynamic> m;
  final ClickListener listener;
  StreamController<String> eventx =null;

  tab_control_ex( this.buildContext, this.m,this.listener,{Key key}) : super(key: key);


  String id() {
    return g.null2str(m["id"]);
  }
  @override
  _tab_control_exState createState() => _tab_control_exState(m);

}

class _tab_control_exState  extends State<tab_control_ex>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  final  Map<String, dynamic> m;

  _tab_control_exState(this.m);
  String clickEvent;

  @override
  Widget build(BuildContext context) {
    return
      tabcontrol(g.null2str(m["tab"]),context,g.null2str(m["tabinfo"]));
    }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;
}
