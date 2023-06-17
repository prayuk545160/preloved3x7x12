
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:need_resume/need_resume.dart';
import 'package:preloved/dynamic_widget/basic/GridPageView.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../dynamic_widget.dart';
import '../../dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;



class Event_change {
  String msg;
  Event_change(this.msg);
}
class GridViewWidgetParser extends WidgetParser {

  List<String> dtag;

  GridViewWidgetParser(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    var scrollDirection = Axis.vertical;
    if (m.containsKey("scrollDirection") &&
        "horizontal" == m["scrollDirection"]) {
      scrollDirection = Axis.horizontal;
    }
    int crossAxisCount = m['crossAxisCount'];
    bool reverse = m.containsKey("reverse") ? m['reverse'] : false;
    bool shrinkWrap = m.containsKey("shrinkWrap") ? m["shrinkWrap"] : false;
    double cacheExtent =
    m.containsKey("cacheExtent") ? m["cacheExtent"] : 0.0;
    EdgeInsetsGeometry padding = m.containsKey('padding')
        ? parseEdgeInsetsGeometry(m['padding'])
        : EdgeInsets.all(0.0);
    double mainAxisSpacing =
    m.containsKey('mainAxisSpacing') ? m['mainAxisSpacing'] : 0.0;
    double crossAxisSpacing =
    m.containsKey('crossAxisSpacing') ? m['crossAxisSpacing'] : 0.0;
    double childAspectRatio =
    m.containsKey('childAspectRatio') ? m['childAspectRatio'] : 1.0;


    var pageSize = m.containsKey("pageSize") ? m["pageSize"] : 10;


    if(m["skey"]==null){
      m["skey"]=dtag[0];
    }

    if(childAspectRatio==1.0){
      childAspectRatio=1.01;
    }

    var ui_children= DynamicWidgetBuilder.buildWidgets(
        m['children'], buildContext, listener);



    GridViewParams params = GridViewParams(
        crossAxisCount,
        scrollDirection,
        reverse,
        shrinkWrap,
        cacheExtent,
        padding,
        mainAxisSpacing,
        crossAxisSpacing,
        childAspectRatio,
        ui_children,
        pageSize);
    return gridview_ex(params, buildContext,m,listener,g.null2str(m["skey"]));


  }

  @override
  String get widgetName => "GridView";
}

class gridview_ex extends StatefulWidget {


  // method() => createState().methodInPage2();

  StreamController<String> eventx = new StreamController();


  final GridViewParams _params;
  final BuildContext ctx;
  final ClickListener listener;
  final Map<String, dynamic> m;
  List dt=[];
  List dtx=[];
  List dt_temp=[];

  int row_count=0;
  int job_id=0;
  int job_id_req=0;
  String scmd="";
  String s_filter="";
  String select_val="";
  String skey="";
  String event_cmd="";
  String levent_cmd="";

  StreamSubscription event_sub=null;
  gridview_ex(this._params, this.ctx, this.m, this.listener,this.skey);


  String id() {
    return g.null2str(m["id"]);
  }

  void cleardata(){
    eventx.add("cleardb");
  }
  List getlist(){
    return dt;
  }
  void add_event(String s){
    try {

      print("add_event" + id() + ":" + s);
      //g.tmsg("add_event" + id() + ":" + s);
      event_cmd=s;
      eventx.add(s);
      //eventBus.fire(Event_change(s));

    }catch(e){
      g.alert("grid_"+id()+"add_event_error"+e);
    }

  }

  @override
  gridview_state createState() {

    if(g.null2str(m["uikey"])=="auto"){
      m["uikey"]=g.getnewkey();
    }
    return gridview_state(_params,m);
  }

}


class gridview_state extends ResumableState<gridview_ex>  with AutomaticKeepAliveClientMixin {

  final GlobalKey<RefreshIndicatorState> refreshKey = new GlobalKey<RefreshIndicatorState>();

  String xval="";
  GridViewParams _params;

  List<Widget> _items = [];
  List<Widget> allwg=[];


  List<String> tcmd = [];
  String rowx  = "";
  String st="";
  Map<String, dynamic> hx = new Map<String, dynamic>();



  List<String>   l=[];


  var xscroll;


  bool is_set_header=false;



  bool isPerformingRequest = false;
  bool loadCompleted = false;
  bool is_active = true;
  bool req_scroll2end=false;
  bool is_first_time=true;

  String grid_id="";
  String b_click="";
  Map<String, dynamic> gridcmd = new Map<String, dynamic>();
  bool isprocess=false;
  Completer<void> _refreshCompleter;
  PageController pageview_control;
  int pageview_rowidex = 0;



  bool init_hide=false;
  String s_filter="";
  String s="";
  List<String> a=[];
  List<String> b=[];
  bool is_streem=false;
  bool ispage=false;
  bool is_run_first=false;

  final Map<String, dynamic> m;
  bool is_run=false;
  var djs;
  List<dynamic> dt_temp=[];
  List<Widget> wrowh;
  String cfg_hrow="";
  String strx="";

  var h_ui ;
  var b_ui ;
  var wait_ui=null;

  var ui=null;
  bool iscleardb=false;
  Key this_key;

  bool is_startrow=false;
  String gval="";

  String vstart_scroll2="";
  int index_stack=0;
  String scroll_tag="";
  String codetag="";
  var sliverGrid;
  Key uikey;
  int start_rowindex=0;
  String this_row="";






  @override
  void initState() {






    setState(() {
      this_key=g.getnewkey();
      uikey=g.getnewkey();
    });
    codetag=g.null2str(m["codetag"]);

    if(m.containsKey("edit_value")){
      g.saveiform(grid_id,m["edit_value"]);
    }


    if(m.containsKey("auto_tag")){
      xscroll = AutoScrollController(
          viewportBoundaryGetter: () =>
              Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
          axis:Axis.vertical);
    }else {
      xscroll = new ScrollController(                                       // NEW
          keepScrollOffset: true);
    }



    try{
      readevent();
    }catch(e){}

    is_streem=(g.null2str(m["data_mode"])=="stream");
    ispage=(g.null2str(m["ispage"])=="true");
    if(g.null2str(m["pageview"])=="true"){
      ispage=true;
    }


    cfg_hrow=g.page_replace(g.null2str(m["rowh"]),widget.skey,"cfg_hrow");

    if(m.containsKey("rowh_tp")){
      cfg_hrow= g.hashmap2json(m["rowh_tp"]);
    }

   // cfg_hrow=g.getfval2("",cfg_hrow);

    if(g.c.containsKey("pageview_rowindex")){
      m["start_rowindex"]=g.cintx(g.c["pageview_rowindex"]);
    }
     start_rowindex=g.cint(g.null2str(m["start_rowindex"]),0);
    double view_port=g.cdbl(g.null2str(m["view_port"]),1.0);

    try {
      pageview_control = PageController(
        viewportFraction:view_port ,
        keepPage: true,
        initialPage: start_rowindex,
      );

      _refreshCompleter = Completer<void>();
      print("call wg_gridview " + m.toString());

      if (g.null2str(m["init_hide"]) == "true") {
        init_hide = true;
      }
      s_filter = g.null2str(m["init_rowfilter"]);




      if (grid_id == null) {
        grid_id = g.createid();
      }
      //grid_id = grid_id.toString().replaceAll("{p}", m["skey"]);
      grid_id = g.null2str(m["id"]);
      b_click = g.null2str(m["b_click"]);


      if(m.containsKey("row_tp")){
        rowx = json.encode(m["row_tp"]);
      }else {
        rowx = g.read_json(g.json_ui, m["row"]);
      }


      rowx = readrowx(rowx);

      if (m.containsKey("rowcfg")) {
        String vrow = "";
        List a = m["rowcfg"].toString().split(",");
        a.forEach((s1) {
          vrow = g.read_json(g.json_ui, s1);
          vrow = readrowx(vrow);
          l.add(vrow);
        });
      }
      xscroll.addListener(() {

        try {
          if (m.containsKey("check_scroll_dir")) {
            if (xscroll.position.userScrollDirection ==
                ScrollDirection.reverse) {
              scroll_tag="r";

            }
            if (xscroll.position.userScrollDirection ==
                ScrollDirection.forward) {
              scroll_tag="f";


            }
            if( g.scroll_tag!=scroll_tag){
              //g.tmsg("scroll ${scroll_tag}");
            }
            g.scroll_tag=scroll_tag;

            print("on scroll.> ${g.scroll_tag}");
          }

          /*  if (xscroll.position.userScrollDirection ==
                ScrollDirection.reverse) {
              setState(() {
                g.scroll_show=true;
              });
              g.scroll_show=true;
            }
            if (xscroll.position.userScrollDirection ==
                ScrollDirection.forward) {
              setState(() {
                g.scroll_show=false;
              });
              g.scroll_show=false;

            }

          print("show_scroll.> ${g.scroll_show}");
*/










          if (xscroll.position.pixels ==
              xscroll.position.maxScrollExtent && widget.dt.length >0 ) {



            //g.bmsg("get_more_data");
            // g.tmsg("get_more_data");


            if (b_click != "") {
              g.b_click = b_click;
            }
            if (g.null2str(m["bottom_tclick"]) != "") {
              g.b_click = g.null2str(m["bottom_tclick"]);
            }

            if (g.null2str(m["bottom_cmd"]) != "") {
              g.page_cmd = g.null2str(m["bottom_cmd"]);
            }
            if (g.null2str(m["loadmore_cmd"]) != "") {
              g.page_cmd = g.null2str(m["loadmore_cmd"]);
              print("loadmore_cmd=${g.run_cmd}");
            }
          }
        }catch(e){}


      });
      create_database("");

      if(cfg_hrow!=""){
        build_header();
      }else {
        h_ui = SliverToBoxAdapter(child: Container(),);
      }

      if(m.containsKey("bottom_ui")){
        // g.tmsg("found_bottom_ui");
        b_ui=SliverToBoxAdapter(child:DynamicWidgetBuilder.build(json.encode(m["bottom_ui"]),  widget.ctx, widget.listener,widget.skey));

      }else {
        b_ui = SliverToBoxAdapter(child: Container());
      }





      loopx();
    }catch(e){}
    super.initState();
  }



  clear_datagrid(){
      try {
        setState(() {
          g.clear_gdb(grid_id);
        });
      }catch(e){}
      try {
        setState(() {
          widget.dt.clear();
        });
      }catch(e){}
      try {
        setState(() {
          uikey=g.getnewkey();
          this_key=g.getnewkey();
        });
      }catch(e){}



  }



  @override
  void onReady() {
    readevent();

    // g.tmsg(grid_id+'HomeScreen is ready!');
  }
  @override
  void onResume() {
    //g.tmsg(grid_id+'HomeScreen is resumed!');
    readevent();
  }

  @override
  void onPause() {
    //  g.tmsg(grid_id+'HomeScreen is paused!');
  }





