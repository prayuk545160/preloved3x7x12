import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class OpacityWidgetParser extends WidgetParser {
  OpacityWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Opacity(
      opacity: map["opacity"],
      alwaysIncludeSemantics: map.containsKey("alwaysIncludeSemantics")
          ? map["alwaysIncludeSemantics"]
          : false,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "Opacity";
}
