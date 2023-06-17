import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class PositionedWidgetParser extends WidgetParser {
  PositionedWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Positioned(
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
      top: map.containsKey("top") ? map["top"] : null,
      right: map.containsKey("right") ? map["right"] : null,
      bottom: map.containsKey("bottom") ? map["bottom"] : null,
      left: map.containsKey("left") ? map["left"] : null,
      width: map.containsKey("width") ? map["width"] : null,
      height: map.containsKey("height") ? map["height"] : null,
    );
  }

  @override
  String get widgetName => "Positioned";
}

class StackWidgetParser extends WidgetParser {
  StackWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    var wg;
    wg= Stack(
      alignment: m.containsKey("alignment")
          ? parseAlignment(m["alignment"])
          : AlignmentDirectional.topStart,
      textDirection: m.containsKey("textDirection")
          ? parseTextDirection(m["textDirection"])
          : null,
      fit: m.containsKey("fit") ? parseStackFit(m["fit"]) : StackFit.loose,
      clipBehavior: m.containsKey("clipBehavior")
          ? parseClip(m["clipBehavior"])
          : Clip.hardEdge,
      children: DynamicWidgetBuilder.buildWidgets(
          m['children'], buildContext, listener),
    );

    if (m.containsKey("click_event")) {
      String clickEvent =
      m.containsKey("click_event") ? m['click_event'] : "";
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: wg,
      );
    } else {
      return wg;
    }


  }

  @override
  String get widgetName => "Stack";
}