  @override
  void dispose() {

    print("datagrid_dispose");
    try{
      widget.eventx.close(); //Streams must be closed when not needed
    }catch(e){}

    try{
      if(mounted){
        is_active=false;
        widget.dt.clear();

        if(g.db.containsKey(grid_id)){
          g.db.remove(grid_id);
        }
        if(g.jdb.containsKey(grid_id)){
          g.jdb.remove(grid_id);
        }

        if(pageview_control!=null){
          pageview_control.dispose();
        }
      }
    }catch(e){}

    try {

      xscroll.dispose();
      xscroll.removeListener(() {});

    }catch(e){}
    try {

      if(widget.event_sub!=null){
        widget.event_sub.cancel();
      }
    }catch(e){}

    try{
      //eventBus.destroy();
    }catch(e){}
    super.dispose();



  }





  gridview_state(this._params, this.m) {
    if (_params.children != null) {
      // _items.addAll(_params.children);
    }
  }


  String readrowx(String rowx){

    try{
      if(g.null2str(m["send2row"])!=""){
        // key1.val1,key2.val2,key3.val3
        List<String> a=g.null2str(m["send2row"]).split(",");
        List<String> b;
        a.forEach((s1) {
          b=s1.split(".");
          rowx  = rowx.replaceAll("{"+b[0]+"}", b[1]);
        });
      }}catch(e){}

    Map<String, dynamic> h = new Map<String, dynamic>();
    h=g.cfg as   Map<String, dynamic>;

    h.forEach((k, v) {
      rowx=rowx.replaceAll("{cfg."+k+"}", v);
    });


    rowx  = rowx.replaceAll("{x.login_id}", g.login_id);
    rowx  = rowx.replaceAll(".?","."+grid_id+".{r}");
    rowx  = rowx.replaceAll("{?k}",g.active_key);
    rowx  = rowx.replaceAll("{k}",g.active_key);
    rowx  = rowx.replaceAll("{?p}",g.active_key);
    rowx  = rowx.replaceAll("{?g}",grid_id);
    rowx  = rowx.replaceAll("{?dr}","{?grid_id}.{r}");
    rowx  = rowx.replaceAll("{?grid_id}",grid_id);
    return rowx;

  }



  void readevent(){

    try{
      if(widget.event_sub!=null){
        widget.event_sub.cancel();
      }

    }catch(e){}

    try{




      widget.eventx = new StreamController();
      widget.eventx.stream.listen((data) {
        print("gridview_grid_event_v1:${grid_id}"+data);
        event2cmd(data);
      });



      // widget.event_sub = eventBus.on<Event_change>().listen((event) {
      //   print("gridview_grid_event_v2:${grid_id}"+event.msg);
      //   event2cmd(event.msg);
      // });


    }catch(e){}
  }


  event2cmd(String s) async {

    int idelay=0;
    if(g.cmdval("fill")=="reset"){

      await build_header();
      idelay=150;
      if(g.cmd.containsKey("reset_time")){
        idelay=g.cint(g.cmdval("reset_time"),idelay);
      }
      try {
        iscleardb = true;
        clear_datagrid();
      } catch (e) {}
    }

    Future.delayed( Duration(milliseconds: idelay), () {
      event2cmdcal(s);
    });
  }




  event2cmdcal(String s) async {

    String   sevent=s;
    widget.event_cmd="";
    print("event2cmd: ${g.ggrid_id} : ${grid_id} : ${sevent} ");

   // g.bmsg("event2cmd: ${g.ggrid_id} : ${grid_id} : ${sevent} ");
    // g.alert("${g.getrunseq()} event2cmd: ${g.ggrid_id} : ${grid_id} : ${sevent} ");

    var is_allow=true;
    if(sevent=="into_datagrid"){
      //is_allow=g.into_grid.containsKey(grid_id);
    }




    if(is_allow) {

      //g.into_grid.remove(grid_id);

      print("grid_event2cmd:${sevent}");
      List<String> a, b;
      int iloop = 0;
      List<String> ev = sevent.split("[");



     // g.tmsg("event2cmd: ${g.ggrid_id} : ${grid_id} : ${ev} ");


      //gridxi,[xxx[xx
      print("gevent:${ev}");
      switch (ev[0]) {

        case "save_rowindex":
          g.plink[ev[1]]=pageview_rowidex;
          g.alert("${pageview_rowidex}");
          break;
        case "gotopage":

          pageview_control.jumpToPage(g.cintx(ev[1]));
          //pageview_control.animateToPage(g.cintx(ev[1]), duration: Duration(milliseconds: 5), curve: Curves.linear);
          break;
        case "setdb":
          xval = ev[2];
          if (g.db.containsKey(xval)) {
            append_data(g.db[xval],false);
            /*  widget.dt.addAll(g.db[sval]);
            g.db[grid_id] = widget.dt;
            update_datasource();*/
          } else {
            g.tmsg("not_found_database:${ev[2]} from ${g.db.keys}");
          }
          break;
        case "hide":
        // if (mounted) {

          try {
            setState(() {
              // _items.clear();
              // allwg.clear();
            });
          } catch (e) {}
          // }
          break;

        case "cleardb":
          try {
            iscleardb = true;
            setState(() {
              g.clear_gdb(grid_id);
              widget.dt.clear();
            });
          } catch (e) {}
          break;
        case "set2datagrid":
          try {
            List<String> a = g.cmdval("set2datagrid").split(",");
            djs = jsonDecode(jsrow_temp(g.db[a[0]]));
            print("djs=${djs}");
            // allwg = DynamicWidgetBuilder.buildWidgets(
            //   djs, widget._buildContext, widget._listener);
            // _items.addAll(allwg);

          } catch (e) {}

          break;
        case "into_datagrid":


          String sfill=g.cmdval("fill");
          await into_datagrid(sfill);
          if(m.containsKey("start_rowindex")){
            Future.delayed(Duration(milliseconds: 0), () {
              pageview_control.animateToPage(g.cint(m["start_rowindex"],0), duration: Duration(milliseconds: 5), curve: Curves.linear);
            });
          }

          if (g.null2str(m["scroll2"]) == "b") {
            Future.delayed(const Duration(milliseconds: 20), () {
              xscroll.animateTo(
                  xscroll.position.maxScrollExtent,
                  duration: Duration(milliseconds: 20), curve: Curves.linear);
            });
          }
          if(sfill=="reset" || g.null2str(m["scroll2"]) == "t"){
            xscroll.animateTo(
                0.0,
                duration: Duration(milliseconds: 20), curve: Curves.linear);
          }
          break;


        case "mqtt_addrow":
          Future.delayed(Duration(milliseconds: 10), () {
            //if (mounted) {
            // setState(() {
            try {
              //append_data([getjsonrow(g.mqtt_msg)]);


              setState(() {
                widget.dt.add(getjsonrow(g.mqtt_msg));
              });
              req_scroll2end=true;


            /*  Future.delayed(const Duration(milliseconds: 100), () {
                // xscroll.jumpTo(xscroll.position.maxScrollExtent);

                xscroll.animateTo(xscroll.position.maxScrollExtent,
                    duration: Duration(milliseconds: 100), curve: Curves.linear);
                //  });


              });*/





            } catch (e) {}
            //});
          });


          break;
        case "xxx":
          update_datasource();
          break;
        case "clear":
          setState(() {
            // _items.clear();
            // allwg.clear();
            widget.dt.clear();
          });

          break;
        case "datagrid_reload":
        // update_datasource();
        // widget.select_val="";
          break;

        case "datagrid_setdb":
          try {

            s = g.null2str(m["qdatabase"]);
            if (m.containsKey("datagrid_setdb_reset")) {
              //Future.delayed(const Duration(milliseconds: 1), () {
              setState(() {
                //_items.clear();
                //allwg.clear();

              });

            }

            xval = g.decode_url(g.readselect(s, ""));
            g.saveiform(grid_id, xval);
            if (xval != "") {
              widget.dtx.clear();
              widget.dtx = genrowdb(xval);
              append_data(widget.dtx,false);
            }
          } catch (e) {
            g.bmsg("datagrid_setdb.error.${e}");
          }

          break;
        case "datagrid_delrow":
          try {
            a = g.cmdval("datagrid_delrow").split(",");
            int rowindex = g.cint(a[1], 0);


            if (widget.dt.length > 0) {
              widget.dt.removeAt(rowindex);
              if (g.db.containsKey(grid_id)) {
                g.db[grid_id].remove(rowindex);
              }

              xval = "";
              widget.dt.forEach((h) {
                xval += h["data"].toString() + ",";
              });
              xval = g.rcut(xval);
              g.saveiform(grid_id, xval);
            }


            Future.delayed(Duration(milliseconds: 0), () {
              update_datasource();
            });


            /* if (g.cmdval("_selectphoto") != "") {
              try {
                g.select_file = "";
                widget.dt.forEach((h) {
                  g.select_file += h["data"].toString() + ",";
                });
                g.select_file = g.rcut(g.select_file);
                g.plink["select_file"] = g.select_file;
              } catch (e) {}
            }*/


          } catch (e) {
            print("gridview_removerow.error." + e.toString());
          }

          widget.dtx.clear();
          widget.dt.forEach((h) {
            widget.dtx.add(h);
          });
          widget.dt.clear();


          Future.delayed(const Duration(milliseconds: 1), () {
            setState(() {
              // _items.clear();
              // allwg.clear();
            });
          });
          Future.delayed(Duration(milliseconds: 100), () {
            append_data(widget.dtx,false);
          });

          break;


        case "datagrid_addrow":
          break;

        case "datagrid_del_lastrow":
          try {
            if (widget.dt.length > 0) {
              widget.dt.removeAt(widget.dt.length - 1);
              print("call remove");
            }
            update_datasource();
          } catch (e) {}
          break;
        case "f_updaterow":
          a = g.cmdval("f_updaterow").split(",");
          int rowindex = g.cint(a[1], 0);
          iloop = 0;
          Map<String, dynamic> h = new Map<String, dynamic>();

          h = widget.dt[rowindex];
          h["r"] = rowindex.toString();
          a.forEach((scol) {
            if (iloop >= 1) {
              b = scol.split("[");
              if (b.length >= 2) {
                h[b[0]] = b[1];
              }
            }
            iloop += 1;
          });
          update_row(h, rowindex);
          break;

        case "datagrid_updaterow":
          datagrid_updaterow();
          g.reqid+=1;
          break;
        case "setrow":
          setrow();
          break;


        case "set_checkbox":
          a = g.cmdval("set_checkbox").split(",");

          var rowindex = int.parse(a[1]);
          Map<String, dynamic> h = new Map<String, dynamic>();
          print("datagrid_setrcheck" + widget.dt.length.toString());
          int trow = widget.dt.length;

          String toggle_val=g.null2str(widget.dt[rowindex]["rcheck"]);
          if(toggle_val=="1"){
            toggle_val="0";
          }else {
            toggle_val="1";
          }

          // reset all
          if(a[2]=="1"){
            for (int i = 0; i < trow; i++) {
              h = widget.dt[i];
              h["rcheck"] = "0";
              h["r"] = i.toString();
              widget.dt[i] = h;
            }
          }


          if (widget.dt.length > rowindex) {
            h = widget.dt[rowindex];
            if(a[2]=="1"){
              h["rcheck"] = "1";
            }else {
              h["rcheck"] = toggle_val;
            }

            h["r"] = rowindex.toString();
            widget.dt[rowindex] = h;
          }

          g.db[grid_id] = widget.dt;
          update_datasource();

          break;



        case "datagrid_filter":
          datagrid_filter();
          break;


        default:
          break;
      }
    }

    widget.event_cmd="";

  }


