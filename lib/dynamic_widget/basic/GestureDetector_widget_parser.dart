import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class GestureDetectorWidgetParser extends WidgetParser {
  GestureDetectorWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {

    String clickEvent =
    map.containsKey("click_event") ? map['click_event'] : "";
    return GestureDetector(
      onTap: () {
        listener.onClicked(clickEvent);
      },
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "GestureDetector";
}
