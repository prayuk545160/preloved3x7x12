import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';

import '../../g.dart' as g;

//Creates a box that will become as large as its parent allows.
class ExpandedSizedBoxWidgetParser extends WidgetParser {
  ExpandedSizedBoxWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return SizedBox.expand(
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "ExpandedSizedBox";
}

class SizedBoxWidgetParser extends WidgetParser {
  SizedBoxWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    var w=double.infinity;
    var h=double.infinity;

   // print(map.toString());

    if(map.containsKey("width")){
      w=g.iscreen(map["width"]);
    }
    if(map.containsKey("height")){
      h=g.iscreen(map["height"]);
    }



    return SizedBox(
      width: w,
      height: h,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );


  }

  @override
  String get widgetName => "SizedBox";
}
