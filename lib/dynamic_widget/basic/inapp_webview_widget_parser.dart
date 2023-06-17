
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart' as dio;
import 'package:share_extend/share_extend.dart';

import '../../g.dart';


class webviewParser2 extends WidgetParser {

  final List<String> dtag;
  webviewParser2(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    m["skey"]= dtag[0];

    return webview_ex2(buildContext,m);

    return TextField(textAlign: TextAlign.left,
        decoration: new InputDecoration(hintText: g.null2str(m["hinttext"]), contentPadding: const EdgeInsets.all(5.0))
    );
  }

  @override
  String get widgetName => "webview2";
}

class webviewParser extends WidgetParser {

  final List<String> dtag;
  webviewParser(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    m["skey"]= dtag[0];

    return webview_ex2(buildContext,m);

    return TextField(textAlign: TextAlign.left,
        decoration: new InputDecoration(hintText: g.null2str(m["hinttext"]), contentPadding: const EdgeInsets.all(5.0))
    );
  }

  @override
  String get widgetName => "webview";
}
class webview_ex2 extends StatefulWidget {

  final BuildContext buildContext;
  final  Map<String, dynamic> m;
  StreamController<String> eventx =null;
  webview_ex2( this.buildContext, this.m,{Key key, this.eventx}) : super(key: key);



  String id() {
    return g.null2str(m["id"]);
  }

  void addevent(String e){
    if(eventx!=null){
      eventx.add(e);
    }
  }

  @override
  _webview_ex2State createState() => _webview_ex2State(m);

}

class _webview_ex2State  extends State<webview_ex2> {

  final  Map<String, dynamic> m;
  final key = UniqueKey();
  String url="";
  //WebViewController _webViewController;
  bool isinit=false;
  num position = 1 ;

  String skey;
  _webview_ex2State(this.m);


  @override
  void dispose() {
    try{
      widget.eventx.close();
    }catch(e){}
    super.dispose();
  }



  doneLoading(String A) {



  }

  startLoading(String A){




  }

  void readevent(){
    try{
      widget.eventx = new StreamController();
      widget.eventx.stream.listen((data) {
        event2cmd(data);
      });
    }catch(e){}
  }

  void event2cmd(String s){
    List<String> a=s.split(",");
   // print("inapp_webview="+a.toString());

   // g.tmsg("inapp_webview"+a.toString());
    if(a.length==2){
      setState(() {
        url=g.readurl(a[1]);
        webview_control.loadUrl(urlRequest: URLRequest(
          url: Uri.parse(url),
        ));
        print("inapp_webview_url_update:${url}");
      });
    }
    else if(a.length>=3){
      switch(a[1]){
        case "send_cmd":
          break;
        case "save_screen_shot":
          webview_control.takeScreenshot().then((bytes) async {
            var len = bytes.lengthInBytes;
            final directory = (await getApplicationDocumentsDirectory()).path;
            String fileName = DateTime.now().toIso8601String();
            var path = '$directory/file_$fileName.png';
            File imgFile = new File(path);
            await imgFile.writeAsBytes(bytes).then((onValue) {

            /*  Future.delayed( Duration(milliseconds: 1000), () {
                inapp_webViewController?.loadUrl(urlRequest: URLRequest(
                  url: Uri.parse(url),
                ));
              });
              */

            });
          });
          break;

        case "share_screen_shot":
          webview_control.takeScreenshot().then((bytes) async {
            var len = bytes.lengthInBytes;
            final directory = (await getApplicationDocumentsDirectory()).path;
            String fileName = DateTime.now().toIso8601String();
            var path = '$directory/file_$fileName.png';
            File imgFile = new File(path);
            await imgFile.writeAsBytes(bytes).then((onValue) async {
            await ShareExtend.share(imgFile.path, "Screenshot taken");


            /*  Future.delayed( Duration(milliseconds: 1000), () {
                inapp_webViewController?.loadUrl(urlRequest: URLRequest(
                  url: Uri.parse(url),
                ));
              });*/




            });
          });
          break;
      }

    }
  }



