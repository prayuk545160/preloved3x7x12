import '../../dynamic_widget.dart';
import '../../g.dart' as g;
import '../icons_helper.dart';
import '../utils.dart';
import 'package:flutter/material.dart';

class IconWidgetParser extends WidgetParser {
  IconWidgetParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

 var ui;
 if(g.null2str(m["ui"])=="icon_file"){

   ui= ImageIcon(AssetImage(m["data"]),
     color: m.containsKey('color') ? parseHexColor(m['color']) : null,
     size: m.containsKey("size")!=null? m["size"]:32,
    );

 }else  if(g.null2str(m["ui"])=="icon_url"){

   ui =
        ImageIcon(Image.network(m["data"]).image,
         size: m.containsKey("size")!=null? m["size"]:32,
          color: m.containsKey('color') ? parseHexColor(m['color']) : null,
        );

 }else {

   ui=Icon(
     m.containsKey('data')
         ? getIconUsingPrefix(name: m['data'])
         : Icons.android,
     size: m.containsKey("size") ? m['size'] : null,
     color: m.containsKey('color') ? parseHexColor(m['color']) : null,
     semanticLabel:
     m.containsKey('semanticLabel') ? m['semanticLabel'] : null,
     textDirection: m.containsKey('textDirection')
         ? parseTextDirection(m['textDirection'])
         : null,
   );

 }
    return ui;
  }

  @override
  String get widgetName => "icon";
}
