import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class ConstrainedBox_ui extends WidgetParser {
  ConstrainedBox_ui(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    Map<String, dynamic> childMap = m['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);

var ui;
ui=ConstrainedBox(
  constraints: BoxConstraints.tightFor(width: 150, height: 150),
  child: child,
);




    // ConstrainedBox(
    //   constraints: BoxConstraints(
    //       minWidth: 200,
    //       minHeight: 200,
    //       maxWidth: 350,
    //       maxHeight: 350),
    //   child: Image.network(
    //       'https://www.kindacode.com/wp-content/uploads/2021/01/tiny-dog.jpg',
    //       // the original resolution is 101 x 97
    //       fit: BoxFit.fill
    //   ),
    // )





    return ui;
  }

  @override
  String get widgetName => "ConstrainedBox";
}
