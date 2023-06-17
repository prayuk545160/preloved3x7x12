library dynamic_widget;

import 'dart:convert';
import 'dynamic_widget/basic/loop.dart';
import 'dynamic_widget/basic/ConstrainedBox_ui.dart';
import 'dynamic_widget/basic/radio_groupui.dart';
import 'dynamic_widget/basic/inapp_webview_widget_parser.dart';

import 'dynamic_widget/basic/CircleAvatar_widget_parser.dart';
import 'dynamic_widget/basic/ClipOval_ui.dart';
import 'dynamic_widget/basic/Expansiontile_ui.dart';
import 'dynamic_widget/basic/Flexible_ui.dart';
import 'dynamic_widget/basic/IgnorePointer_ui.dart';
import 'dynamic_widget/basic/align_widget_parser.dart';
import 'dynamic_widget/basic/aspectratio_widget_parser.dart';
import 'dynamic_widget/basic/baseline_widget_parser.dart';
import 'dynamic_widget/basic/button_widget_parser.dart';
import 'dynamic_widget/basic/card_ui.dart';
import 'dynamic_widget/basic/center_widget_parser.dart';
import 'dynamic_widget/basic/cmd_ui.dart';
import 'dynamic_widget/basic/container_widget_parser.dart';
import 'dynamic_widget/basic/container_widget_parser2.dart';
import 'dynamic_widget/basic/dgraph_ui.dart';
import 'dynamic_widget/basic/dropcaptext_widget_parser.dart';
import 'dynamic_widget/basic/expanded_widget_parser.dart';
import 'dynamic_widget/basic/fittedbox_widget_parser.dart';
import 'dynamic_widget/basic/form_ui.dart';
//import 'dynamic_widget/basic/graph_ui.dart';
import 'dynamic_widget/basic/icon_widget_parser.dart';
import 'dynamic_widget/basic/image_widget_parser.dart';
import 'dynamic_widget/basic/indexedstack_widget_parser.dart';
import 'dynamic_widget/basic/info_ui.dart';
import 'dynamic_widget/basic/listtile_widget_parser.dart';
import 'dynamic_widget/basic/loadpage.dart';
import 'dynamic_widget/basic/muti_chip.dart';
import 'dynamic_widget/basic/opacity_widget_parser.dart';
import 'dynamic_widget/basic/padding_widget_parser.dart';
import 'dynamic_widget/basic/pdfview_ui.dart';
import 'dynamic_widget/basic/placeholder_widget_parser.dart';
import 'dynamic_widget/basic/qrscan_ui.dart';
import 'dynamic_widget/basic/row_column_widget_parser.dart';
import 'dynamic_widget/basic/safearea_widget_parser.dart';
import 'dynamic_widget/basic/selectabletext_widget_parser.dart';
import 'dynamic_widget/basic/selectx_ui.dart';
import 'dynamic_widget/basic/show_ui.dart';
import 'dynamic_widget/basic/sizedbox_widget_parser.dart';
import 'dynamic_widget/basic/stack_positioned_widgets_parser.dart';
import 'dynamic_widget/basic/tab_control_ui.dart';
import 'dynamic_widget/basic/tab_control_ui2.dart';
import 'dynamic_widget/basic/tabbar_ui.dart';
import 'dynamic_widget/basic/tabx.dart';
import 'dynamic_widget/basic/template.dart';
import 'dynamic_widget/basic/text_widget_parser.dart';
import 'dynamic_widget/basic/textview_ui.dart';
import 'dynamic_widget/basic/ui.dart';
import 'dynamic_widget/basic/vdoplay_ui.dart';
import 'dynamic_widget/basic/wrap_widget_parser.dart';
import 'dynamic_widget/basic/x.dart';
import 'dynamic_widget/basic/xfield_ui.dart';
import 'dynamic_widget/basic/xui.dart';
import 'dynamic_widget/scrolling/gridview_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'dynamic_widget/basic/GestureDetector_widget_parser.dart';
import 'dynamic_widget/basic/cliprrect_widget_parser.dart';
import 'dynamic_widget/basic/customscrollview_widget_parser.dart';
import 'dynamic_widget/basic/segmentedcontrol_widget_parser.dart';
import 'dynamic_widget/basic/singlechildscrollview_widget_parser.dart';
import 'dynamic_widget/basic/spacer_widget_parser.dart';
import 'dynamic_widget/basic/textfield_widget_parser.dart';
import 'dynamic_widget/basic/textformfield_widget_parser.dart';
import 'dynamic_widget/scrolling/pageview_widget_parser.dart';
import 'g.dart' as g;


class DynamicWidgetBuilder {

