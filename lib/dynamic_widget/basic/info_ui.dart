import 'dart:convert';

import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;

class info_ui extends WidgetParser {
  info_ui(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    try {
      g.i[g.null2str(m["tag"])] = m["info"];
    }catch(e){}
    return Wrap();
  }

  @override
  String get widgetName => "info";
}
