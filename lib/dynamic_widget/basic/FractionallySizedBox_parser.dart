import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class WrapWidgetParser extends WidgetParser {
  WrapWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {

    Map<String, dynamic> childMap = map['child'];


    var wg;
    Widget child = childMap == null ? null : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);



    //   Wrap(
    //   direction: map.containsKey("direction")
    //       ? parseAxis(map["direction"])
    //       : Axis.horizontal,
    //   alignment: map.containsKey("alignment")
    //       ? parseWrapAlignment(map["alignment"])
    //       : WrapAlignment.start,
    //   spacing: map.containsKey("spacing") ? map["spacing"] : 0.0,
    //   runAlignment: map.containsKey("runAlignment")
    //       ? parseWrapAlignment(map["runAlignment"])
    //       : WrapAlignment.start,
    //   runSpacing: map.containsKey("runSpacing") ? map["runSpacing"] : 0.0,
    //   crossAxisAlignment: map.containsKey("crossAxisAlignment")
    //       ? parseWrapCrossAlignment(map["crossAxisAlignment"])
    //       : WrapCrossAlignment.start,
    //   textDirection: map.containsKey("textDirection")
    //       ? parseTextDirection(map["textDirection"])
    //       : null,
    //   verticalDirection: map.containsKey("verticalDirection")
    //       ? parseVerticalDirection(map["verticalDirection"])
    //       : VerticalDirection.down,
    //   children: DynamicWidgetBuilder.buildWidgets(
    //       map['children'], buildContext, listener),
    // );

    wg=FractionallySizedBox(
      widthFactor: 0.7,
      heightFactor: 0.3,
      child: child,
    );

    return wg;
  }

  @override
  String get widgetName => "FractionallySizedBox";
}