  read_data_checkbox(int job_id,String k){
    try {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Map<String, dynamic> h = new Map<String, dynamic>();
        String sr = "";
        if (job_id == widget.job_id) {
          for (int i = 0; i < widget.dt.length; i++) {
            h = widget.dt[i];
            s += g.null2str(h[k]) + ",";
          }
          widget.select_val = g.rcut(s);
          g.saveiform(g.getvid(grid_id), widget.select_val);
        }
      });
    }catch(e){}

  }
  List get_list(){
    return widget.dt;
  }
  int get_totalrow(){
    return widget.dt.length;
  }
  List genrow_v2(int irow){
    int ix;
    List dx=[];
    for(int i=0; i<irow;i++){
      dx.add(getjsonrow('{"name":"name$ix","lname":"lname$ix","i":"$ix"}'));
    }
    return dx;
  }

  genrow_fromstring(s){
    setState(() {
      widget.dt.clear();
    });
    try{
      widget.dt.add(getjsonrow(g.hashmap2json(s)));
    }catch(e){
    }

  }

  genrow(int irow){
    setState(() {
      widget.dt.clear();
    });
    try{

      int ix;
      List<String> field=g.null2str(m["genrow_field"]).split(",");
      for(int i=0; i<irow;i++){
        ix=widget.dt.length;
        widget.dt.add(getjsonrow('{"r":"${i.toString()}","irow":"${(i+1).toString()}","rguid":"${g.getuuid()}","name":"name$ix","lname":"lname$ix","i":"$ix"}'));
      }
    }catch(e){}


  }
  genrowdb(String sdb){
    sdb=g.decode_url(sdb);
    List dt=[];
    List<String> b;
    int i=0;
    if(!sdb.contains("=")){
      List<String> a=sdb.split(",");
      a.forEach((sx) {
        dt.add(getjsonrow('{"data":"$sx","r":"$i","rcheck":"0"}'));
        i+=1;
      });
    }else {
      int i=0;
      //yes[1,no[2;
      String a1,a2;
      List<String> a=sdb.split(",");
      a.forEach((sx) {
        b=sx.split("=");
        a1=b[0];
        a2=b[1];
        dt.add(getjsonrow('{"skey":"$a1","r":"$i","sval":"$a2","rcheck":"0"}'));
        i+=1;
      });
    }
    return dt;

  }

  genrow_v1(int irow){
    widget.dt.clear();
    // _items.clear();
    int ix;
    ix=widget.dt.length;
    for(int i=0; i<irow;i++){
      widget.dt.add(getjsonrow('{"name":"name$ix","lname":"lname$ix","r":"$i"}'));
    }
  }

  getjsonrow(String s){
    return jsonDecode(s) as  Map<String, dynamic>;
  }



  build_header(){
    try {

      cfg_hrow=cfg_hrow.toLowerCase();
      setState(() {
        if(m.containsKey("rowh_tp")){
          strx="[" +g.page_replace(json.encode(m["rowh_tp"]),widget.skey,"cfg_hrow") + "]";
        }else {
          strx="[" +g.page_replace(g.read_json(g.json_ui, cfg_hrow),widget.skey,"cfg_hrow") + "]";
        }
        if(m.containsKey("rowh_file")){
          strx=g.read_json(g.json_ui,m["rowh_file"]);
          strx="[" +g.page_replace(strx,widget.skey,"cfg_hrow") + "]";
        }

        strx=g.page_replace(strx,"", "");
        if(m.containsKey("replace_var")){
          String a = g.getparameter_fromstring(m["replace_var"]);
          if (a != "") {
            g.selectx(a, widget.skey);
            g.q.forEach((key, value) {
              strx=strx.replaceAll("{v.${key}}", value);
            });

          }


        }
        wrowh =  DynamicWidgetBuilder.buildWidgets(
            jsonDecode(strx),
            widget.ctx, widget.listener);
        if(wrowh.length==0){
          wrowh=[Container()];
        }
        h_ui = SliverToBoxAdapter(
          key: g.getnewkey(),
          child: wrowh[0],
        );

      });

    }catch(e){
    }

  }



  into_datagrid(String sfill) async {

    if(m["ui"]=="autogrid"){

       if(sfill=="reset"){
         await clear_datagrid();
       }
       append_data(g.jdb[grid_id], true);
      setState(() {
        allwg = DynamicWidgetBuilder.buildWidgets(
            jsonDecode(jsrow(widget.dt)), widget.ctx, widget.listener);

      });

    }else {




      a = g.null2str(g.cmd["grid_header_row"]).split(",");
      if (a.length >= 2) {
        if (a[0] == grid_id) {
          if (a[1] != "" &&
              (g.null2str(m["support_header_dynamic"]) == "true")) {
            setState(() {
              cfg_hrow =
                  a[1].toString().trim().toLowerCase().replaceAll(" ", "");
            });
            if (cfg_hrow != "") {
              Future.delayed(Duration(milliseconds: 50), () {
                build_header();
              });
            } else {
              h_ui = SliverToBoxAdapter(child: Container(child: Text(""),),);
            }
          }
        }
      }

      if (m.containsKey("init0_cleardb") || sfill == "reset") {
        clear_datagrid();
      }

      if (m.containsKey("init_resetdata")) {
        clear_datagrid();
      }

      try {
        if (!g.jdb.containsKey(grid_id)) {
          // g.tmsg("into_datagrid_gridview_not_found:" + grid_id + ":" + g.db.keys.toString());
        } else {
          print("into_datagrid_gridview_found:" + grid_id + " : " +
              g.jdb[grid_id].length.toString());
          if (g.datagrid_tag == "firebase") {
            try {
              setState(() {
                widget.dt.add(g.db[grid_id][g.db[grid_id].length - 1]);
                if (m.containsKey("data_revert")) {
                  setState(() {});
                }
                update_datasource();
                Future.delayed(Duration(milliseconds: 1), () {
                  xscroll.animateTo(xscroll.position.maxScrollExtent,
                      duration: Duration(milliseconds: 10),
                      curve: Curves.linear);
                });
              });
            } catch (e) {
              print("firebase.tag.error." + e.toString());
            }
          }
          else {
            // default  case
            if (g.strin(g.cmdval("fill"), "reset")) {
              await clear_datagrid();

              try {
                int delay = 0;
                if (g.cmd.containsKey("reset_time")) {
                  delay = g.cint(g.cmdval("reset_time"), delay);
                }
                Future.delayed(Duration(milliseconds: delay), () {
                  setState(() {
                    try {
                      append_data(g.jdb[grid_id], true);
                    } catch (e) {}
                  });
                });
              } catch (e) {}
            } else {
              switch (sfill) {
                case "t":
                  List olddt = [];
                  if (widget.dt.length > 0) {
                    widget.dt.forEach((ex) {
                      olddt.add(ex);
                    });
                  }
                  setState(() {
                    widget.dt = [];
                    Future.delayed(Duration(milliseconds: 30), () {
                      if (olddt.length > 0) {
                        widget.dt.insertAll(0, olddt);
                        widget.dt.insertAll(0, g.jdb[grid_id]);
                        update_datasource();
                      } else {
                        widget.dt.addAll(g.jdb[grid_id]);
                        update_datasource();
                      }
                    });
                  });
                  break;
                default:
                // fill= empty,b
                  int delay = 0;
                  Future.delayed(Duration(milliseconds: delay), () {
                    if (g.jdb[grid_id] != null) {
                      append_data(g.jdb[grid_id], false);
                    }
                  });
                  break;
              }
            }
          }

          wrowh = DynamicWidgetBuilder.buildWidgets(jsonDecode("[" +
              g.page_replace(g.read_json(g.json_ui, m["row_null"]), widget.skey,
                  "row_head") + "]"), widget.ctx, widget.listener);
          Future.delayed(Duration(milliseconds: 200), () {
            if (widget.dt.length == 0) {
              if (m.containsKey("row_null")) {
                setState(() {
                  // _items.addAll(wrowh);
                });
              }
            }
          });
        }
      } catch (e) {
        print("into_datagrid" + e.toString());
      }
    }
  }


  Future<void> after_updaterow() async {

    try{
      if(m.containsKey("xdb")){
        g.xdb[m["xdb"]]=g.db[grid_id];
      }}catch(e){}

    await update_scroll();

  }

  update_scroll(){



    String start_scroll2=g.null2str(m["start_scroll2"]);
    if(start_scroll2 =="b" ) {

      /*Future.delayed(const Duration(milliseconds: 50), () {
       _scrollController.animateTo(
           _scrollController.position.maxScrollExtent,
           duration: Duration(milliseconds: 50), curve: Curves.linear);
     });*/
      Future.delayed(const Duration(milliseconds: 10), () {
        xscroll.jumpTo(xscroll.position.maxScrollExtent);

      });


      start_scroll2="";

    }
    if(g.cmdval("scroll2")=="t" || g.null2str(m["scroll2"])=="b"){
      Future.delayed(const Duration(milliseconds: 20), () {
        xscroll.animateTo(
            0.0,
            duration: Duration(milliseconds: 20), curve: Curves.linear);
      });
    }
    if(g.cmdval("scroll2")=="b"|| g.null2str(m["scroll2"])=="b"){
      scroll2end();
    }
    if(m.containsKey("auto_tag")){
        if(start_rowindex !=0) {
          xscroll.scrollToIndex(start_rowindex,preferPosition: AutoScrollPosition.begin);
          Future.delayed( Duration(milliseconds: 500),(){
            xscroll.scrollToIndex(start_rowindex,preferPosition: AutoScrollPosition.begin);
          });
        }
    }




  }
  scroll2end() async {


/*  await Future.delayed(const Duration(milliseconds: 100));
  SchedulerBinding.instance?.addPostFrameCallback((_) {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 10),
        curve: Curves.fastOutSlowIn);
  });*/



    try{
      xscroll.animateTo(xscroll.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.fastOutSlowIn);
      List<int> itime=[400,1000];
      itime.forEach((this_time) {

        try{
          Future.delayed( Duration(milliseconds: this_time),(){
            xscroll.jumpTo(xscroll.position.maxScrollExtent);
          });
        }catch(e){}

      });
    }catch(e){}



  }
  update_table(){
    try{

      if(g.db.containsKey(grid_id)){
        if(widget.dt.length != g.db[grid_id].length){

          if(widget.dt.length >= g.db[grid_id].length){
            g.db[grid_id]=widget.dt;
          }else {
            widget.dt=g.db[grid_id];
          }
        }
      }
    }catch(e){}


  }

  loopx(){

    if(g.active_key==widget.skey) {
      // print("loop_gridcmd." + grid_id);
      if (widget.event_cmd != "") {
        event2cmd(widget.event_cmd);
      }
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      loopx();
    });

  }
  q() async {
    /* print("grid_cmd=${widget.grid_cmd } ${Timeline.now}");

    if(widget.grid_cmd != ""){
      //g.bmsg("q=${widget.grid_cmd}");
      print("grid.q:${widget.grid_cmd }");
      await event2cmd(widget.grid_cmd);
      //widget.grid_cmd="";
    }*/

  }


  setrow(){
    // g.callbmsg("datgrid_rowupdate");
    try {
      var rowindex = int.parse(g.cmd["rowindex"]);
      Map<String, dynamic> h = new Map<String, dynamic>();
      h= widget.dt[rowindex];

      if(g.cmd.containsKey("data_update")){
        List<String> a1 =g.getfval2("",g.cmdval("data_update")).split(",");



        List<String> b1;
        a1.forEach((s1) {
          b1=s1.split("[");
          if(b1.length>=2){
            if(b1[0]=="checkbox"){
              if(h[b1[0]]==b1[1]){
                h[b1[0]]="";
              }else {
                h[b1[0]]=b1[1];
              }
            }else {
              h[b1[0]]=b1[1];
            }
          }
        });
      }
      if(g.cmd.containsKey("data_toggle")){
        String sfield=g.cmdval("data_toggle");
        String sval=g.null2str(h[sfield]);
        if(sval!="1"){
          sval="1";
        }else {
          sval="0";
        }
        h[sfield]=sval;
      }

      //g.tmsg("set row:"+h.toString());
      h["r"]=rowindex.toString();
      setState((){
        g.db[grid_id][rowindex]=h;
        widget.dt[rowindex]=h;
      });
      update_row(h,rowindex);

    }

    catch (e) {
      g.tmsg("datagrid_updaterow.error." + e.toString());
    }
  }

  datagrid_updaterow2(int reqid){
    Future.delayed(Duration(milliseconds: 500), () {
      if(g.reqid==reqid){
        String s="";
        String sfield="";
        if(m.containsKey("row_checkbox")){
          sfield=g.null2str(m["row_checkbox"]);
          for (int i = 0; i < widget.dt.length; i++) {
            hx =widget.dt[i];
            if(g.null2str(hx["rcheck"])=="1"){
              s+=g.null2str(hx[sfield]).split(" ").first+" ";
            }
          }
          s=g.rcut(s);
          g.saveiform(grid_id, s);
          //  g.bmsg(s);
        }
      }

    });

  }


