import 'dart:async';

import 'package:chips_choice/chips_choice.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../../g.dart' as g;

import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class selectx_ui extends WidgetParser {

  final List<String> dtag;
  selectx_ui(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {


    String clickEvent =
    m.containsKey("click_event") ? m['click_event'] : "";

    m["skey"]= dtag[0];
    return selectx_ex(buildContext,m,listener);

  }

  @override
  String get widgetName => "selectx";
}


class selectx_ex extends StatefulWidget  {

  final BuildContext ctx;
  final  Map<String, dynamic> m;
  final ClickListener listener;
  StreamController<String> eventx =null;
  String edit_value="";





  selectx_ex( this.ctx, this.m,this.listener,{Key key}) : super(key: key);


  String id() {
    return g.null2str(m["id"]);
  }
  @override
  _selectx_exState createState() => _selectx_exState(m);

}

class _selectx_exState  extends State<selectx_ex>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin
{

  final  Map<String, dynamic> m;


  List<String> a;


  String url="";
  num position = 1 ;

  String skey;
  _selectx_exState(this.m);
  String clickEvent;


  int tag = 0;
  List<String> tags = [];
  List<String> data = ['a','b'];
  var v_index=0;
  TabController _tabController=null;
  String uitag="";

  var s="";


  void readevent(){
    try{
      widget.eventx = new StreamController();
      widget.eventx.stream.listen((data) {
        a=data.split(".");
      });
    }catch(e){}
  }



  @override
  void initState() {

    uitag=g.getuitag(m);

    clickEvent = m.containsKey("click_event") ? m['click_event'] : "";

    if(m.containsKey("data")){
      data=g.null2str(m["data"]).split(",");
    }
    if(m.containsKey("eventx")){
      readevent();
    }

    // if(_tabController==null){
    _tabController = new TabController(vsync: this, length: 4);
    // }

    super.initState();


  }


  @override
  void dispose() {
    if(m.containsKey("eventx")){
      try{
        widget.eventx.close();
      }catch(e){}
    }
    if(_tabController !=null){
      _tabController.dispose();
    }

    super.dispose();
  }


  void _setActiveTabIndex() {
    tab_change(_tabController.index);
  }

  void tab_change(int index){
    var vdelay=g.cint(g.null2str(m["time_delay"]),100);
    Future.delayed( Duration(milliseconds: vdelay), () {
      if(g.null2str(m["change2click"])!=""){
        g.t_click=g.null2str(m["change2click"])+"${index}";
        if(m.containsKey("change2click_tag")){
          if(g.note_tag.containsKey(g.t_click)){
            g.t_click="";
          }
        }
        print("trigger_"+g.t_click);
      }
    });
  }

  get_tabview(){

    var ui_chilren=DynamicWidgetBuilder.buildWidgets(m['tabview'], widget.ctx, widget.listener);
    var ui_header=DynamicWidgetBuilder.buildWidgets(m['tabview_header'], widget.ctx, widget.listener);
    var ih=g.cdbl(m["body_height"], 200.0);

    if(_tabController==null){
      if(ui_chilren.length>0){
        _tabController = new TabController(vsync: this, length: ui_chilren.length);
        _tabController.addListener(_setActiveTabIndex);
      }
    }

    return

      DefaultTabController(
          length: ui_chilren.length, // length of tabs
          initialIndex: g.cint(g.null2str(m["tab_index"]),0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
            Container(
              child: TabBar(
                isScrollable: true,
                controller: _tabController,
                indicatorWeight:g.cdbl(g.null2str(m["indicator_height"]), 0.000001),
                indicatorColor:Colors.transparent,
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
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: ui_chilren
                  ,
                )
            )
          ])
      );

  }

  @override
  Widget build(BuildContext context) {


    var i_spacing=g.cdbl(g.null2str(m["spacing"]), 2.0);

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



    var wg;



    if(uitag!="select_one"){
      wg=
      ChipsChoice<String>.multiple(
        spacing: i_spacing,
        padding: EdgeInsets.all(0),
        value: tags,
        choiceStyle:cstyle ,
        choiceActiveStyle: cstyle_active,
        wrapped:true,
        onChanged: (val) => setState((){

          tags = val;
          s="";
          val.forEach((s1) {
            s+=s1+",";
          });
          s=g.rcut(s);
          widget.edit_value=s;

          if(m.containsKey("vid")){
            g.savevfield(m["vid"],widget.edit_value);
          }
          if(m.containsKey("id")){
            g.savevfield(m["id"],widget.edit_value);
          }

          if(m.containsKey("vname")){
            g.plink[m["vname"]]=widget.edit_value;
          }

          if(clickEvent!=""){
            widget.listener.onClicked(clickEvent);
          }

          if(m.containsKey("t_click")){
            g.t_click=m["t_click"];
          }
          if(m.containsKey("t_click2")){
            g.t_click=(g.null2str(m["t_click2"])+"_"+widget.edit_value).toLowerCase();

          }



        }),
        choiceItems: C2Choice.listFrom<String, String>(
          source: data,
          value: (i, v) => v,
          label: (i, v) => v,
        ),
      );

    }else {

      /* var vstyle=C2ChoiceStyle(showCheckmark: false,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

  );*/
      wg=ChipsChoice<int>.single(
        spacing: i_spacing,
        padding: EdgeInsets.all(0),
        choiceStyle:cstyle ,
        choiceActiveStyle: cstyle_active,
        value: tag,
        wrapped:true,
        onChanged: (vindex) => setState((){

 try {

           setState(() {
             v_index = vindex;
             tag = vindex;
           });

           tag = vindex;
           widget.edit_value = data[vindex];

           try {
                 if (_tabController != null) {
                   _tabController.index = vindex;
                 }
               } catch (e) {}


               g.pvar[g.null2str(m["id"]) + "_index"] = vindex.toString();
               if (m.containsKey("vfield")) {
                 g.pvar[m["vfield"]] = widget.edit_value;
               }
               if (m.containsKey("vname")) {
                 g.plink[m["vname"]] = widget.edit_value;
               }

               g.saveiform(g.null2str(m["id"]) , widget.edit_value);


               if (m.containsKey("t_click")) {
                 g.t_click = m["t_click"];
               }
               if (m.containsKey("change2click")) {
                 g.t_click =
                     (g.null2str(m["change2click"]) + "_" + widget.edit_value).toLowerCase();
               }
               if(m.containsKey("change2click_index")){
                 g.t_click =g.null2str(m["change2click_index"]) + "_"+vindex.toString();
               }

              // g.tmsg(g.t_click);
               if (m.containsKey("run_cmd")) {
                 g.run_cmd =g.null2str(m["run_cmd"]);
               }

       }catch(e){}
        }),
        choiceItems: C2Choice.listFrom<int, String>(
          source: data,
          value: (i, v) => i,
          label: (i, v) => v,
        ),
      );

    }


    if(m.containsKey("tab_ui")){

      var tabview;
      var tab_ui=DynamicWidgetBuilder.buildWidgets(m['tab_ui'], widget.ctx, widget.listener);
      var xbox= IndexedStack(
          index: v_index,
          children: tab_ui);

      if(m.containsKey("tabview")){

        tabview=get_tabview();
      }else {
        tabview=Container();
      }

      return Column(mainAxisAlignment:
      MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [wg,xbox,Expanded(child: tabview)]);

    }else {
      return wg;
    }






  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
class CustomChip extends StatelessWidget {

  final String label;
  final Color color;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final bool selected;
  final Function(bool selected) onSelect;

  CustomChip({
    Key key,
    this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: this.width,
      height: this.height,
      margin: margin ?? const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 3,
      ),
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: selected ? (color ?? Colors.green) : Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        border: Border.all(
          color: selected ? (color ?? Colors.green) : Colors.grey,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Visibility(
                visible: selected,
                child: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 32,
                )
            ),
            Positioned(
              left: 5,
              right: 5,
              bottom: 5,
              child: Container(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}