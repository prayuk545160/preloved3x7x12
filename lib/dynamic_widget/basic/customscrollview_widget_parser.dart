import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class CustomScrollViewParser extends WidgetParser {
  CustomScrollViewParser(List<String> dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    return
      CustomScrollView(
        slivers: DynamicWidgetBuilder.buildWidgets(
            m['slivers'], buildContext, listener),
      );


  }

  @override
  String get widgetName => "CustomScrollView";
}
//
//
// class customscrollview_ex extends StatefulWidget {
//
//   final BuildContext tcx;
//   final  Map<String, dynamic> m;
//   final ClickListener listener;
//   customscrollview_ex( this.tcx, this.m, this.listener);
//   @override
//   _customscrollview_exState createState() => _customscrollview_exState(tcx,m,listener);
//
// }
//
// class _customscrollview_exState  extends State<customscrollview_ex> {
//
//   final  Map<String, dynamic> m;
//   final BuildContext tcx;
//   final ClickListener listener;
//
//   _customscrollview_exState(this.tcx,this.m, this.listener);
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//
//
//
//   void dispose() {
//     super.dispose();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       CustomScrollView(
//         slivers: DynamicWidgetBuilder.buildWidgets(
//             m['children'], context, listener),
//       );
//   }
// }
//