// gridid,rowid
  datagrid_updaterow(){
    var rowindex = 0;
    Map<String, dynamic> h = new Map<String, dynamic>();
    try {
      var c=g.cmdval("datagrid_updaterow").split(",");
      if(g.cmd.containsKey("rowindex")){
        rowindex=int.parse(g.cmd["rowindex"]);
      }

      if(c.length>=2){
        rowindex=int.parse(c[1]);
      }
      if(!(widget.dt.length > rowindex) ){
        update_table();
      }

      if(widget.dt.length > rowindex ){

        if(g.db.containsKey(grid_id)){
          h= g.db[grid_id][rowindex];
        }else {
          g.tmsg("not_found ${grid_id}");
        }

        List<String> a1 =g.getfval2("",g.cmdval("data_update")).split(",");
        if(g.cmd.containsKey("row_update")){
          a1 =g.cmdval("row_update").split(",");
        }
        List<String> b,b1,b2;
        a1.forEach((s1) {
          b1=s1.split("[");
          if(b1.length>=2){
            if(b1[0]=="checkbox" || (b1[0]=="rcheck")){
              if(h[b1[0]]==b1[1]){
                h[b1[0]]="";
              }else {
                h[b1[0]]=b1[1];
              }
            }else {
              h[b1[0]]=b1[1];
            }
          }
        });


        if(g.cmd.containsKey("inc_value")){

          int newval=0;
          int tval=0;
          a1 =g.cmdval("inc_value").split(",");

          a1.forEach((s1) {
            b1=s1.split("[");

            try {
              tval = g.cint(h[b1[0]], 0);
              newval = tval + g.cint(b1[1],0);

              if(g.cmd.containsKey("inc_rank")){
                b2=g.cmdval("inc_rank").split(",");
                if( newval<g.cint(b2[0],0) ||  newval>g.cint(b2[1],0) ){
                  newval = tval; // restore old value
                  if(g.cmd.containsKey("inc_over_rank_click")){
                    g.t_click=g.cmdval("inc_over_rank_click");
                  }
                }
              }
              h[b1[0]] = newval.toString();
              print("inc ${b1[0]}=${newval}");

            }catch(e){
              print("inc_value.error.${e.toString()}");
            }

          });
        }


        h["r"]=rowindex.toString();
        if(g.cmd.containsKey("jupdate")){
          a=g.cmdval("jupdate").split(",");
          a.forEach((s1) {
            h[s1]=g.null2str(g.jd[s1]);
          });
        }


        if(g.cmd.containsKey("checkbox")){
          gval=g.cmdval("checkbox");
          if(g.null2str(h[gval]) != "1"){
            h[gval]="1";
          }else {
            h[gval]="0";
          }
        }
        if(g.cmd.containsKey("checkbox_all")){

          // clear select all
          setState(() {
            for (int i = 0; i < widget.dt.length; i++) {
              h =widget.dt[i];
              widget.dt[i]["checkbox"] = "0";
              widget.dt[i]["rcheck"] = "0";
              g.db[grid_id]=widget.dt;

            }
          });

          gval=g.cmdval("checkbox_all");
          if(g.null2str(h[gval]) != "1"){
            h[gval]="1";
          }else {
            h[gval]="0";
          }
        }

        if(h.length>0){
          // update_row(h,rowindex);

          setState(() {
            h.forEach((key, value) {
              g.db[grid_id][rowindex][key]=value;
            });
          });

          setState(() {
            g.db[grid_id][rowindex]=h;
            widget.dt[rowindex]=h;
          });
          //g.tmsg("Update row=${h}");
        }
      }else {
         g.alert("not_found_row_index ${widget.dt.length}");
      }
    }



    catch (e) {
      // g.bmsg("datagrid_updaterow.error." + e.toString()+" h="+h.toString());
    }


    if(rowindex==0 && h.containsKey("l")){

    }


    g.hx=h;
    if(g.cmd.containsKey("fx_click")){
      g.t_click=g.cmdval("fx_click");
    }

  }

  update_row(Map<String, dynamic> h,int rowindex){


    // g.msg(g.getrunseq()+".update_row"+h.toString()+":"+rowindex.toString());


    double offset = xscroll.offset;

    update_table();



    try {
      setState(() {
        widget.dt[rowindex] = h;
        if (g.db.containsKey(grid_id)) {
          g.db[grid_id][rowindex] = h;
        }

      });



      if(g.cmdval("row_update")=="*"){
        setState(() {
          update_datasource();
        });
      }else {


        var wgrow = DynamicWidgetBuilder.buildWidgets(
            jsonDecode(jsrow_temp([h])),
            widget.ctx, widget.listener);
        int delay_update = 0;
        Future.delayed(Duration(milliseconds: delay_update), () {
          if (mounted) {
            setState(() {
              //_items[rowindex] = wgrow[0];
              xscroll.jumpTo(offset);
              Future.delayed(Duration(milliseconds: 40), () {
                xscroll.jumpTo(offset);
              });
            });

          }
        });
      }
    }catch(e){
      g.tmsg("update_row.error."+e.toString()+"->     ${g.db[grid_id].length}  ${widget.dt.length} ");
    }
  }


  datagrid_filter() {
    try {


      // g.tmsg("f.datagrid_filter");

      /* List<String> l = widget.s_filter.split(".");
    List<String> a = l[1].split("[");
    String checkval=g.plink["active_value"].toString().toLowerCase();
*/


      a=g.cmdval("datagrid_filter2").split(",");
      a.removeAt(0);

      if (widget.dtx.length == 0) {
        widget.dt.forEach((dr) {
          widget.dtx.add(dr);
        });
      }

      setState(() {
        widget.dt.clear();
        dt_temp.clear();
      });

      if(a.length>0){



        a.forEach((s1) {
          b=s1.split("[");
          dt_temp= widget.dtx
              .where((dr) => dr[b[0]].toLowerCase().contains(b[1].toLowerCase()))
              .toList();
        });
      }else {
// restore
        widget.dtx.forEach((dr) {
          dt_temp.add(dr);
        });

      }



      Future.delayed(Duration(milliseconds: 50), () {
        setState(() {
          widget.dt=dt_temp;
          // g.bmsg("${checkval} found=${widget.dt.length}");
        });

      });






      // we use the toLowerCase() method to make it case-insensitive


    }catch(e){
      g.tmsg("filter.error.${e}");

    }


//var hcmd=g.read_cmd(widget.s_filter);

//g.tmsg("datagrid_filter${widget.s_filter}");
    /* if(!is_run){

      try{

        is_run=true;


        String fkey="";
        String fval="";
        String tval="";
        String filter_option="math";
        List arr=widget.str_filter.split(".");
        bool ischeck=true;

        if(cmd.containsKey("filter_option")){
          filter_option=g.cmdval("filter_option");
        }

        if(arr.length>=3){
          fkey=arr[1];
          fval=arr[2];
        }


        if( widget.dtx.length==0){
          if(widget.dt.length>=widget.dtx.length){
            widget.dtx.addAll(widget.dt);
          }
        }




        try {
          setState(() {
            widget.dt.clear();
            //_items.clear();
            //allwg.clear();
          });
        }catch(e){}


        Map<String, dynamic> h = new Map<String, dynamic>();
        for(int i=0; i<widget.dtx.length;i++){
          h=widget.dtx[i];
          if(h.containsKey(fkey)){
            tval=g.null2str(h[fkey]);
            if(filter_option=="math"){
              if(fval.toLowerCase()==tval.toLowerCase()){
                widget.dt.add(h);
              }
            }
            if(filter_option=="like"){

              ischeck=tval.toLowerCase().contains(fval.toLowerCase());
              // print("ischeck_"+tval+":"+fval+"_"+ischeck.toString());
              if(ischeck){
                widget.dt.add(h);
              }
            }

          }
        }

        print("datagrid_filter:"+widget.str_filter+" found="+widget.dt.length.toString()+"/"+widget.dtx.length.toString());


        g.db[grid_id].clear();
        g.db[grid_id].addAll(widget.dt);

        int fdelay=100;
        if(g.cmd.containsKey("fdelay")){
          fdelay=g.cint(g.cmdval("fdelay"),0);
        }
        Future.delayed(Duration(milliseconds: fdelay), () {
          if (mounted) {
            setState(() {
              update_datasource();
            });
          }

        });


      }catch(e){}
      is_run=false;

    }else {

      // backup cmd
      g.t_cmd.clear();
      g.cmd.forEach((key, value) {
        g.t_cmd[key]=value;
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        g.cmd.clear();
        g.t_cmd.forEach((key, value) {
          g.cmd[key]=value;
        });
        datagrid_filter();
      });
    }

    */
  }
  /*void q(){

    if (mounted) {
      isprocess=true;
      try {

        if(grid_id==g.grid_update){
          g.grid_update="";
          update_datasource();
        }

        if( widget.scmd != ""){
          widget.scmd="";
        }

        // if( widget.str_filter!=""){
        //   // datagrid_filter();
        // }

        String cmd="";
        if (g.gridcmd.containsKey(grid_id)) {
          cmd=g.gridcmd[grid_id];
          print("grid_cmd:"+cmd+":"+g.cmd.toString());
          String sfill =g.cmdval("fill");
          try{

            switch (cmd) {
              case "gridview_adddata":
                try {
                  genrow(1);
                  update_datasource();
                } catch (e) {
                  print("gridview_adddata.error." + e.toString());
                }
                break;
              case "datagrid_update":
                try {

                  widget.dt.clear();
                  _items.clear();
                  widget.dt.addAll(g.db[grid_id]);
                  update_datasource();

                }catch(e){}
                break;

              case "gridview_cleardata":
                try {
                  g.db[grid_id].clear();
                  if (mounted) {
                    setState(() {
                      widget.dt.clear();
                      _items.clear();
                    });
                  }
                } catch (e) {
                  print("gridview_cleardata.error." + e.toString());
                }
                break;

              case "gridview_removerow":
                try {
                  if (widget.dt.length > 0) {
                    widget.dt.removeAt(widget.dt.length - 1);
                    print("call remove");
                  }
                  print(":" + widget.dt.length.toString());
                  update_datasource();
                } catch (e) {
                  print("gridview_removerow.error." + e.toString());
                }

                break;
              case "updaterow":
                try {
                  print("call update row");

                  var rowindex = int.parse(g.cmd["rowindex"]);
                  Map<String, dynamic> vcmd = g.cmd;
                  vcmd.remove("cmd");
                  vcmd.remove("gridcmd");
                  vcmd.forEach((key, value) {
                    widget.dt[rowindex][key] = value;
                  });

                  String sui = "[" + rowx + "]";
                  sui = sui.replaceAll("{r}", rowindex.toString());

                  widget.dt[rowindex].forEach((k, v) {
                    sui = sui.replaceAll("{$k}", v);
                  });
                  update_datasource();


                } catch (e) {
                  print("updaterow.error." + e.toString());
                }

                break;

              case "gridview_selectrow":
                try {
                  var row_idex = int.parse(g.cmd["rowid"]);
                  var id = g.cmd["id"];
                  String sui = "[" + rowx + "]";

                  widget.dt[row_idex]["name"] = "x";
                  widget.dt[row_idex]["lname"] = "y";

                  sui = sui.replaceAll("{r}", row_idex.toString());
                  sui = sui.replaceAll("#F3F3F3", "#E3E3E3");
                  sui = sui.replaceAll("{name}", "name");
                  sui = sui.replaceAll("{lname}", "lname");


                  var wg = DynamicWidgetBuilder.buildWidgets(
                      jsonDecode(sui), widget._buildContext, widget._listener);

                  if (mounted) {
                    setState(() {
                      _items[row_idex] = wg[0];
                    });
                  }


                } catch (e) {
                  print("gridview_selectrow.error." + e.toString());
                }
                break;
            }
          }catch(e){}
          g.gridcmd.remove(grid_id);
        }


      }catch(e){
        print("grid.q.error."+e.toString());
      }
      isprocess=false;
    }

  }*/

  void checkrevert(){

    if(g.cmdval("data_revert")=="true"){
      List t=[];
      int im=g.db[grid_id].length-1;
      for(int i=0; i<im; i++){
        t.add(g.db[grid_id][im-i]);
      }
      g.db[grid_id]=t;
    }
  }


  String jsrow(List dt){


    if (dt.length == 0) {
      return "[]";
    }


    String row_tp=rowx;
    bool inrow=false;
    String sinrow="";
    if(row_tp.contains("{#row}")){
      sinrow = g.getlayout(m["row"]+"_row");
      inrow=true;
    }



    //print("template: "+rowx.toString());
    //print("__________________________________________________________");

    Map<String, dynamic> h = new Map<String, dynamic>();
    try {


      String fkey="";
      String fval="";
      String sval="";


      String s = "";
      String tmp = "";

      int i=0;
      bool isallow_ntext=true;
      List<String> a,b;
      int j=0;


      // switch layout row0,row2,row3,row4

      List<String> sp=g.null2str(m["split2layout"]).split(",");

      for ( i = 0; i < dt.length; i++) {
        tmp = row_tp;

        try{

          try {
            h = dt[i] as Map<String, dynamic>;
          }catch(e){
            print("jsrow.error."+dt[i].toString());
          }





          if(m.containsKey("split2data")){
            int max_data=7;
            b=g.null2str(h[m["split2data"]]).split(",");
            j=0;

            for(j=0;j<max_data;j++){
              if(b.length>j){
                h["d${j}"]=b[j];
              }else {
                h["d${j}"]="";
              }
            }


            if(m.containsKey("split2layout")){
              if(b.length>sp.length){
                h["l"]=sp[sp.length-1];
              }else {
                h["l"]=sp[b.length-1];
              }
            }

          }

          //row_split=img[f1,f2,f3...
          if(m.containsKey("row_split")){
            b=g.null2str(m["row_split"]).split("[");
            a=g.null2str(h[b[1]]).split(",");
            j=0;
            a.forEach((s1) {
              h[b[0]+j.toString()]=s1;
              j++;
            });
            h[b[0]+"_rowcount"]=a.length.toString();
          }
          //row_l=img_rowcount[l0,l1,l2,ldefault
          if(m.containsKey("row_l")){
            a=g.null2str(m["row_l"]).split("[");
            if(a.length>0){
              b=a[1].split(",");
              h["l"]=b.last;
              b.forEach((s1) {
                if(s1==g.null2str(h[a[0]])){
                  h["l"]=s1;
                }
              });
            }
          }


          if(s_filter!=""){
            if(s_filter.contains("=")){
              a=s_filter.split("=");
              sval=g.null2str(h[a[0]]);
              isallow_ntext=(sval==a[1]);
            }else {
              a=s_filter.split("[");
              sval=g.null2str(h[a[0]]);
              isallow_ntext=(sval.contains(a[1]));
            }

          }
        }catch(e){

          g.tmsg("filter.error."+e.toString());
        }

        if(isallow_ntext){



          if(m.containsKey("l")){
            row_tp = g.getlayout(h["l"]);
          }
          if(h.containsKey("l")){
            row_tp = g.getlayout(h["l"]);
          }
          tmp = row_tp;

          try {

            h.forEach((k, v) {
              tmp = tmp.replaceAll("{$k}", getsval(v));
            });
            tmp = tmp.replaceAll("{r}", i.toString());
            tmp = tmp.replaceAll("{irow}", (i+1).toString());
            tmp = tmp.replaceAll("{?}", g.newkey());
            tmp = tmp.replaceAll("{rguid}", g.getuuid());

            print("replace_var:"+h.toString());


          } catch (e) {
            print("jsrow_replace_error." + e.toString()+" data:"+row_tp);
          }
          if(inrow){


            int ir=0;
            String sall="";
            String s2="";

            s2 = s2.replaceAll("{?k}", g.active_key);
            s2 = s2.replaceAll("{k}", g.active_key);
            s2 = s2.replaceAll("{r}", i.toString());
            s2 = s2.replaceAll("{irow}", (i + 1).toString());
            s2 = s2.replaceAll("{?}", g.newkey());
            s2 = s2.replaceAll("{rguid}", g.getuuid());

            // s2 = s2.replaceAll("{sval}", s3);
            s2 = s2.replaceAll("{loop_r}", ir.toString());
            s2 = s2.replaceAll("{loop_irow}", (ir + 1).toString());

            sall += s2 + ",";
            ir += 1;




            if(ir!=0){
              tmp=tmp.replaceAll("{#row}", sall);
            }else {
              tmp=tmp.replaceAll("{#row}", "");
            }


          }



          s += tmp + ",";
          //  print("createuirow_loop:"+i.toString()+":"+tmp);
          // print("__________________________________________________________");
        }


      }
      if (s != ""&& s!="[]") {
        s = s.substring(0, s.length - 1);
        s = "[" + s + "]";
      }


      s_filter="";


      if(s==""){
        s="[]";
      }

      print("jsrow="+s);
      setState(() {
        widget.row_count=i;

      });

      return s;


    }catch(e){
      g.tmsg("create_uirow.error."+e.toString()+":"+h.toString());
    }


  }


  String jsrow_temp(List dt){


    if (dt.length == 0) {
      return "[]";
    }

    int i=0;
    s="";
    for ( i = 0; i < dt.length; i++) {
      s+='{"type":"Text","data":"x"},';
    }
    if(s!=""){
      s=g.rcut(s);
    }
    s="["+s+"]";
    return s;





    String row_tp=rowx;
    bool inrow=false;
    String sinrow="";
    if(row_tp.contains("{#row}")){
      sinrow = g.read_json(g.json_ui, m["row"]+"_row");
      inrow=true;
    }


    //print("___________________________row=${m["row"]}");

    // print("jsrow_:${dt.length} row");

    //print("template: "+rowx.toString());
    //print("__________________________________________________________");

    Map<String, dynamic> h = new Map<String, dynamic>();
    try {


      String fkey="";
      String fval="";

      // if( str_filter != ""){
      //   List arr=str_filter.split(".");
      //   if(arr.length>=3){
      //     fkey=arr[1];
      //     fval=arr[2];
      //   }
      // }
      //


      String s = "";
      String tmp = "";
      int i=0;
      bool isallow_ntext=true;
      List<String> a,b;
      int j=0;


      // switch layout row0,row2,row3,row4
      int irow_start=widget.dt.length;
      int irow=0;

      print(" start_row:=${irow}");

      List<String> sp=g.null2str(m["split2layout"]).split(",");

      for ( i = 0; i < dt.length; i++) {
        tmp = row_tp;

        try{

          try {
            h = dt[i] as Map<String, dynamic>;
          }catch(e){
            print("jsrow.error."+dt[i].toString());
          }





          if(m.containsKey("split2data")){
            int max_data=7;
            b=g.null2str(h[m["split2data"]]).split(",");
            j=0;

            for(j=0;j<max_data;j++){
              if(b.length>j){
                h["d${j}"]=b[j];
              }else {
                h["d${j}"]="";
              }
            }


            if(m.containsKey("split2layout")){
              if(b.length>sp.length){
                h["l"]=sp[sp.length-1];
              }else {
                h["l"]=sp[b.length-1];
              }
            }

          }

          //row_split=img[f1,f2,f3...
          if(m.containsKey("row_split")){
            b=g.null2str(m["row_split"]).split("[");
            a=g.null2str(h[b[1]]).split(",");
            j=0;
            a.forEach((s1) {
              h[b[0]+j.toString()]=s1;
              j++;
            });
            h[b[0]+"_rowcount"]=a.length.toString();
          }
          //row_l=img_rowcount[l0,l1,l2,ldefault
          if(m.containsKey("row_l")){
            a=g.null2str(m["row_l"]).split("[");
            if(a.length>0){
              b=a[1].split(",");
              h["l"]=b.last;
              b.forEach((s1) {
                if(s1==g.null2str(h[a[0]])){
                  h["l"]=s1;
                }
              });
            }
          }


          if(s_filter!=""){
            if(s_filter.contains("=")){
              a=s_filter.split("=");
              xval=g.null2str(h[a[0]]);
              isallow_ntext=(xval==a[1]);
            }else {
              a=s_filter.split("[");
              xval=g.null2str(h[a[0]]);
              isallow_ntext=(xval.contains(a[1]));
            }



            // if(h.containsKey(a[0])){
            //   isallow_ntext=(g.null2str(h[a[0]]).toLowerCase()==a[1].toLowerCase());
            //   isallow_ntext=true;
            // }
          }
        }catch(e){

          g.tmsg("filter.error."+e.toString());
        }

        if(isallow_ntext){

          if(m.containsKey("codetag")){
            if(g.null2str(m["codetag"])=="chat"){
              if(g.null2str(h["ffrom"])==g.login_id||g.null2str(h["msgfrom"])==g.login_id){
                row_tp="rmsg"+g.null2str(h["msgtype"]);
              }else {
                row_tp="lmsg"+g.null2str(h["msgtype"]);
              }
              h["l"]=row_tp;
            }
          }
          if(m.containsKey("rowtag")){
            xval=g.null2str(h[m["rowtag"]]);
            if(xval!=""){
              h["l"]=h["l"]+"_"+xval;
            }

          }


          if(m.containsKey("l")){
            row_tp = g.read_json(g.json_ui,h["l"]);
          }
          if(h.containsKey("l")){
            row_tp = g.read_json(g.json_ui,h["l"]);
          }
          tmp = row_tp;

          try {

            h.forEach((k, v) {
              xval=getsval(v);
              tmp = tmp.replaceAll("{$k}", xval);
              print("val_${xval}");
            });

            irow=irow_start+i;
            tmp = tmp.replaceAll("{row_index}", irow.toString());
            tmp = tmp.replaceAll("{r}", irow.toString());
            tmp = tmp.replaceAll("{irow}", (irow+1).toString());
            tmp = tmp.replaceAll("{?}", g.newkey());
            tmp = tmp.replaceAll("{rguid}", g.getuuid());


          } catch (e) {
            print("jsrow_replace_error." + e.toString()+" data:"+row_tp);
          }
          if(inrow){
            int ir=0;

            String sall="";
            String s2="";

            /* "a,b,c,d".split(",").forEach((s3) {
              if(s3!="") {*/

            //s2 = sinrow.replaceAll("{skey}", s3);
            s2 = s2.replaceAll("{?k}", g.active_key);
            s2 = s2.replaceAll("{k}", g.active_key);
            s2 = s2.replaceAll("{r}", irow.toString());
            s2 = s2.replaceAll("{irow}", (irow + 1).toString());
            s2 = s2.replaceAll("{?}", g.newkey());
            s2 = s2.replaceAll("{rguid}", g.getuuid());

            // s2 = s2.replaceAll("{sval}", s3);
            s2 = s2.replaceAll("{loop_r}", ir.toString());
            s2 = s2.replaceAll("{loop_irow}", (ir + 1).toString());

            sall += s2 + ",";
            ir += 1;

            /*  }
            });*/


            if(ir!=0){
              tmp=tmp.replaceAll("{#row}", sall);
            }else {
              tmp=tmp.replaceAll("{#row}", "");
            }
          }

          s += tmp + ",";
          //  print("createuirow_loop:"+i.toString()+":"+tmp);
          // print("__________________________________________________________");
        }
      }


      if (s != ""&& s!="[]") {
        s = s.substring(0, s.length - 1);
        s = "[" + s + "]";
      }
      s_filter="";

      if(s==""){
        s="[]";
      }

      //log("jsrow="+s);

      if(!g.is_json(s)){
        g.tmsg("format_format_error");
      }

      setState(() {
        widget.row_count=i;
      });
      return s;
    }catch(e){
      g.tmsg("create_uirow.error."+e.toString()+":"+h.toString());
    }

  }


  String getsval(Object o){
    String r="";
    try {
      if(o==null){
        o="";
      }
      r=o.toString();
      r=r.replaceAll("{","");
      r=r.replaceAll("}","");

    }catch(e){}
    r=r.replaceAll("\"", "\\\"");
    return r;
  }


  append_data(List<dynamic> dt,bool is_reset){
    //if (dt.length > 0) {

    var header_row="";
    if(widget.dt.length==0){
      if(m.containsKey("header_row")){
        header_row=g.getfval(m["skey"], m["header_row"]).toLowerCase();
        print("header_row:${header_row}");
        dt.insert(0, getjsonrow('{"is_header":true,"l":"${header_row}"}'));
      }
    }


    try{
      if(m.containsKey("database_field")){
        xval=m["database_field"];
        List<String> a=dt[0][xval].toString().split(",");
        List<dynamic> dx=[];
        Map<String, dynamic> h = new Map<String, dynamic>(); // link

        a.forEach((s) {
          if(s!=""){
            h = new Map<String, dynamic>();
            h["data"]=s;
            dx.add(h);
          }
        });
        dt=dx;
      }}catch(e){}

    try {


      if(g.isdebug()){
        g.alert("${grid_id} append_data:${dt.length}");
      }

      print("${grid_id} append_data:${dt.length}");
      setState(() {
        widget.dt.addAll(dt);
        g.db[grid_id] = widget.dt;
      });

      if (ispage && !is_run_first) {
        is_run_first = true;
        _onPageViewChange(0);
      }
    } catch (e) {
     // g.tmsg("append_data.error.${e}");
    }
    after_updaterow();

  }


  update_datasource(){

    try {

      if (mounted) {
        setState(() {
          if( widget.dt.length > 0 ){
            if(init_hide){
              Future.delayed(const Duration(milliseconds: 1), () {
                init_hide=false;
              });
            }else {

              try {
                djs = jsonDecode(jsrow_temp(widget.dt));
              }catch(e){
                print("datagrid_convert_json.error");
              }


            }

          }else {
            widget.dt=[];
          }
        });


      }

    }catch(e){
      print("gridview.update_datasource.error."+e.toString());
    }


/*
    if(g.cmdval("grid_scroll2")=="t"){
      _scrollController.animateTo(0.0, duration: Duration(milliseconds: 50), curve: Curves.linear);
    }
    if(g.cmdval("grid_scroll2")=="b"){
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 0), curve: Curves.linear);
    }*/



    /* switch(g.cmdval("set_scroll")){
      case "t":
        break;
      case "b":
        Future.delayed(Duration(milliseconds: 0), () {
          _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 1), curve: Curves.linear);
        });
        break;
    }
      if(m.containsKey("start_rowindex")){
        try {
          scroll2rowindex(m["start_rowindex"]);
        }catch(e){}

      }
      if(g.cmdval("start_rowindex")!=""){
        try {
          scroll2rowindex(g.cmdval("start_rowindex"));
        }catch(e){}

      }*/


    /*try {





        if (g.null2str(g.cmd["pageview_index"])!="") {
            pageview_control.jumpToPage(g.cint(g.cmdval("pageview_index"), 0));
        }
        if(g.null2str(m["pageview_index"])!=""){
          pageview_control.jumpToPage(g.cint(g.null2str(m["pageview_index"]), 0));
        }

        if(!is_startrow){
          is_startrow=true;
          if (g.null2str(g.c["pageview_rowindex"])!="") {
            pageview_control.jumpToPage(g.cint(g.c["pageview_rowindex"], 0));
          }
        }



    }catch(e){}
*/

    if(widget.dt.length > 0 ){
      if(m.containsKey("save_note_tag")){
        gval=g.null2str(m["save_note_tag"]);
        g.note_tag[gval]=g.null2str(gval);
      }

      /*if(ispage && !is_run_first){
    is_run_first=true;
    _onPageViewChange(0);
  }*/




    }
    after_updaterow();




  }


  scroll2rowindex(String srowindex){
    try {
      int irow=g.cint(srowindex, 0);
      double start_i=m["row_height"]*irow+g.cdbl(m["top_space"],0);
      xscroll.animateTo(start_i, duration: Duration(milliseconds: 0), curve: Curves.linear);

    }catch(e){}
  }

  String test(){
    return "test";
  }



  querydata(){
  }

  Widget _buildProgressIndicator2() {
    return  SliverToBoxAdapter(
      child: Container(),
    );
  }

  Widget _buildProgressIndicator() {
    return new SliverToBoxAdapter(
      child: Visibility(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Center(
            child: new Opacity(
              opacity: isPerformingRequest ? 1.0 : 0.0,
              child: new CircularProgressIndicator(),
            ),
          ),
        ),
        visible: !loadCompleted,
      ),
    );
  }

  Future<Null> R_onRefresh() async {


    try{
      //if(widget.dt.length>0){
        if(g.null2str(m["pull2refresh"])!="true"){
          g.t_click=g.null2str(m["pull2refresh"]).trim();
        }
        if(m.containsKey("pull2cmd")){
          g.run_cmd=g.null2str(m["pull2cmd"]).trim();
        }
      //}
    }catch(e){}
    return;
  }


  _onPageViewChange(int page) {

    setState(() {
      pageview_rowidex = page;
    });

    g.fr=new Map<String, dynamic>();
    try {
      if(g.db.containsKey(grid_id)){
        if(g.db[grid_id][page]!=null){
          (g.db[grid_id][page] as Map<String, dynamic>).forEach((key, value) {
            g.plink[key] = value;
            g.fr[key] = value;
          });
        }
      }
    }catch(e){
      //g.alert("_onPageViewChange.error."+e.toString());
    }


    g.plink["pageview_rowindex"]=page.toString();
    g.plink["pageview_tag"]="";

    if(page==0){
      g.plink["pageview_tag"]="first_row";
      if(m.containsKey("pageview_tclick")){
        g.t_click=g.null2str(m["pageview_tclick"]);
      }
    }
    if(page+1 >= widget.dt.length){
      g.plink["pageview_tag"]="last_row";
      if(m.containsKey("pageview_bclick")){
        g.t_click=g.null2str(m["pageview_bclick"]);
      }
    }
    if(page+2 == widget.dt.length){
      g.plink["pageview_tag"]="before_last_row";
      if(m.containsKey("pageview_bbclick")){
        g.t_click=g.null2str(m["pageview_bbclick"]);
      }
    }
    if(m.containsKey("pageview_change2click")){
      g.t_click=g.null2str(m["pageview_change2click"]);
    }


    if(m.containsKey("change2click")){
      Future.delayed(const Duration(milliseconds: 0), () {
        g.t_click=g.null2str(m["change2click"]);
        //g.tmsg("trigger:${g.t_click}");
      });
    }

  }

  String get_tp(String st,  Map<String, dynamic> hx,int index){
    hx.forEach((skey, sval) {
      st=st.replaceAll("{"+skey+"}", g.null2str(sval));
      st=st.replaceAll("{r}", index.toString());
    });
    return st;
  }

  void create_database(String stag){


    try {

      if (m["json_db"+stag] != null) {
        clear_datagrid();
        List dt = m["json_db"+stag];
        append_data(dt,false);
      }


      if (m["jdatabase"+stag] != null) {
        if(widget.dt.length==0){
          try {
            a = g.null2str(m["jdatabase"+stag]).split(",");
            List dt = jsonDecode(g.jdatabase[a[0]])[a[1]] as List;


            try{
              if(m.containsKey("edit_value")){
                xval=m["edit_value"];
                for(int i=0; i<dt.length; i++){
                  dt[i]["rcheck"]="0";
                  if(dt[i]["rdata"]==xval){
                    dt[i]["rcheck"]="1";
                  }
                }
              }}catch(e){
              // g.tmsg("jdatabase.error.${e}");
            }

            setState(() {
              widget.dt.addAll(dt);
              g.db[grid_id] = widget.dt;
            });
          } catch (e) {
          }
        }
      }



      if (m["genrow"+stag] != null) {
        setState(() {
          genrow(g.cint(m["genrow"+stag], 20));
          g.db[grid_id] = widget.dt;
        });
      }

      // {?grid_id}.{r}.dv
      if (m["database_row"+stag] != null) {
        setState(() {
          a=m["database_row"+stag].split(".");
          List dt = g.db[a[0]][g.cintx(a[1])][a[2]];
          append_data(dt,false);
        });
      }



      if(m.containsKey("genrow_str")){

        setState(() {
          genrow_fromstring(m["genrow_str"]);
          g.db[grid_id] = widget.dt;
        });
      }


      List allrow= jsonDecode(g.jsonx)["d"] as List;


      if (m["database_json"+stag] != null) {
        if(!g.g_database.containsKey(m["page_key"])){
          g.g_database[m["page_key"]]= jsonDecode(g.jsonx)[m["database_json"+stag]] as List;
        }
           if(g.g_database.containsKey(m["page_key"])){
            clear_datagrid();
            Future.delayed(const Duration(milliseconds: 0), () {
              try {
                append_data( g.g_database[m["page_key"]],false);
              } catch (e) {}
            });
          }
      }



      // try{
      //       allrow= jsonDecode(jsonx)["d"] as List;
      //       if(allrow.length>0){
      //         vjs = allrow[0] as  Map<String, dynamic>;
      //       }
      //     }catch(e){}



      if (m["database_db"+stag] != null) {
        clear_datagrid();
        Future.delayed(const Duration(milliseconds: 100), () {
          try {
            // dbkey.datatable
            a = g.null2str(m["database_db"+stag]).split(".");
            if (g.mem.containsKey(a[0])) {
              List dt = jsonDecode(g.mem[a[0]])[a[1]] as List;
              append_data(dt,false);
            }
          } catch (e) {}
        });
      }
      if (m["database_jdb"+stag] != null) {
        clear_datagrid();
        Future.delayed(const Duration(milliseconds: 100), () {
          try {
            // dbkey.datatable
            a = g.null2str(m["database_jdb"+stag]).split(".");
            if (a.length >= 4) {
              a[1] = a[0] + a[1];
              a.removeAt(0);
            }
            print("database_jdb ${a}");
            if (g.db.containsKey(a[0])) {
              List dt = g.db[a[0]][g.cint(a[1], 0)][a[2]];
              append_data(dt,false);
              //  g.tmsg("dt=${dt.length}");
            }
          } catch (e) {}
        });
      }




// database_from_info=filename.table_name
      if (m["database_from_info"+stag] != null) {
        clear_datagrid();
        Future.delayed(const Duration(milliseconds: 100), () {
          try {
            a = g.null2str(m["database_from_info"+stag]).split(".");
            List dt = jsonDecode(g.read_json(g.json_ui, a[0]))[a[1]] as List;
            append_data(dt,false);
          } catch (e) {}
        });
      }


      if (m["database"+stag] != null) {
        clear_datagrid();
        Future.delayed(const Duration(milliseconds: 100), () {
          xval = g.null2str(m["database"+stag]);
          print("database"+stag+":"+xval);
         widget.dtx.clear();
         widget.dtx = genrowdb(xval);
         append_data(widget.dtx,false);
        });
      }

      if (m["database_append"+stag] != null) {
        try {
          xval = g.null2str(m["database_append"+stag]);
          append_data(g.db[xval],false);

        }catch(e){
        }


      }
      if (m["database_table"+stag] != null) {

        clear_datagrid();
        Future.delayed(const Duration(milliseconds: 100), () {
          try {
            xval = g.null2str(m["database_table"+stag]);
            widget.dt.addAll(g.db[xval]);
            g.db[grid_id] = widget.dt;
            update_datasource();

          }catch(e){
            // g.tmsg("database_table.error.${e}");
          }
        });

      }
      if (m["init_data"+stag] != null) {
        try {
          xval = g.null2str(m["init_data"+stag]);
          widget.dt = jsonDecode(g.jsonx)[xval] as List;
          g.db[grid_id] = widget.dt;
        }catch(e){}
      }









    }catch(e){}


  }


  create_row(Map<String, dynamic> h,int index){

    if(hx.containsKey("is_header")){
      if(index!=0){
        return Container();
      }
    }

    if(hx.containsKey("l")){
      this_row=g.page_replace(g.read_json(g.json_ui, hx["l"]), "", "");
    }else {
      this_row=rowx;
    }

    if(m.containsKey("auto_tag")){
      return    AutoScrollTag(
          key: ValueKey(index),
          controller:xscroll,
          index: index,
          child: DynamicWidgetBuilder.build(get_tp(this_row,hx,index),
              widget.ctx, widget.listener,m["skey"])
      );
    } else {
      return  DynamicWidgetBuilder.build(get_tp(this_row,hx,index),
          widget.ctx, widget.listener,m["skey"]);

    }



  }





  scroll_end(){


    if(req_scroll2end){
       Future.delayed(const Duration(milliseconds: 100), () {
                xscroll.animateTo(xscroll.position.maxScrollExtent,
                    duration: Duration(milliseconds: 100), curve: Curves.linear);

              });


      req_scroll2end=false;
    }
  }


  grid_data()  {


    Future.delayed( Duration(milliseconds: m.containsKey("wait_time")? m["wait_time"]:400), () {
      if(is_first_time){
        is_first_time=false;
        try{
          if(widget.dt.length==0){
            setState(() {
              wait_ui=DynamicWidgetBuilder.build(g.read_json(g.json_ui,"grid_no_data"),  widget.ctx, widget.listener,widget.skey);
            });
          }
        }catch(e){}
      }



       /* if(g.g_database.containsKey(m["page_key"])){
          if(widget.dt.length==0){
          clear_datagrid();
          Future.delayed(const Duration(milliseconds: 0), () {
            try {
              append_data( g.g_database[m["page_key"]],false);
            } catch (e) {}
          });
        }*/
      //}
    });





    try
    {
      if(widget.dt.length>0){
        return sliverGrid;
      }
    }catch(e){}


    if(m.containsKey("wait_ui")){
      if(wait_ui==null){
         wait_ui=DynamicWidgetBuilder.buildFromMap(m["wait_ui"], widget.ctx, widget.listener);
      }
    }else {
      if(wait_ui==null){
        if(g.json_ui.containsKey("wait_ui")){
          wait_ui=DynamicWidgetBuilder.build(g.read_json(g.json_ui,"wait_ui"),  widget.ctx, widget.listener,widget.skey);
        }
      }
    }

       return SliverPadding(
         key: this_key,
         padding: _params.padding,
         sliver: SliverList(
           delegate: SliverChildBuilderDelegate(
                 (BuildContext context, int index) {
                   if(wait_ui!=null){
                     return  wait_ui;
                   }else {
                     return  Container(child: Text("Loadding..."));
                   }

             },
             childCount: 1, // 1000 list items
           ),
         ),
       );

  }

  @override
  Widget build(BuildContext context) {



    print("${grid_id}_gridview_buid");
    //g.tmsg("${grid_id}_gridview_buid");
    // cfg_hrow=g.page_replace(cfg_hrow,widget.s_filter,"cfg_hrow");


    create_database("2");

    if(g.null2str(m["is_debug"])=="true"){
      g.tmsg(grid_id+".build");
    }

    var bstream = Stream.periodic(Duration(milliseconds:1), (int i) => i);
    var decoration=null;
    String sval="";




    if(m.containsKey("firebase_path")){


      final size = MediaQuery.of(context).size;
      String row_temp=g.read_json(g.json_ui, m["row"]);
      String trow="";
      String firebase_path=g.null2str(m["firebase_path"]);


      return  StreamBuilder<QuerySnapshot>(
          stream:
          FirebaseFirestore.instance
              .collection('chatroom/x/x')
              .orderBy('timestamp', descending: true)
              .limit(100)
              .snapshots(),
          builder: (context, dx) {
            if (!dx.hasData) {
              return CircularProgressIndicator();
            } else {

              var dbr = dx.data.docs;//List.from(dx.data.docs.reversed);

              return ListView.builder(
                //key: g.getnewkey(),,
                reverse: _params.reverse,
                shrinkWrap: true,
                controller: xscroll,
                padding: EdgeInsets.all(10.0),
                itemCount: dx.data.docs.length,
                itemBuilder: (context, index){
                  trow=row_temp;
                  trow=jsrow_temp([dbr[index].data()]);
                  return   DynamicWidgetBuilder.buildFromMap(jsonDecode(trow)[0], widget.ctx, widget.listener);

                },
              );
            }
          });




    }else {


      //var footer = _buildProgressIndicator();
      var bstream = Stream.periodic(Duration(milliseconds:1), (int i) => i);

      if(m["h_switch"]!=null){
        sval=g.null2str(g.pvar[g.null2str(m["h_switch"])]);
        if(sval!=""){
          cfg_hrow=sval;
        }

      }




      var size = MediaQuery.of(context).size;

      String uitag=g.null2str(m['uitag']);


      if(m["row_height"]!=null){
        double itemHeight =m["row_height"];
        double itemWidth = size.width / 2;
        _params.childAspectRatio= (itemWidth / itemHeight);
      }
      /*if(m["row_width"]!=null){
        double itemHeight =size.height;
        double itemWidth =m["row_width"];
        _params.childAspectRatio=0.75;
      }*/



      if(m.containsKey("rowxy")){

        List<String> a=g.null2str(m["rowxy"]).split(",");

        // g.tmsg("xy=${a}");

        double vx=g.cdbl(a[0],100.0);
        int ix=(size.width/vx).ceil();
        _params.crossAxisCount=ix;
        _params.childAspectRatio= g.str2int(a[0])/g.str2int(a[1]);  //(g.cdbl(a[0],100.0) / g.cdbl(a[1],100.0));

      }

      // print("rato:"+ _params.childAspectRatio.toString());

      if(ispage){

        if(m["ui"]=="autogrid"){

     allwg=DynamicWidgetBuilder.buildWidgets(jsonDecode(jsrow(widget.dt)), widget.ctx, widget.listener);


     a=g.null2str(m["rowxy"]).split(",");
     ui=  GridPageView(
          controller: pageview_control,
          minChildWidth: g.cint(a[0],100),
          minChildHeight: g.cint(a[1],100),
          overlapIndicator: false,
          indicatorColor: g.getcolor(g.cstr(m["indicatorColor"], "#CFCFCF")),
          indicatorSelectorColor:g.getcolor(g.cstr(m["indicatorSelectorColor"],"#06A245")),
          children: allwg
        );

      /*  ui=  ui=  GriddedPageView(
          controller: pageview_control,
          minChildWidth: 120,
          minChildHeight: 120,
          overlapIndicator: false,
          children:
          List<Widget>.generate(20, (int index) {
            return Container(
              color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
            );


          }),  // overlapIndicator: false,
        );*/



           /* GriddedPageView(
          controller: pageview_control,
          minChildWidth: 120,
          minChildHeight: 120,
            children:DynamicWidgetBuilder.buildWidgets(widget.dt, widget.ctx, widget.listener)
             // overlapIndicator: false,
          );*/




        }else {
         if(g.null2str(m["show_indicator"])=="true"){
          return
            ui=  Stack(
              children: [
                PageView.builder(
                  scrollDirection: _params.scrollDirection,
                  reverse: _params.reverse,
                  pageSnapping:!(g.null2str(m["pageSnapping"])=="false"),
                  onPageChanged: _onPageViewChange,
                  controller:pageview_control,
                  itemBuilder: (context, index) {


                    if(m.containsKey("effect_code")){
                      switch(m["effect_code"]){
                        case "a":
                          var _scale = pageview_rowidex == index ? 1.0 : 0.8;
                          return TweenAnimationBuilder(
                              tween: Tween(begin: _scale, end: _scale),
                              duration: const Duration(milliseconds: 300),
                              child:
                              DynamicWidgetBuilder.build(get_tp(rowx,widget.dt[index],index),
                                  widget.ctx, widget.listener,m["skey"]),
                              builder: (context, double value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: child,
                                );
                              });
                          break;
                      }
                     }else {
                       return  DynamicWidgetBuilder.build(get_tp(rowx,widget.dt[index],index), widget.ctx, widget.listener,m["skey"]);
                     }


                    },
                  itemCount: widget.dt.length, // Can be null
                ),
                //creating dots at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 40,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20,0,20,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                          widget.dt.length,
                              (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                              onTap: () {
                                pageview_control.animateToPage(index,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              },
                              child: CircleAvatar(
                                radius: 5,
                                // check if a dot is connected to the current page
                                // if true, give it a different color
                                backgroundColor: pageview_rowidex == index
                                    ? g.getcolor2(g.null2str(m["color_dotx"]),"#009D6C")
                                    : g.getcolor2(g.null2str(m["color_dot"]),"#C4C5C2"),
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            );
           }else {
           ui = PageView.builder(
             scrollDirection: _params.scrollDirection,
             reverse: _params.reverse,
             pageSnapping: !(g.null2str(m["pageSnapping"]) == "false"),
             onPageChanged: _onPageViewChange,
             controller: pageview_control,
             itemBuilder: (context, index) {
               if (m.containsKey("effect_code")) {
                 switch (m["effect_code"]) {
                   case "a":
                     var _scale = pageview_rowidex == index ? 1.0 : 0.8;
                     return TweenAnimationBuilder(
                         tween: Tween(begin: _scale, end: _scale),
                         duration: const Duration(milliseconds: 300),
                         child:
                         DynamicWidgetBuilder.build(
                             get_tp(rowx, widget.dt[index], index),
                             widget.ctx, widget.listener, m["skey"]),
                         builder: (context, double value, child) {
                           return Transform.scale(
                             scale: value,
                             child: child,
                           );
                         });
                     break;
                 }
               } else {
                 return DynamicWidgetBuilder.build(
                     get_tp(rowx, widget.dt[index], index),
                     widget.ctx, widget.listener, m["skey"]);
               }
             },
             itemCount: widget.dt.length,
             // Can be null
             );
           }
        }


        if(m.containsKey("background_img")){
          decoration=BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(g.null2str(m["background_img"])),
              fit: BoxFit.cover,
            ),
          );
          ui=Container(
              decoration: decoration,
              child:ui
          );
        }
        return ui;


      }else {


        if(uitag=="listview"){
          if(!is_streem){
 //  g.tmsg("this case ");
         //maincase
            sliverGrid = SliverPadding(
              key: this_key,
              padding: _params.padding,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {

                    hx=widget.dt[index];
                    if(codetag=="chat"){
                      // reset
                      hx["l"]="lmsg";
                      if(g.null2str(hx["ffrom"])==g.login_id||g.null2str(hx["msgfrom"])==g.login_id){
                        hx["l"]="rmsg";//+g.null2str(hx["msgtype"]);
                      }else {
                        hx["l"]="lmsg";//+g.null2str(hx["msgtype"]);
                      }
                    }
                    return create_row(hx,index);
                  },
                  childCount:widget.dt.length,
                ),
              ),
            );
          }else {

            sliverGrid = SliverPadding(
              key: this_key,
              padding: _params.padding,
              sliver:  StreamBuilder(
                  stream: bstream,
                  builder: (context, snapshot) => SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {


                          hx=widget.dt[index];
                          return create_row(hx,index);


                        },
                        childCount:widget.dt.length,
                      )
                  )
              ),
            );
          }



        }else {


          // gridview

          if(!is_streem){

            try {
              sliverGrid = SliverPadding(
                key: this_key,
                padding: _params.padding,
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _params.crossAxisCount,
                      mainAxisSpacing: _params.mainAxisSpacing,
                      crossAxisSpacing: _params.crossAxisSpacing,
                      childAspectRatio: _params.childAspectRatio),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      if (widget.dt.length > index) {
                        hx = widget.dt[index];
                        return create_row(hx,index);

                      }
                    },
                    childCount: widget.dt.length,
                  ),
                ),
              );
            }catch(e){
              print("grid_error.${e}");
            }


          }else {

            sliverGrid = SliverPadding(
              key: this_key,
              padding: _params.padding,
              sliver:  StreamBuilder(
                //key: g.getnewkey(),,
                  stream: bstream,
                  builder: (context, snapshot) => SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _params.crossAxisCount,
                          mainAxisSpacing: _params.mainAxisSpacing,
                          crossAxisSpacing: _params.crossAxisSpacing,
                          childAspectRatio: _params.childAspectRatio),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {


                          hx=widget.dt[index];
                          return create_row(hx,index);


                            },
                        childCount:widget.dt.length,
                      )
                  )
              ),
            );
          }
        }
      }

      if(m["setscroll"]=="no"){

        try {
          ui =  CustomScrollView(
            key: uikey,
            slivers: <Widget>[h_ui, grid_data(),b_ui],
            physics: NeverScrollableScrollPhysics(),
            controller: xscroll,
            scrollDirection: _params.scrollDirection,
            reverse: _params.reverse,
            shrinkWrap: _params.shrinkWrap,
            cacheExtent: _params.cacheExtent,
          );
        }catch(e){}

      }else if(m.containsKey("pull2refresh") || m.containsKey("pull2cmd")){
        try {

          ui=  Flexible(child: RefreshIndicator(
            key: refreshKey,
            onRefresh: () {
              return R_onRefresh();
            },
            child:
            CustomScrollView(
              key: uikey,
              slivers: <Widget>[h_ui, grid_data(),b_ui],
              physics:AlwaysScrollableScrollPhysics(),
              controller: xscroll,
              scrollDirection: _params.scrollDirection,
              reverse: _params.reverse,
              shrinkWrap: _params.shrinkWrap,
              cacheExtent: _params.cacheExtent,
            ),
          ));


        }catch(e){}

      }else {

        try {

          if(cfg_hrow!=""){
            build_header();
         // }else {
           // h_ui = SliverToBoxAdapter(child: Container(child: Text(""),),);
          }

          ui= CustomScrollView(
            key: uikey,
            slivers: <Widget>[h_ui, grid_data(),b_ui],
            controller: xscroll,
            scrollDirection: _params.scrollDirection,
            reverse: _params.reverse,
            shrinkWrap: _params.shrinkWrap,
            cacheExtent: _params.cacheExtent,
          );

        }catch(e){}
      }

      if(m.containsKey("background_img")){
        decoration=BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(g.null2str(m["background_img"])),
            fit: BoxFit.cover,
          ),
        );
        ui=Container(
            decoration: decoration,
            child:ui
        );
      }



      if(m.containsKey("ui_height")){
        ui=Container(
            color:m.containsKey("background_color")? g.getcolor(m["background_color"]) :Colors.transparent,
            height: g.get_height(m["ui_height"]),
            child:ui
        );
      }


      if(g.null2str(m["scroll2"])=="b"){
        req_scroll2end=true;
      }
      if(req_scroll2end){
        scroll_end();
      }


      return ui;
    }

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;// end if uitag


}



