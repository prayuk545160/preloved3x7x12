import 'dart:async';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../main.dart';


class loadpage_ui extends WidgetParser {

  final List<String> dtag;
  loadpage_ui(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return loadpage_ui_ex(buildContext,m);
  }
  @override
  String get widgetName => "page";
}


class loadpage_ui_ex extends StatefulWidget  {

  final BuildContext buildContext;
  final  Map<String, dynamic> m;
  loadpage_ui_ex( this.buildContext, this.m,{Key key}) : super(key: key);

  String id() {
    return g.null2str(m["id"]);
  }
  @override
  _loadpage_ui_exState createState() => _loadpage_ui_exState(m);
}

class _loadpage_ui_exState  extends State<loadpage_ui_ex>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  final  Map<String, dynamic> m;
  _loadpage_ui_exState(this.m);

  @override
  Widget build(BuildContext context) {
    return    loadpage(g.null2str(m["page"]),false,"",g.genkey(),true,null,0,0);
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;
}
