import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class SingleChildScrollViewParser extends WidgetParser {
  SingleChildScrollViewParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    return raised_scrollview(buildContext,m,listener);


    return SingleChildScrollView(
      child: DynamicWidgetBuilder.buildFromMap(
          m["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "SingleChildScrollView";
}


class raised_scrollview extends StatefulWidget {

  final BuildContext tcx;
  final  Map<String, dynamic> m;
  final ClickListener listener;
  raised_scrollview( this.tcx, this.m, this.listener);
  @override
  _raised_scrollviewState createState() => _raised_scrollviewState(tcx,m,listener);

}

class _raised_scrollviewState  extends State<raised_scrollview> {

  final  Map<String, dynamic> m;
  final BuildContext tcx;
  final ClickListener listener;

  _raised_scrollviewState(this.tcx,this.m, this.listener);

  @override
  void initState() {
    super.initState();
  }



  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    var scrollDirection = Axis.vertical;
    if (m.containsKey("scrollDirection") &&
        "horizontal" == m["scrollDirection"]) {
      scrollDirection = Axis.horizontal;
    }
    return
      SingleChildScrollView(
          scrollDirection:scrollDirection,
        child: DynamicWidgetBuilder.buildFromMap(
            m["child"], tcx, listener),
      );


  }
}