  @override
  void initState() {
    try{
      url=g.null2str(widget.m["url"]);
      if(g.null2str(m["show_wait"])=="false"){
        setState(() {
          position = 0;
        });
      }

    }catch(e){}
    readevent();
    super.initState();

  }





  @override
  Widget build(BuildContext context) {

   /* Future.delayed( Duration(milliseconds: 200), () {
      setState(() {
        position = 0;
      });
    });*/

    return IndexedStack(
        index:position,  //        index: position,
        children: <Widget>[
          InAppWebView(
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform:
              InAppWebViewOptions(javaScriptCanOpenWindowsAutomatically:true,useShouldOverrideUrlLoading: true, javaScriptEnabled: true),
          ios: IOSInAppWebViewOptions(),
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ),
          ),
            onWebViewCreated: (controller ) {
             webview_control = controller;
             Future.delayed( Duration(milliseconds: 3000),() {
               //webview_control.a

               /*controller.addJavaScriptHandler(handlerName: 'cmd', callback: (args) {
                 // return data to the JavaScript side!
                 return "this is abook";
               });*/


                controller.postWebMessage(message: WebMessage(data: "capturePort"), targetOrigin: Uri.parse("*"));



             });


            controller.addJavaScriptHandler(handlerName: "mx", callback: (args) {
              g.page_cmd=args[0];

               return args.reduce((curr, next) => curr + next);
            });
            },

            /*onConsoleMessage: (controller, consoleMessage) {
              g.tmsg("${consoleMessage}");
              // it will print: {message: {"bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
            },*/

            initialUrlRequest: URLRequest(
                url: Uri.parse(url)
            ),
            key: key ,
            onLoadError: (_, __, ___, ____) {
              setState(() {
                position = 0;
              });            },
            onLoadHttpError: (_, __, ___, ____) {
              setState(() {
                position = 0;
              });
            },
            onLoadStart: (controller, url) async {
              /*Future.delayed( Duration(milliseconds: 4000), () {
              setState(() {
                 position = 0;
              });
              });*/
              startLoading;
            },
            onLoadStop: (controller, url) async {
              setState(() {
                position = 0;
              });
               doneLoading;
            },


           /* initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(javaScriptEnabled: true,
                  // debuggingEnabled: true,
                  useOnDownloadStart: true
              ),
            ),*/

            shouldOverrideUrlLoading: (controller, request) async {
              var url = request.request.url.toString();
              var uri = Uri.parse(url);

              if (!["http", "https", "file",
                "chrome", "data", "javascript",
                "about"].contains(uri.scheme)) {
                if (await canLaunch(url)) {
                  // Launch the App
                  await launch(
                    url,
                  );
                  // and cancel the request
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },



            onDownloadStart: (controller, url) async {

              try {

             /*   List<String> l=url.toString().split(",");

                String b64 = utf8.decode(base64.decode("${l[1]}"));     // username:password
*/

/*
 List<String> l=url.toString().split(",");
                 var dir=(await getTemporaryDirectory()).path;
 Uint8List by= Base64Decoder().convert(l[1]);
*/

 //g.bmsg("${b64}");


                /* await dio.Dio().download(
                    "",
                    "",
                    onReceiveProgress: (received, total) {
                      if (total != -1) {

                      }else {
                       // g.tmsg("Save file:${savePath}");
                      }
                    });
*/


             /*  List<String> l=url.toString().split(",");
                 var dir=(await getTemporaryDirectory()).path;
            *//*     final decodedBytes = base64Decode(l[1]);
                 var fileImg=  File("file_1.png");
                 fileImg.writeAsBytesSync(decodedBytes);
*//*
               //  g.tmsg(" file.. ${fileImg.path}");

                final taskId = await FlutterDownloader.enqueue(
                  url: url.toString(),
                  savedDir:dir,
                  showNotification: true,
                  openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                );*/


              }catch(e){
                 g.tmsg("download file.error."+e.toString());
              }

            },
          ),

          Container(
            color: Colors.white,
            child: Center(
                child: CircularProgressIndicator()),
          ),
        ]);

  }
}

