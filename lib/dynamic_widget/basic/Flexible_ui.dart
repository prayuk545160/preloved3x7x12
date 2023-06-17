import '../../dynamic_widget.dart';
import '../../g.dart' as g;
import '../utils.dart';
import 'package:flutter/widgets.dart';

class Flexible_ui extends WidgetParser {
  Flexible_ui(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {

    Map<String, dynamic> childMap = map['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);
      return Flexible(child: child,flex:g.cint(map['flex'],1),);
  }

  @override
  String get widgetName => "Flexible";
}