doRequest() async {
  // Await the http get response, then decode the json-formatted responce.
  try {


    // var response = await http.get(Uri.parse(getLoadMoreUrl(
    //     _params.loadMoreUrl, _items.length, _params.pageSize)));
    // if (response.statusCode == 200) {
    //   return response.body;
    // }



  } on Exception catch (e) {
    print(e);
  }
  return "";
}

class GridViewParams {

  int crossAxisCount;
  Axis scrollDirection;
  bool reverse;
  bool shrinkWrap;
  double cacheExtent;
  EdgeInsetsGeometry padding=EdgeInsets.all(0.0);
  double mainAxisSpacing;
  double crossAxisSpacing;
  double childAspectRatio;
  List<Widget> children;


  int pageSize;

  //use for demo, if true, it will do the fake request.

  GridViewParams(
      this.crossAxisCount,
      this.scrollDirection,
      this.reverse,
      this.shrinkWrap,
      this.cacheExtent,
      this.padding,
      this.mainAxisSpacing,
      this.crossAxisSpacing,
      this.childAspectRatio,
      this.children,
      this.pageSize);
}
class SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight
    extends SliverGridDelegate {
  /// Creates a delegate that makes grid layouts with a fixed number of tiles in
  /// the cross axis.
  ///
  /// All of the arguments must not be null. The `mainAxisSpacing` and
  /// `crossAxisSpacing` arguments must not be negative. The `crossAxisCount`
  /// and `childAspectRatio` arguments must be greater than zero.
  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight({
    @required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.height = 56.0, double childAspectRatio,
  })  : assert(crossAxisCount != null && crossAxisCount > 0),
        assert(mainAxisSpacing != null && mainAxisSpacing >= 0),
        assert(crossAxisSpacing != null && crossAxisSpacing >= 0),
        assert(height != null && height > 0);

  /// The number of children in the cross axis.
  final int crossAxisCount;

  /// The number of logical pixels between each child along the main axis.
  final double mainAxisSpacing;

  /// The number of logical pixels between each child along the cross axis.
  final double crossAxisSpacing;

  /// The height of the crossAxis.
  final double height;

  bool _debugAssertIsValid() {
    assert(crossAxisCount > 0);
    assert(mainAxisSpacing >= 0.0);
    assert(crossAxisSpacing >= 0.0);
    assert(height > 0.0);
    return true;
  }

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    assert(_debugAssertIsValid());
    final double usableCrossAxisExtent =
        constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);
    final double childCrossAxisExtent = usableCrossAxisExtent / crossAxisCount;
    final double childMainAxisExtent = height;
    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: childMainAxisExtent + mainAxisSpacing,
      crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
      childMainAxisExtent: childMainAxisExtent,
      childCrossAxisExtent: childCrossAxisExtent,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(
      SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight oldDelegate) {
    return oldDelegate.crossAxisCount != crossAxisCount ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing ||
        oldDelegate.height != height;
  }
}

