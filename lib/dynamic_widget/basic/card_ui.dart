import 'package:flutter/material.dart';

import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class card_ui extends WidgetParser {
  card_ui(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    Map<String, dynamic> childMap = m['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);

    String clickEvent =
    m.containsKey("click_event") ? m['click_event'] : "";


    var rx;
    rx= Card(
      child: child,
    );

    if (m.containsKey("padding")) {
      EdgeInsetsGeometry spadding = parseEdgeInsetsGeometry(m['padding']);
      rx=Padding(padding:spadding,child: rx);
    }
    if (listener != null && clickEvent != null) {
      return InkWell(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: rx,
      );
    } else {
      return rx;
    }

  }

  @override
  String get widgetName => "Card";
}
