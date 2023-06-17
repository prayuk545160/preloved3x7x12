import 'package:flutter/material.dart';

import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';

import '../../g.dart' as g;

class PageViewWidgetParser extends WidgetParser {

  final List<String> dtag;
  PageViewWidgetParser(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return PageView_ex(buildContext,m,listener);
  }

  @override
  String get widgetName => "PageView";
}


class PageView_ex extends StatefulWidget {

  final BuildContext _buildContext;
  final ClickListener _listener;
  final  Map<String, dynamic> m;

  PageView_ex( this._buildContext, this.m,this._listener);


  @override
  _PageView_exState createState() => _PageView_exState(m);

}

class _PageView_exState  extends State<PageView_ex> {

  final  Map<String, dynamic> m;
  final key = UniqueKey();
  num position = 1 ;
  final PageController _pageViewController = PageController(initialPage: 0); // set the initial page you want to show

  int _activePage = 0;

  String skey;
  _PageView_exState(this.m);
  @override

  void dispose() {
    super.dispose();
  }
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A){
    setState(() {
      position = 1;
    });
  }

  on_page_chage(int index){
    try{


    }catch(e){}

  }


  @override
  Widget build(BuildContext context) {

    var scrollDirection = Axis.horizontal;
    if (m.containsKey("scrollDirection") &&
        "vertical" == m["scrollDirection"]) {
      scrollDirection = Axis.vertical;
    }




    var cui=DynamicWidgetBuilder.buildWidgets(m['children'], widget._buildContext, widget._listener);

    if(g.null2str(m["show_indicator"])=="true"){
      return

        Stack(
          children: [
            PageView(
              scrollDirection: scrollDirection,
              reverse: m.containsKey("reverse") ? m["reverse"] : false,
              pageSnapping:
              m.containsKey("pageSnapping") ? m["pageSnapping"] : true,
              children: cui,
              controller: _pageViewController,
              onPageChanged: (int index){
                setState(() {
                  _activePage = index;
                });
                on_page_chage(index);
              },
            ),
            //creating dots at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 40,
              child: Container(
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      cui.length,
                          (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InkWell(
                          onTap: () {
                            _pageViewController.animateToPage(index,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn);
                          },
                          child: CircleAvatar(
                            radius: 5,
                            // check if a dot is connected to the current page
                            // if true, give it a different color
                            backgroundColor: _activePage == index
                                ? Colors.greenAccent
                                : Colors.white30,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ],
        );
    }else {
      PageView(
        scrollDirection: scrollDirection,
        reverse: m.containsKey("reverse") ? m["reverse"] : false,
        pageSnapping:
        m.containsKey("pageSnapping") ? m["pageSnapping"] : true,
        children: cui,
        controller: _pageViewController,
        onPageChanged: (int index){
          setState(() {
            _activePage = index;
          });
          on_page_chage(index);
        },
      );
    }

  }
}


//
//
//
// import '../../dynamic_widget.dart';
// import 'package:flutter/widgets.dart';
//
// import '../../g.dart';
//
// class PageViewWidgetParser extends WidgetParser {
//
//   final List<String> dtag;
//   PageViewWidgetParser(this.dtag);
//
//   @override
//   Widget parse(Map<String, dynamic> m, BuildContext buildContext,
//       ClickListener listener) {
//     m["skey"]= dtag[0];
//     return PageView_ex(buildContext,m,listener);
//   }
//
//   @override
//   String get widgetName => "PageView";
// }


//
// class PageView_ex extends StatefulWidget {
//
//   final BuildContext _buildContext;
//   final ClickListener _listener;
//   final  Map<String, dynamic> m;
//
//   PageView_ex( this._buildContext, this.m,this._listener);
//
//
//   @override
//   _PageView_exState createState() => _PageView_exState(m);
//
// }
//
// class _PageView_exState  extends State<PageView_ex>  with AutomaticKeepAliveClientMixin  {
//
//   final  Map<String, dynamic> m;
//   final key = UniqueKey();
//   num position = 1 ;
//
//   String skey;
//   _PageView_exState(this.m);
//
//   List<Widget> allwg;
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//
//     var scrollDirection = Axis.horizontal;
//     if (m.containsKey("scrollDirection") &&
//         "vertical" == m["scrollDirection"]) {
//       scrollDirection = Axis.vertical;
//     }
//     allwg=DynamicWidgetBuilder.buildWidgets(m['children'], widget._buildContext, widget._listener);
//     return
//       PageView(
//         scrollDirection: scrollDirection,
//         reverse: m.containsKey("reverse") ? m["reverse"] : false,
//         pageSnapping:
//         m.containsKey("pageSnapping") ? m["pageSnapping"] : true,
//         children: allwg,
//       );
//
//     ;
//   }
//
//   @override
//   bool get wantKeepAlive => true;
//
//
// }
//
// //
// // class KeepAlivePage extends StatefulWidget {
// //   KeepAlivePage({
// //     Key key,
// //     @required this.child,
// //   }) : super(key: key);
// //
// //   final Widget child;
// //
// //   @override
// //   _KeepAlivePageState createState() => _KeepAlivePageState();
// // }
// //
// // class _KeepAlivePageState extends State<KeepAlivePage>
// //     with AutomaticKeepAliveClientMixin {
// //   @override
// //   Widget build(BuildContext context) {
// //     /// Dont't forget this
// //     super.build(context);
// //     return widget.child;
// //   }
// //
// //   @override
// //   // TODO: implement wantKeepAlive
// //   bool get wantKeepAlive => true;
// // }
// //
// //
//
//
//
//
//
//
// /*
// class PageViewWidgetParser extends WidgetParser {
//   PageViewWidgetParser(List<String> dtag);
//
//   @override
//   Widget parse(Map<String, dynamic> map, BuildContext buildContext,
//       ClickListener listener) {
//     var scrollDirection = Axis.horizontal;
//     if (map.containsKey("scrollDirection") &&
//         "vertical" == map["scrollDirection"]) {
//       scrollDirection = Axis.vertical;
//     }
//     return PageView(
//       scrollDirection: scrollDirection,
//       reverse: map.containsKey("reverse") ? map["reverse"] : false,
//       pageSnapping:
//           map.containsKey("pageSnapping") ? map["pageSnapping"] : true,
//       children: DynamicWidgetBuilder.buildWidgets(
//           map['children'], buildContext, listener),
//     );
//   }
//
//   @override
//   String get widgetName => "PageView";
// }
// */

