import 'dart:async';

import 'package:animations/animations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../dynamic_widget.dart';
import '../../g.dart' as g;
import '../utils.dart';
import 'package:flutter/widgets.dart';

class indexedstackui extends WidgetParser {
  indexedstackui(List<String> dtag);



  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return indexedstackui_ex(buildContext,map,listener);
  }
  @override
  String get widgetName => "IndexedStack";
}
class indexedstackui_ex extends StatefulWidget {

  final BuildContext buildContext;
  final  Map<String, dynamic> m;
  final ClickListener listener;
  int tabindex=0;




  StreamController<String> eventx =null;


  String getid(){
    return g.null2str(m["id"]);
  }


  void addevent(String e){
    if(eventx!=null){
      eventx.add(e);
    }
  }

  indexedstackui_ex( this.buildContext, this.m,this.listener,{Key key, this.eventx}) : super(key: key);
  @override
  indexedstackui_exState createState() => indexedstackui_exState();



}


class indexedstackui_exState  extends State<indexedstackui_ex> {



  void readevent(){
    try{


      widget.eventx = new StreamController();
      widget.eventx.stream.listen((data) {
        event2cmd(data);
      });
    }catch(e){}
  }



  @override
  void initState() {
    super.initState();
    try{
      widget.tabindex=widget.m.containsKey("index") ? widget.m["index"] : 0;
    }catch(e){}
    readevent();

  }

  void event2cmd(String s){
    List<String> a=s.split(",");
    print("cmd="+a.toString());
   // g.bmsg("${a}");



    switch(a[0]){
      case "set_tabindex":
          setState(() {
            widget.tabindex=g.cint(a[1],0);
          });
          if(g.cmd.containsKey("fx_click")){
             Future.delayed( Duration(milliseconds: 0), () {
               g.t_click=g.cmdval("fx_click");
             });
          }
        break;
    }

  }



  @override
  void dispose() {
    try{
      widget.eventx.close(); //Streams must be closed when not needed
    }catch(e){}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return



      AnimatedSwitcher(
        transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
        duration: const Duration(milliseconds: 500),
        child: IndexedStack(
          index: widget.tabindex,
          alignment: widget.m.containsKey("alignment")
              ? parseAlignment(widget.m["alignment"])
              : AlignmentDirectional.topStart,
          textDirection: widget.m.containsKey("textDirection")
              ? parseTextDirection(widget.m["textDirection"])
              : null,
          children: DynamicWidgetBuilder.buildWidgets(
              widget.m['children'], widget.buildContext, widget.listener),
        ),
      );




/*



      PageTransitionSwitcher(
        duration: Duration(milliseconds: 250),
        transitionBuilder: (widget, anim1, anim2) {

          return FadeScaleTransition(
            animation: anim1,
            child: widget,
          );
        },
        child: IndexedStack(
        index: widget.tabindex,
        alignment: widget.m.containsKey("alignment")
            ? parseAlignment(widget.m["alignment"])
            : AlignmentDirectional.topStart,
        textDirection: widget.m.containsKey("textDirection")
            ? parseTextDirection(widget.m["textDirection"])
            : null,
        children: DynamicWidgetBuilder.buildWidgets(
            widget.m['children'], widget.buildContext, widget.listener),
      ),

      );




*/






  }



}