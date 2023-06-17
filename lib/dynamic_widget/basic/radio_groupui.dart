import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';



class radion_groupui extends WidgetParser {

  final List<String> dtag;
  radion_groupui(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return radion_groupex(buildContext,m);

  }

  @override
  String get widgetName => "button_group";
}


class radion_groupex extends StatefulWidget {

  final BuildContext _buildContext;
  final  Map<String, dynamic> m;
  radion_groupex( this._buildContext, this.m);
  String edit_value="";

  String id() {
    return g.null2str(m["id"]);
  }
  String get_edit_value() {
    return edit_value;
  }

  @override
  _radion_groupexState createState() => _radion_groupexState();

}

class _radion_groupexState  extends State<radion_groupex> {

  String sval="";



  @override
  Widget build(BuildContext context) {




    String sdata=g.null2str(widget.m["data"]);
    List<String> a,b;
    List<String> dblist=[];
    List<String> dblist2=[];


    if(sdata.contains("=")){
      dblist.clear();
      dblist2.clear();

      a= sdata.split(",");
      a.forEach((s1) {
        b=s1.split("=");
        dblist.add(b[0]);
        dblist2.add(b[1]);
      });


    }else {
      dblist= sdata.split(",");
      dblist2= sdata.split(",");
    }

    var wg;

    switch(g.null2str(widget.m["ui"])){
      case "radio_button":
        wg=CustomRadioButton(
          elevation: 2,
          padding : 3,
          spacing : 0.0,
          enableButtonWrap: true,
          horizontal: false,
          autoWidth:true,
          width: 140,
          unSelectedColor: g.getcolor(g.strx(widget.m["unSelectedColor"], "#FFFFFF")),
          buttonLables:dblist,
          buttonValues: dblist,
          unSelectedBorderColor:  g.getcolor(g.strx(widget.m["unSelectedBorderColor"], "#E0572A")),
          selectedBorderColor: g.getcolor(g.strx(widget.m["selectedBorderColor"], "#E0572A")),
          buttonTextStyle: ButtonTextStyle(
              selectedColor:g.getcolor(g.strx(widget.m["selectedColor"],"#000000")),
              unSelectedColor: g.getcolor(g.strx(widget.m["unSelectedColor"],"#000000")),
              textStyle: TextStyle(fontSize: 14)),
          radioButtonValue: (value) {

            try {
              setState(() {
                widget.edit_value = value;
              });
              if (widget.m.containsKey("fieldname")) {
                g.fx[widget.m["fieldname"]] = widget.edit_value;
              }
              g.t_click = g.null2str(widget.m["t_click"]);
            }catch(e){
              g.tmsg("error."+e.toString());
            }


          },
          selectedColor:  g.getcolor(g.strx(widget.m["selectedColor"],"#E0572A")),
        );
        break;
        default:
          wg=CustomCheckBoxGroup(
            elevation: 0,
            padding : 3,
            spacing : 0.0,
            enableButtonWrap: true,
            horizontal: false,
            unSelectedColor: g.getcolor(g.strx(widget.m["unSelectedColor"], "#FFFFFF")),
            buttonLables:dblist,
            buttonValuesList: dblist2,
            unSelectedBorderColor:  g.getcolor(g.strx(widget.m["unSelectedBorderColor"], "#E0572A")),
            selectedBorderColor: g.getcolor(g.strx(widget.m["selectedBorderColor"], "#E0572A")),
            buttonTextStyle: ButtonTextStyle(
                selectedColor:g.getcolor(g.strx(widget.m["selectedColor"],"#000000")),
                unSelectedColor: g.getcolor(g.strx(widget.m["unSelectedColor"],"#000000")),
                textStyle: TextStyle(fontSize: 14)),
            checkBoxButtonValues: (value) {
              try  {
              setState(() {
                widget.edit_value=g.list2str(value);
              });
              if(widget.m.containsKey("fieldname")){
                g.fx[widget.m["fieldname"]]=widget.edit_value;
              }
              g.t_click=g.null2str(widget.m["t_click"]);

              }catch(e){
                g.tmsg("error."+e.toString());
              }

            },
            selectedColor:  g.getcolor(g.strx(widget.m["selectedColor"],"#E0572A")),
          );
        break;
    }


    return wg;

  }



}



