import 'dart:developer';

import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../g.dart' as g;

import '../../g.dart';


class segmentedParser extends WidgetParser {
  segmentedParser(List<String> dtag);


  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {

    return new segmented_ex(buildContext,map,listener);

  }

  @override
  String get widgetName => "SegmentedControl";
}
class segmented_ex extends StatefulWidget {

  final BuildContext _buildContext;
  final Map<String, dynamic> m;
  final ClickListener listener;

  segmented_ex( this._buildContext, this.m,this.listener);
  @override
  _segmented_exState createState() => _segmented_exState(m);


}

class _segmented_exState  extends State<segmented_ex>  with TickerProviderStateMixin  {
  final Map<String, dynamic> m;
  _segmented_exState(this.m);


  TabController _tabController;
  List<Widget> wd;

  @override
  void initState() {


    wd=DynamicWidgetBuilder.buildWidgets(
        m['children'], widget._buildContext, widget.listener);
    _tabController = TabController(vsync: this, length: wd.length);
    _tabController.addListener(_handleTabSelection);
    super.initState();

  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      print('Page '+_tabController.index.toString());
      if(g.null2str(m["fclick_change"])!=""){
        g.b_click=m["fclick_change"];
      }
    }
    if(g.null2str(m["fclick"])!=""){
      g.b_click=m["fclick"];
    }

  }

  @override
  Widget build(BuildContext context) {

    String clickEvent =
    m.containsKey("click_event") ? m['click_event'] : "";

    int segmentedControlValue = 0;


    var ui =
     Container(
      child:
      DefaultTabController(
        length: 4,
        child: SizedBox(
          height: 34,
          child: Column(
            children: <Widget>[
              TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: parseHexColor("#5A8CAF"),
                unselectedLabelColor:  parseHexColor("#898989"),
                tabs:wd
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Container(),
                    Container(),
                    Container(),
                    Container(
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),


    );



    return ui;
  }
}