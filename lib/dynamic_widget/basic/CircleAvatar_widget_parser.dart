import 'package:flutter/material.dart';

import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class CircleAvatarWidgetParser extends WidgetParser {
  CircleAvatarWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {

    String clickEvent =
    map.containsKey("click_event") ? map['click_event'] : "";

    var containerWidget=null;

    Map<String, dynamic> childMap = map['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);

    containerWidget= CircleAvatar(
        radius: double.parse(map["radius"]),
        child:child ,
        backgroundColor: parseHexColor(map['backgroundColor']) ,
        backgroundImage: NetworkImage(map["src"])
    );


    if (listener != null && clickEvent != null) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: containerWidget,
      );
    } else {
      return containerWidget;
    }
  }

  @override
  String get widgetName => "CircleAvatar";
}
