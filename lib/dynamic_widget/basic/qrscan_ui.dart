import 'dart:async';

//import 'package:scan/scan.dart';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class qrscan_ui extends WidgetParser {

  final List<String> dtag;
  qrscan_ui(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return qrscan_ex(m,buildContext,listener);

  }
  @override
  String get widgetName => "qrscan";
}


class qrscan_ex extends StatefulWidget {

  final  Map<String, dynamic> m;
  final  BuildContext bd;
  final ClickListener cclick;

  String getid(){
    return g.null2str(m["id"]);
  }

  qrscan_ex(this.m, this.bd, this.cclick);

  @override
  _qrscan_exState createState() => _qrscan_exState();

}

class _qrscan_exState  extends State<qrscan_ex> {

  //ScanController controller = ScanController();
  bool isFirst = true;


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    String qrcode = '';

    if(g.null2str(widget.m["flash"])=="true"){
      Future.delayed( Duration(milliseconds:1000), () {
        //controller.toggleTorchMode();
      });
    }

    return  Text("scan");
/*
    ScanView(
      controller: controller,
      scanAreaScale: 1,
      scanLineColor: Colors.green.shade400,
      onCapture: (data) {
        g.pvar["get_qrcode"] = data;
        if(g.null2str(widget.m["auto_close"])=="true"){
          Navigator.pop(g.ctx(),g.q);
        }else {
          controller.pause();
          try {
            if (widget.m["f_click"] != null) {
              Future.delayed(Duration(milliseconds: g.cint(
                  g.null2str(widget.m["f_click_delay"]), 200)), () {
                g.t_click = g.null2str(widget.m["f_click"]);
              });
            }
          }catch(e){}
          Future.delayed(Duration(milliseconds: g.cint(
              g.null2str(widget.m["resume_time"]), 400)), () {
            controller.resume();
          });
        }
      },
    );*/
  }
}