  static final Logger log = Logger('DynamicWidget');
  static final List<String> k = [];
  final String skey;
  static final _parsers = [
    loadpage_ui(k),
    info_ui(k),
    tabx_ui(k),
    template_ui(k),
    GestureDetectorWidgetParser(k),
    ContainerWidgetParser(k),
    CustomScrollViewParser(k),
    TextWidgetParser(k),
    TextFieldParser(k),
    TextformFieldParser(k),
    SelectableTextWidgetParser(k),
    RaisedButtonParser(k),
    RaisedButtonParser2(k),
    RowWidgetParser(k),
    ColumnWidgetParser(k),
    AssetImageWidgetParser(k),
    NetworkImageWidgetParser(k),
    img_parse(k),
    PlaceholderWidgetParser(k),
    GridViewWidgetParser(k),
    PageViewWidgetParser(k),
    ExpandedWidgetParser(k),
    PaddingWidgetParser(k),
    CenterWidgetParser(k),
    AlignWidgetParser(k),
    AspectRatioWidgetParser(k),
    FittedBoxWidgetParser(k),
    BaselineWidgetParser(k),
    StackWidgetParser(k),
    PositionedWidgetParser(k),
    indexedstackui(k),
    ExpandedSizedBoxWidgetParser(k),
    SizedBoxWidgetParser(k),
    OpacityWidgetParser(k),
    SingleChildScrollViewParser(k),
    WrapWidgetParser(k),
    DropCapTextParser(k),
    IconWidgetParser(k),
    SpacerWidgetParser(k),
    ClipRRectWidgetParser(k),
    SafeAreaWidgetParser(k),
    ListTileWidgetParser(k),
    segmentedParser(k),
    webviewParser2(k),
    CircleAvatarWidgetParser(k),
    ClipOvalWidgetParser(k),
    vdoplayerParser(k),
    pdfviewParser(k),
   // graph_uiParser(k),
    dgraphParser(k),
    panel_exp(k),
    card_ui(k),
    muti_chipui(k),
    show_ui(k),
    textview_ui(k),
    ContainerWidgetParser2(k),
    radion_groupui(k),
    selectx_ui(k),
    xfield_ui(k),
    xParser(k),
    form_ui(k),
    ConstrainedBox_ui(k),
    Flexible_ui(k),
    xui(k),
    ui(k),
    tabbox(k),
    tab_control(k),
    tab_control2(k),
    qrscan_ui(k),
    cmd_ui(k),
    IgnorePointer_ui(k),
    loop_ui(k),
  ];

  // # pdfviewParser(k),




  static final _widgetNameParserMap = <String, WidgetParser>{};
  static bool _defaultParserInited = false;

  DynamicWidgetBuilder(this.skey);
  // use this method for adding your custom widget parser
  static void addParser(WidgetParser parser) {
    log.info(
        "add custom widget parser, make sure you don't overwirte the widget type.");
    _parsers.add(parser);
    _widgetNameParserMap[parser.widgetName] = parser;
  }

  static void initDefaultParsersIfNess() {
    if (!_defaultParserInited) {
      for (var parser in _parsers) {
        _widgetNameParserMap[parser.widgetName] = parser;
      }
      _defaultParserInited = true;
    }
  }

  static Widget build(




      String json, BuildContext buildContext, ClickListener listener, String skey) {

     k.clear();
    //if(k.length==0){
      k.add(skey);
   // }






    initDefaultParsersIfNess();
    var map = jsonDecode(json);
    ClickListener _listener =
    listener == null ? new NonResponseWidgetClickListener() : listener;
    var widget = buildFromMap(map, buildContext, _listener);
    return widget;

  }

  static Widget buildFromMap(Map<String, dynamic> map,
      BuildContext buildContext, ClickListener listener) {

    String widgetName = map['type'];
    var parser = _widgetNameParserMap[widgetName];
    if (parser != null) {

      return   parser.parse(map, buildContext, listener);
    }

    log.warning("Not support type: $widgetName");
    return null;
  }

  static List<Widget> buildWidgets(

      List<dynamic> values, BuildContext buildContext, ClickListener listener) {

    List<Widget> rt = [];
    for (var value in values) {
      rt.add(buildFromMap(value, buildContext, listener));
    }
    return rt;
  }
}



/// extends this class to make a Flutter widget parser.
abstract class WidgetParser {
  /// parse the json map into a flutter widget.
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener);



  /// the widget type name for example:
  /// {"type" : "Text", "data" : "Denny"}
  /// if you want to make a flutter Text widget, you should implement this
  /// method return "Text", for more details, please see
  /// @TextWidgetParser


  String get widgetName;
}

abstract class ClickListener {
  void onClicked(String event);
}

class NonResponseWidgetClickListener implements ClickListener {
  static final Logger log = Logger('NonResponseWidgetClickListener');

  @override
  void onClicked(String event) {
    log.info("receiver click event: " + event);
    print("receiver click event: " + event);
  }
}
