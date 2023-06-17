import '../../dynamic_widget.dart';
import '../icons_helper.dart';
import '../utils.dart';
import 'package:flutter/material.dart';

class SpacerWidgetParser extends WidgetParser {
  SpacerWidgetParser(List<String> dtag);
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Spacer(
      flex: map.containsKey('flex') ? map['flex'] : 1,
    );
  }

  @override
  String get widgetName => "Spacer";
}
