import 'dart:async';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';


class qr_readerParser extends WidgetParser {

  final List<String> dtag;
  qr_readerParser(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    m["skey"]= dtag[0];

    return qr_reader_ex(buildContext,m);

    return TextField(textAlign: TextAlign.left,
        decoration: new InputDecoration(hintText: g.null2str(m["hinttext"]), contentPadding: const EdgeInsets.all(5.0))
    );
  }

  @override
  String get widgetName => "qr_scan";
}


class qr_reader_ex extends StatefulWidget {

  final BuildContext _buildContext;
  final  Map<String, dynamic> m;

  TextEditingController txtc =  TextEditingController();
  qr_reader_ex( this._buildContext, this.m);


  String id() {
    return g.null2str(m["id"]);
  }

  @override
  _qr_reader_exState createState() => _qr_reader_exState(m);

}

class _qr_reader_exState  extends State<qr_reader_ex> {

  final  Map<String, dynamic> m;
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();

  _qr_reader_exState(this.m);

  @override
  Widget build(BuildContext context) {
    String url=g.null2str(m["url"]);
    return  PDF().cachedFromUrl(
      url,
      placeholder: (progress) => Center(child: Text('$progress %')),
      errorWidget: (error) => Center(child: Text(error.toString())),
    );
  }
}
