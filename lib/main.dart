import 'dart:collection';
import 'dart:convert';

import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:after_layout/after_layout.dart';
import 'package:audio_service/audio_service.dart';
//import 'package:barcode_scan/barcode_scan.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:context_holder/context_holder.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter_absolute_path/flutter_absolute_path.dart';
//import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_js/javascript_runtime.dart';
import 'package:flutter_js/js_eval_result.dart';
import 'package:flutter_js/quickjs/ffi.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:math_expressions/math_expressions.dart' as math;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:video_compress/video_compress.dart';
import '../dynamic_widget/basic/form_ui.dart';
import '../dynamic_widget/basic/xfield_ui.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:validators/validators.dart';



import 'chat/Controllers/fb_messaging.dart';
import 'dynamic_widget.dart';
import 'dynamic_widget/basic/container_widget_parser2.dart';
import 'dynamic_widget/basic/googlemap_2point.dart';
import 'dynamic_widget/basic/textview_ui.dart';
import 'dynamic_widget/basic/button_widget_parser.dart';
import 'dynamic_widget/basic/text_widget_parser.dart';
import 'dynamic_widget/basic/textfield_widget_parser.dart';
import 'dynamic_widget/basic/textformfield_widget_parser.dart';
import 'dynamic_widget/basic/image_widget_parser.dart';
import 'dynamic_widget/scrolling/gridview_widget_parser.dart';
import 'dynamic_widget/basic/indexedstack_widget_parser.dart';
import 'dynamic_widget/basic/show_ui.dart';
import 'dynamic_widget/basic/tabbar_ui.dart';
import 'dynamic_widget/basic/cmd_ui.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dynamic_widget/utils.dart';
import 'map/fgetplace.dart';
import 'map/fgetplace_autocomplate.dart';
import 'test/ftest.dart';
import 'g.dart' as g;

//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'g.dart';
//import 'package:geolocation/geolocation.dart' as geo;
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_core/firebase_core.dart' as  libfb;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;
import 'package:firebase_core/firebase_core.dart' as firebase_core;



import 'chat/Controllers/fb_auth.dart' as fba;
import 'chat/Controllers/fb_firestore.dart';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:convert' show utf8;
//import 'package:qrscan/qrscan.dart' as qrscan;
//import 'package:scan/scan.dart' as xscan ;
//import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:google_place/google_place.dart';
import 'dynamic_widget/basic/x.dart';
import 'map/gmap2.dart';
import 'package:clipboard/clipboard.dart';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';






/*

import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
*/



BuildContext gctx;
String tcmd="";

//final FacebookLogin fb = new FacebookLogin();
String _message = 'Log in/out by pressing the buttons below.';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try {
    gcameras = await availableCameras();
  }catch(e){}
  // setup_not();
  load_main(null);

}
/*
setup_not(){
  AwesomeNotifications().initialize(
      'resource://drawable/notification_icon',
      [            // notification icon
        NotificationChannel(
          channelGroupKey: 'basic_test',
          channelKey: 'basic',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          channelShowBadge: true,
          importance: NotificationImportance.High,
          enableVibration: true,
        ),

        NotificationChannel(
            channelGroupKey: 'image_test',
            channelKey: 'image',
            channelName: 'image notifications',
            channelDescription: 'Notification channel for image tests',
            defaultColor: Colors.redAccent,
            ledColor: Colors.white,
            channelShowBadge: true,
            importance: NotificationImportance.High
        )

        //add more notification type with different configuration

      ]
  );

  //tap listiner on notification
  AwesomeNotifications().actionStream.listen((ReceivedNotification receivedNotification){
    print(receivedNotification.payload['name']);
    //output from first notification:  FlutterCampus
  });
}*/

class load_app extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    load_main(context);
  }
}



load_main(BuildContext context) async {


  var ui;
  var wait_ui=Container(
    color: g.getcolor(g.g_startcolor),
  );

  g.run_one_time(context);
  runApp(
      MaterialApp(
        home: wait_ui,
        debugShowCheckedModeBanner: false,
      ));

  try{

    await g.read_config();

    if(g.main_appid==""){
      g.main_appid="start";
    }



    g.islogin=false;
    print("read_login_id:"+g.login_id);
    print("pkey_key:"+g.pkey.keys.toString());



    if(g.login_id==""){
      g.islogin=false;
    }

  }catch(e){
    print("main_error."+e.toString());
  }


  String url_loadui=geturl_ui(g.ui_path);
  if(pkey.containsKey("ui_path")){
    g.ui_path=geturl_ui(g.null2str(pkey["ui_path"]));
  //  print("found_ui_path=${}")
  }


  // load ui data  from filename
  if(pkey.containsKey("ui_data")){
    g.appui=null2str(pkey["ui_data"]);
  }


  // default parameter
  url_loadui+="&info_os="+g.getos()+"&start_app="+g.null2str(pkey["start_app"]);

  var rx;

  // if not found from cache
  if(g.appui==""){
    bool netok=false;

    try {

      rx = await g.http_get(g.geturl(url_loadui));
      if (rx.statusCode == 200) {
        g.appui=rx.body;
        g.appui_org=rx.body;
        netok=true;
      }
    }catch(e){}

   // print("net_is_ok_${netok}  ${rx}");


    if (!netok) {
      try {

        url_loadui= url_loadui=geturl_ui(g.ui_path);
        rx = await g.http_get(g.geturl(url_loadui));
        if (rx.statusCode == 200) {
          g.appui = rx.body;
          print("load_ui${rx.body}");

        }
      }catch(e){
        g.tmsg("Please check your internet connection and try again ");
        g.closeapp();
      }
    }

    print("new_new_error:${url_loadui}");
  }else {
    print("reused___________");
  }

  if (true) {

    //g.savekey("appui",g.appui);
    try {
      g.json_ui = jsonDecode(g.appui);
    }catch(e){
    }


    g.json_ui_src=g.json_ui;
    g.readappconfig_fromjson();
    g.save_config();



    if(!pkey.containsKey("ui_version")){
      try{
        savekey("ui_version",null2str(info["ui_version"]));
      }catch(e){}
    }

    if(g.null2str(pkey["ui_version"])!=""){
      savekey("ui_data",g.appui);
    }


    try{
      g.papp["info_ui_version"]=null2str(info["ui_version"]);
      g.papp["app_ui_version"]=null2str(pkey["ui_version"]);
    }catch(e){}




    g.json_appui[g.appui]=g.json_ui;
    g.active_appid=main_appid;
    dynamic dx=jsonDecode(g.read_json( g.json_ui,"info"));
    String startui=dx["startui"];


    g.islogin=false;
    if(g.login_id!=""){
      g.islogin=true;
    }
    if(!g.islogin){
      startui=dx["startui_nologin"];
    }


    // await f_setup_firebase();
    await g.run_firsttime();


    //startapp
    if(startui.contains(",")){
      ui=tabcontrol(startui,context,"tabmain");
    }else {
      ui=loadpage(startui,false,g.read_json( g.json_ui,startui),g.genkey(),false,null,g.time_waitui_tab,0);
    }

    const accentColor = Color(0xff00d573);

/*
    await JustAudioBackground.init(
      androidNotificationChannelId: "com.code2exit.ladyclub",
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );*/


    // regis audion serv
   /* try{
      g.audio_service = await AudioService.init(
        builder: () => AudioPlayerHandler(),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.ryanheise.ladyclub.channel.audio',
          androidNotificationChannelName: 'Audio playback',
          androidNotificationOngoing: true,
        ),
      );

    }catch(e){}*/


    runApp(
      Phoenix(


      /*  child:GestureDetector(
          onTap: () {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
    }*/

    //},
      child: MaterialApp(
        theme:  g.gettheme(),
        navigatorKey: ContextHolder.key,
        builder: BotToastInit(), //1. call BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()], //2. registered route observer
        title: 'code2exit',
        home: ui,
        debugShowCheckedModeBanner: false,
      ))
   //)
   );

   //   ),
  }

}

String geturl_ui(String surl){

  surl=surl
      .replaceAll("{appid}", g.main_appid)
      .replaceAll("{device_id}", g.null2str(papp["device_id"]))
      .replaceAll("{device_os}", g.getos())
      .replaceAll("{screen_x}", g.screen_w.toString())
      .replaceAll("{screen_y}", g.screen_h.toString())
      .replaceAll("{code_version}", g.code_version)
      .replaceAll("{os}", g.getos())
      .replaceAll("{osv}", g.null2str(papp["device_version"]));

  return surl;

}


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> f_setup_firebase(String skey) async {

  print("call_f_setup_firebase");
  try{


      WidgetsFlutterBinding.ensureInitialized();

      if(g.cmdval("regis_firebase") != "false"){
        await firebase_init(skey,g.cmd);
      }
      if(g.cmdval("regis_login") != "false"){
        await f_firebase_regis(skey,g.cmd);
      }
      if(g.cmdval("regis_noti") != "false"){
        await f_regis_fmsg(skey);
      }

      await g.regis_localnoti();

      g.papp["fb_uid"]=fb_user.user.uid;
      g.papp["fb_email"]=fb_user.user.email;

      if(fb_user.user.uid !=""){

        if(g.gfirebase_token==""){
          g.gfirebase_token = await FirebaseMessaging.instance.getToken();
          g.papp["fb_token"]=gfirebase_token;
        }
        g.pprofile["fb_token"]=g.papp["fb_token"];
        g.pprofile["fb_uid"]=fb_user.user.uid;
        g.pprofile["fb_email"]=fb_user.user.email;

        g.run_cmd=g.readjscmd("cmd_firebase_isregis");


      }


      if(g.isdebug()){
        alert("${g.getrunseq()} firebase_info:${g.papp}");
      }


  }catch(e){
    tmsg("firebase.regis.error ${e}");
  }

  try{
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

  }catch(e){}
}



class tabcontrol extends StatefulWidget {

   String stab;
  final BuildContext _btx;
  String tab_name;
  //final tag;
  tabcontrol(this.stab,this._btx,this.tab_name);

  @override
  _tabcontrolState createState() => _tabcontrolState();
}

class _tabcontrolState extends State<tabcontrol>
    with SingleTickerProviderStateMixin {


  TabController tab_control=null;
  int tab_index = 0;
  int tab_index_last = 0;
  String skey="main";

  List<Widget> ui_tabbar;
  List<Widget> uitab = [];
  List<Widget> wd;

  List<String> tkeyx= [];
  List<BuildContext> allbc= [];


  Map<String, dynamic> tabinfo = new  Map<String, dynamic>();
  Map<String, dynamic> htab = new  Map<String, dynamic>();
  Map<String, dynamic> tcmd = new  Map<String, dynamic>();

  var  tabpage;

  List<String> arr_caption=[];
  List<String> arr_icon=[];
  String nav_type="";
  String sval="";

  List<String> tabid;

  final List<GlobalKey> nav=[];
  double bottom_bar_height=48;
  double tab_height=48;

  List<Widget> tab_wg= new List<Widget>();
  String stp="";



  var lpanel=null;
  var rpanel=null;
  var appbar=null;
  var tpanel=null;
  var bpanel=null;



  void loadalltab(){


    try{




      print("tabinfo=${tabinfo}");


      tabid=widget.stab.split(",");
      arr_caption=tabinfo["tab"].toString().split(",");
      arr_icon=tabinfo["icon_url"].toString().split(",");
      nav_type=g.null2str(tabinfo["nav_type"]);





      int iloop=0;
      String tkey="";

      iloop=0;


      tabid.forEach((col) {
        print("load_tab:${col}");


        if(nav_type=="root"){
          nav.add(new  GlobalKey<NavigatorState>());
        }
        tkey=g.genkey();
        tkeyx.add(tkey);
        uitab.add(loadpage(col,true,g.read_json(g.json_ui,col),tkey,false,null,0,iloop));
        iloop+=1;
      });






      if(g.cmdval("tab_swipe")=="false" || g.null2str(tabinfo["tab_swipe"])=="false"){
        //kTabScrollDuration=Duration(milliseconds: 1);
      }else {
        //  kTabScrollDuration=Duration(milliseconds: 300);
      }



      //
      // print("event_log");

    }catch(e){
      print("loadalltab.error=${e}");
    }
  }

  _handleTabChange() {
    g.tmsg("Inside Handle Tab: Tab Index: " + tab_control.index.toString());


  }

 @override
  void initState() {

try{



    g.cmd.forEach((key, value) {
      tcmd[key]=value;
    });

    try  {
      tabinfo=jsonDecode(g.read_json( g.json_ui,widget.tab_name)) as Map<String, dynamic>;
      tabinfo["name"]=widget.tab_name;
    }catch(e){}
    loadalltab();


    g.ev = new StreamController();
    g.ev.stream.listen((data) {
      event2cmd(data);
    });



    for(int i=0; i<tabid.length; i++){
      htab["${i}"]="";
    }




   // g.tmsg("ui_tab from :${widget.tab_name+"_ui"}");



    String tab_ui = read_json(json_ui, widget.tab_name + "_ui");
    String tab_uix = tab_ui;

    if(json_ui.containsKey(widget.tab_name + "_uix")){
      tab_uix=read_json(json_ui, widget.tab_name + "_uix");
    }





    if(tab_ui==""){
      tab_ui=g.tab_ui;
    }



    List<String> noti_id=[];
    if(tabinfo.containsKey("noti_id")){
      noti_id=tabinfo["noti_id"].split(",");
    }


    List<String> a=[];
   // tabui=a,b,c,d|ax,bx,cx,dx
    if(tabinfo.containsKey("tabui")){
      a=tabinfo["tabui"].split("|");
    }


   for(int i=0; i<tabid.length; i++){

     // active
      if(i==tab_index){
         stp= tab_uix;
         if(tabinfo.containsKey("tabui")){
          stp = read_json(json_ui,a[1].split(",")[i]);
          }
        }else {
          stp= tab_ui;
           if(tabinfo.containsKey("tabui")){
             stp = read_json(json_ui,a[0].split(",")[i]);
          }
      }

      if(noti_id.length>0){
        stp=stp.replaceAll("{noti_id}", noti_id[i]);
      }
      stp=stp.replaceAll("{tab_name}",arr_caption[i]);
      stp=stp.replaceAll("{tab_img}",arr_icon[i]);



      if(i==0){
        tab_wg.add(Container(child: IgnorePointer(ignoring: true,child:DynamicWidgetBuilder.build(stp.replaceAll("{v}","x"), context, new tclick(skey),skey))));
      }else {
        tab_wg.add(Container(child: IgnorePointer(ignoring: true,child:DynamicWidgetBuilder.build(stp.replaceAll("{v}",""), context, new tclick(skey),skey))));
      }

  }



    tab_control = TabController(
        length: uitab.length, vsync: this);

    tab_control.addListener(_handleTabSelection);

}catch(e){
  print("tabcontrol_initState.error.${e}");
}


    super.initState();



  }
  void _handleTabSelection() {
    if (tab_control.indexIsChanging || tab_control.index != tab_control.previousIndex) {
      setState(() {
        tab_index = tab_control.index;
      });
    }
    on_tabchange(tab_index);
  }




String replace_tab(String s,String sv){
    // vx[xxxx|vb[yyyy|vc[
  try{
    List<String> a,b;
    a=sv.split("|");
    a.forEach((s1) {
      b=s1.split("[");
      s=s.replaceAll("{${b[1]}",b[1]);
    });
  }catch(e){}
  return s;
}
on_tabchange(int index){

if(widget.tab_name==""){
  widget.tab_name=g.null2str(tabinfo["name"]);
}
if(widget.tab_name==""){
  g.tmsg("not_read tabname");
}

try{



  // reset


 // g.tmsg(widget.tab_name+"_tabchange__${index}");


  List<String> noti_id=[];
  if(tabinfo.containsKey("noti_id")){
    noti_id=tabinfo["noti_id"].split(",");
  }


  String tab_ui = read_json(json_ui, widget.tab_name + "_ui");
  String tab_uix = tab_ui;

  if(json_ui.containsKey(widget.tab_name + "_uix")){
    tab_uix=read_json(json_ui, widget.tab_name + "_uix");
  }


  if(tab_uix==""){
    tab_uix=tab_ui;
  }

  if (tab_ui == "") {
    tab_ui = g.tab_ui;
  }




  List<String> a=[];
  // tabui=a,b,c,d|ax,bx,cx,dx
  if(tabinfo.containsKey("tabui")){
     a=tabinfo["tabui"].split("|");
     tab_ui = read_json(json_ui, a[0].split(",")[tab_index_last]);
     tab_uix = read_json(json_ui, a[1].split(",")[index]);
  }




  // last tab
  stp = tab_ui.replaceAll("{tab_name}", arr_caption[tab_index_last]).replaceAll("{tab_img}",arr_icon[tab_index_last]);
  if(noti_id.length>0){
    stp=stp.replaceAll("{noti_id}", noti_id[tab_index_last]);
  }
 /* if(tabinfo.containsKey("v_tab")){
    replace_tab
  }*/




  tab_wg[tab_index_last]=Container(
      key: g.getnewkey(),
      child:
      IgnorePointer(ignoring: true,
          child: DynamicWidgetBuilder.build(
              stp.replaceAll("{v}", ""), context, new tclick(skey), skey)
      ));


  // set current table
  stp = tab_uix.replaceAll("{tab_name}", arr_caption[index]).replaceAll("{tab_img}",arr_icon[index]);
  if(noti_id.length>0){
    stp=stp.replaceAll("{noti_id}", noti_id[index]);
  }


  tab_wg[index] = Container(
      key: g.getnewkey(),
      child:
      IgnorePointer(ignoring: true,
          child: DynamicWidgetBuilder.build(
              stp.replaceAll("{v}", "x"), context, new tclick(skey), skey)
      ));


  if(tab_index_last!=index) {
    try {
      if (nav.length >= index) {
        //g.g_ctx= nav[index].currentState.context;
      }
    } catch (e) {}

    g.nav = "";
    skey = tkeyx[index];
    g.active_key = skey;

    Future.delayed(const Duration(milliseconds: 0), () async {
      xval=g.null2str(tabinfo["t${index}_click"]);
      if(xval!=""){
        if (g.list_ui.containsKey(skey)) {
          if (g.list_ui[skey].containsKey(xval)) {

           // g.tmsg("trigger_click"+xval);
            oj2cmd(g.list_ui[skey][xval], skey);
          }else {
            g.logx("notfound");
          }
        }
      }

    });

   }


  // all case
/*  setState(() {
    tab_index_last=index;
  });*/
  tab_index_last=index;

 // g.alert("tab=${g.null2str(tabinfo["t${index}_cmd"])}");
  try{
    xval=g.null2str(tabinfo["t${index}_cmd"]);
    xval=xval.replaceAll("{k}", skey);
    g.run_cmd=xval;
  }catch(e){}


  }catch(e){
      print_log("on_tabchange.error.${e}");
 }


}


  void event2cmd(String s){
    try{
      switch(s){
        case "hide_bottombar":
          setState(() {
            bottom_bar_height=0;
          });
          break;
        case "show_bottombar":
          setState(() {
            bottom_bar_height=48;
          });
          break;
      }
    }catch(e){}


  }


  @override
  void dispose() {

    try{
      tab_control.dispose();
    }catch(e){}
    super.dispose();
  }


  void f_regisui(String tskey){


    Map<String, dynamic> regisui = new Map<String, dynamic>();
    var allui;
    Widget wd;
    regisui.clear();

    allui =find.byType(gridview_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as gridview_ex).id()]=wd;
    }
    // button
    allui =find.byType(button_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as button_ex).id()]=wd;
    }
    // text
    allui =find.byType(text_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as text_ex).id()]=wd;
    }



    // textfield
    allui =find.byType(textfield_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as textfield_ex).id()]=wd;
    }
    //networkimg
    allui =find.byType(networkimage_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as networkimage_ex).id()]=wd;
    }

    try {
      g.list_ui[tskey]=regisui;
    }catch(e){}


  }


  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child:Text('No')
          ),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child:Text('Yes')
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Tab.Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text(
              'YES', style: TextStyle(fontWeight: FontWeight.bold,color: g.getcolor("#1280C2")),
            ),
          ),
        ],
      ),
    ) ??
        false;
  }


  Widget build(BuildContext context) {

    // setState(() => g.ctx() = context);


    g.cmd.forEach((key, value) {
      tcmd[key]=value;
    });
    //
    bool confirm_exit=false;
    bool auto_exit=true;

/*

     String str_ui= g.readinfo(g.json_ui,"tab_x");
    // str_ui="["+str_ui+"]";

     //print("str_ui:${str_ui}");
    // print("ui_tab:${jsonDecode(str_ui)}");

    str_ui= '''
    [
      {"type":"Text","data":"A"},
      {"type":"Text","data":"A"},
      {"type":"Text","data":"A"},
      {"type":"Text","data":"A"},
      {"type":"Text","data":"A"}
    ]
    ''';
    var json_d=jsonDecode(str_ui);
    var all_wg =  DynamicWidgetBuilder.buildWidgets(json_d, context, new tclick(skey));
   // tab_wg=wg;
*/




    if( tabinfo["auto_exit"] == "false" ){
        auto_exit=false;
    }


    List<Widget> xtab = [];

    if(nav_type=="root"){
      for (var il = 0; il < tabid.length; ++il) {
        xtab.add(Navigator(
          key: nav[il],
          onGenerateRoute: (route) => MaterialPageRoute(
            settings: route,
            builder: (context) => uitab[il],
          ),
        ));
      }
    }else {
      xtab=uitab;
    }

    //xtab=uitab;





    String xui="";

    if(tcmd.containsKey("tpanel")){
       xui= g.read_json(g.json_ui,tcmd["tpanel"]);
      tpanel=DynamicWidgetBuilder.build(
          g.read_json(g.json_ui,tcmd["tpanel"]), context, new tclick(skey),skey);
    }else {

      sval=widget.tab_name+"_tpanel";
      if(g.json_ui[sval]!=null){
        xui= g.read_json(g.json_ui,sval);
        tpanel=DynamicWidgetBuilder.build(
            xui, context, new tclick(skey),skey);
      }else {
        tpanel=Container(width: 0.0,height: 0.0,);
      }

    }

    if(tcmd.containsKey("lpanel")){
      xui= g.read_json(g.json_ui,tcmd["lpanel"]);
      lpanel=Container(
          width:g.screen_w * 0.75,
          child: Drawer(
            child:
            DynamicWidgetBuilder.build(
                xui, context, new tclick(skey),skey),
          ));
    }

    if(tcmd.containsKey("rpanel")){
      xui= g.read_json(g.json_ui,tcmd["rpanel"]);
      rpanel=Container(
          width:g.screen_w * 0.75,
          child: Drawer(
            child:
            DynamicWidgetBuilder.build(
                xui, context, new tclick(skey),skey),
          ));
    }

    if(tcmd.containsKey("bpanel")){
      xui= g.read_json(g.json_ui,tcmd["bpanel"]);
      bpanel= DynamicWidgetBuilder.build(xui, context, new tclick(skey),skey);
    }




    sval=widget.tab_name+"_bpanel";

    if(g.json_ui[sval]!=null){
      xui= g.read_json(g.json_ui,sval);
      bpanel=DynamicWidgetBuilder.build(
          xui, context, new tclick(skey),skey);


    }


    List<Widget> action=[Text("")];
    if(tcmd.containsKey("appbar_text")){

      appbar= new AppBar(
        elevation: 0.0,
        backgroundColor: g.getcolor(g.main_color),
        title: Text(tcmd["appbar_text"]),
        actions:action,

      );
    }

// tabcontroller
    var tabscroll=null;
    if(g.null2str(tcmd["tab_swipe"])=="false" || g.null2str(tabinfo["tab_swipe"])=="false"){
      tabscroll=NeverScrollableScrollPhysics();
    }else {
      tabscroll=ClampingScrollPhysics();
    }

    var ctime;
    var t_tab=null;
    var b_tab=null;

    t_tab = PreferredSize(preferredSize: const Size.fromHeight(0.0),child: Container(width: 0,height: 0));
    b_tab = PreferredSize(preferredSize: const Size.fromHeight(0.0),child: Container(width: 0,height: 0));

    var ui_tabbar= TabBar(
      controller: tab_control,
        onTap: (int index){
          on_tabchange(index);
        },
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: g.cdbl(tabinfo["border_height"], 0.00001),color: tabinfo["border_active_color"]!=null?g.getcolor(tabinfo["border_active_color"]):Colors.transparent),
            insets: EdgeInsets.symmetric(horizontal:g.cdbl(tabinfo["tabbar_padding"], 0.0))
        ),
       /* indicator: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            color: tabinfo["select_background_color"]!=null?g.getcolor(tabinfo["select_background_color"]):Colors.transparent,
        ),*/
        indicatorWeight: 0.000001,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
        unselectedLabelColor: g.getcolor(g.strx(tabinfo["labelcolor"],"#000000")),
        labelColor: g.getcolor(g.strx(tabinfo["labelcolor_select"],"#3F51B5")),
        labelStyle: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold),  //For Selected tab
        unselectedLabelStyle: TextStyle(fontSize:10.0,fontWeight: FontWeight.bold), //For Un-selected Tabs
        tabs: tab_wg
    );

    if(tabinfo.containsKey("tab_height")){
      bottom_bar_height=g.cdbl(tabinfo["tab_height"],48);
      tab_height=g.cdbl(tabinfo["tab_height"],48);
    }

     if(g.null2str(tabinfo["tab_type"])=="t"){
        t_tab=ui_tabbar;
        bottom_bar_height=0;
      }else {
       b_tab=ui_tabbar;


       /* b_tab=Material(
            color: g.getcolor(g.strx(tabinfo["tab_color"], "#FFFFFF")),
            child:  Container(
              height:bottom_bar_height,
              child:
              ui_tabbar,
            )
        );*/
      }


     var vcolor=Colors.transparent;
    if(tabinfo.containsKey("tab_border_color")){
      vcolor=parseHexColor(tabinfo['tab_border_color']);
    }
    var vborder_radius=new BorderRadiusDirectional.only(
      topStart   :  Radius.circular(0.0),
      topEnd  :  Radius.circular(0.0),
      bottomStart:  Radius.circular(0.0),
      bottomEnd: Radius.circular(0.0),
    );

    if(tabinfo.containsKey("border_box")){
      List<String> r=tabinfo["border_box"].toString().split(",");

      vborder_radius=new BorderRadiusDirectional.only(
        topStart   :  Radius.circular(5.0),
        topEnd  :  Radius.circular(5.0),
        bottomStart:  Radius.circular(5.0),
        bottomEnd: Radius.circular(5.0),
      );

    }


   var vdecoration = BoxDecoration(
        color: Colors.transparent,
        borderRadius: vborder_radius
    );

    var ui_tab_box;
    var vmargin=  EdgeInsets.fromLTRB(0,0,0,0);
    var vpadding=  EdgeInsets.fromLTRB(0,0,0,0);



    if(tabinfo.containsKey("tab_margin")){
      vmargin=parseEdgeInsetsGeometry(tabinfo['tab_margin']);
    }
    if(tabinfo.containsKey("tab_padding")){
      vpadding=parseEdgeInsetsGeometry(tabinfo['tab_padding']);
    }



    if(tabinfo.containsKey("tab_bottom_box")){
      ui_tab_box=DynamicWidgetBuilder.build(g.hashmap2json(tabinfo["tab_bottom_box"]), context, new tclick(skey),skey);
    }else {
      ui_tab_box=Container(width: 0.0,height: 0.0,);
    }



       tabpage=WillPopScope(
          onWillPop: () async {

            if(Navigator.canPop(g.ctx())){
              f_nav_exit("");
            }else {
              DateTime now = DateTime.now();
              if (currentBackPressTime == null ||
                  now.difference(currentBackPressTime) > Duration(seconds: 2)) {
                currentBackPressTime = now;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Press Back Button Again to Exit')));
                return Future.value(false);
              }
              close_app();
            }

          }
          ,
          child:
          Scaffold(
              body:
              SafeArea(
                  child:
                  g.null2str(tabinfo["tab_style"])=="float"?
                  Stack(
                      children:[
                        Column (children:
                        [
                          tpanel,
                          Expanded (child:
                          DefaultTabController(
                            length: uitab.length,
                            child:
                            Column (children:
                            [
                              Expanded (child:
                              Scaffold(
                                appBar:
                                PreferredSize(
                                    preferredSize: Size.fromHeight(tab_height), // here the desired height
                                    child:Container(
                                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                                        child:t_tab)
                                )
                                ,
                                drawer: lpanel,
                                endDrawer: rpanel,
                                body:
                                TabBarView(
                                  controller: tab_control,
                                  physics: tabscroll,
                                  children: xtab,
                                ),

                              )),
                            ]
                            ),
                          )
                          )
                        ])
                        ,

                        Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            //you can use "right" and "bottom" too
                            child:

                            Stack(
                              children:[
                                ui_tab_box,
                                Container(
                                  decoration: vdecoration,
                                  margin: vmargin,
                                  padding: vpadding,
                                  height:bottom_bar_height,
                                  child: ui_tabbar,
                                )
                              ])

                        )
                      ]):


                  Column (children:
                  [
                    tpanel,
                    Expanded (child:
                    DefaultTabController(
                      length: uitab.length,
                      child:
                      Column (children:
                      [
                        Expanded (child:
                        Scaffold(
                          extendBodyBehindAppBar: true,
                          extendBody: true,

                          appBar:
                          PreferredSize(
                              preferredSize: Size.fromHeight(tab_height),
                              child:Container(
                                  padding: EdgeInsets.fromLTRB(0,0,0,0),
                                  child:t_tab)
                          )
                          ,
                          drawer: lpanel,
                          endDrawer: rpanel,
                          body:
                          TabBarView(
                            controller: tab_control,
                            physics: tabscroll,
                            children: xtab,
                          ),
                           bottomNavigationBar:Container(
                               margin:  tabinfo.containsKey("margin")?  parseEdgeInsetsGeometry(tabinfo['margin']):EdgeInsets.fromLTRB(0,0,0,0),
                                height:bottom_bar_height,
                                color:tabinfo.containsKey("tabbox_fill_color")? g.getcolor(tabinfo["tabbox_fill_color"]):Colors.transparent,
                                child:
                                    Column(children: [
                                      Container(height:1.0,color:tabinfo.containsKey("tabbox_topcolor")? g.getcolor(tabinfo["tabbox_topcolor"]):Colors.transparent),
                                      Container(
                                          decoration: BoxDecoration(
                                            color:tabinfo.containsKey("tabbox_color")? g.getcolor(tabinfo["tabbox_color"]):Colors.transparent,
                                            border: Border.all(
                                              color:tabinfo.containsKey("tabbox_border_color")? g.getcolor(tabinfo["tabbox_border_color"]):Colors.transparent,
                                              width: tabinfo.containsKey("tabbox_border_width")? tabinfo["tabbox_border_width"]:0.0,
                                            ),
                                            borderRadius:
                                            tabinfo.containsKey("tabbox_radius")? BorderRadius.circular(tabinfo["tabbox_radius"]):BorderRadius.circular(10),
                                          ),
                                          child: b_tab
                                      )
                                    ])

                          ),
                        )),
                      ]),
                    )
                    ),
                  ])




              )

          ));


       return tabpage;




  }

}


class loadpage extends StatefulWidget {


  final String page_name;
  final String page_ui;
  final String page_key;
  final Map<String, dynamic> q;
  final int time_waitui;
  final int tabindex;
  final bool is_tab;

  bool showappbar=true;


  loadpage(this.page_name,this.is_tab,this.page_ui,this.page_key,this.showappbar, this.q, this.time_waitui,this.tabindex);
  @override
  loadpage_state createState() => loadpage_state(page_ui);

}

class loadpage_state extends State<loadpage> with AutomaticKeepAliveClientMixin,AfterLayoutMixin<loadpage> {

  //FirebaseMessaging firebaseMessaging;// = FirebaseMessaging();
 // String message;
  // String channelId = "1000";
  // String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
  // String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";


//bluetoothPrint

  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  bool bt_connected = false;
  BluetoothDevice bt_device;
  String bt_tips = 'no device connect';

  //------------------------


  String sval="";
  BuildContext bc;
  bool isloadpage=false;
  bool first_cmd=true;

  static String this_run_cmd = "";
  String page_ui="";

  loadpage_state(this.page_ui);

  @override
  bool get wantKeepAlive => true;



  read_navinfo(){
    if(g.cmdval("show_tbar")!=""){
      widget.showappbar=(g.cmdval("show_tbar")=="true");
    }
    if(g.null2str(g.c["show_nav"])=="false"){
      widget.showappbar=false;
    }
    if(g.null2str(info["show_nav"])=="false"){
      widget.showappbar=false;
    }
    if(widget.is_tab){
      widget.showappbar=false;
    }

  }
  @override
  void initState() {

    g.active_key=widget.page_key;


   /* try{
      SystemChannels.lifecycle.setMessageHandler((msg){
        g.tmsg('page_status $msg');
        //if(msg==AppLifecycleState.resumed.toString())setState((){});

      });
    }catch(e){}*/


    read_navinfo();

    if(flutterJs==null){
      flutterJs = getJavascriptRuntime();
    }


    try{

      g.panel_control[widget.page_key]=new PanelController();
      List<String> a;

      try {



        //chatid,a,b
        if(g.cmdval("mix_code")!=""){
          List<String> a=g.cmdval("mix_code").split(",");
          if(a.length>=3){

            String gval="";
            String aval=a[1];
            String bval=a[2];

            if(g.cint(aval,0)<=g.cint(bval,0)){
              gval=aval+"x"+bval;
            }else {
              gval=bval+"x"+aval;
            }
            if(a.length>=4){
              gval=a[3]+gval+a[3];
            }


            g.papp[a[0]]=gval;
            g.send_bind[a[0]]=gval;
            g.c[a[0]]=gval;
          }

        }}catch(e){
        tmsg("initState.error."+e.toString());
      }




      //if(page_ui==""){
        //page_ui = g.read_json(g.json_ui, widget.page_name);
     // }

      page_ui=page_ui.replaceAll("{x.login_id}", g.login_id);
      page_ui=page_ui.replaceAll("{x.new_guid}", g.genkey());
      if(is_bottom_sheet){
        page_ui=page_ui.replaceAll('"id":"init0"', '"id":"{k}init0"');
      }
      page_ui=page_ui.replaceAll('"click_event":"','"click_event":"#k={k};');
      page_ui=page_ui.replaceAll("{k}", g.active_key);
      page_ui=page_ui.replaceAll("{?k}", g.active_key);
      page_ui=page_ui.replaceAll("{tab_index}",widget.tabindex.toString());
      page_ui=page_ui.replaceAll('"vid":"','"id":"');

      page_ui=g.page_replace(page_ui,widget.page_key,"page_ui");



      logx("page_ui:${page_ui}");




      // d.rowa   replace  loop
      if(g.null2str(g.c["gen_datarow"])!=""){
        List<String> b=g.null2str(g.c["gen_datarow"]).split(",");
        b.forEach((s1) {

          // d.row
          List<String> a=g.null2str(s1).split(".");
          String trow =page_replace(g.read_json(g.json_ui,a[1]),widget.page_key,"gen_datarow");
          String s="";
          String srow="";
          List allrow = jsonDecode(g.jsonx)[a[0]] as List;
          try {
            if (allrow.length > 0) {
              allrow.forEach((h) {
                srow=trow;
                h.forEach((key, value) {
                  srow = srow.replaceAll("{" + key + "}", g.null2str(value));
                });
                s += srow + ",";
              });
            }
          }catch(e){
            print("s_error:${e}");
          }
          s=g.rcut(s);
          page_ui= page_ui.replaceAll("{*${a[1]}}",s);
          print("rep_  {*${a[1]}}"+"   =  ${s}");
          //{*row1}
        });
      }




        if(g.null2str(g.c["loopx"])!=""){

        List<String> b=g.null2str(g.c["loopx"]).split(",");
        b.forEach((s1) {
        // d.row
          List<String> a=g.null2str(s1).split(".");
          String trow =page_replace(g.read_json(g.json_ui,a[1]),widget.page_key,"loopx");
          String s="";
          String srow="";

          List allrow = jsonDecode(g.jsonx)[a[0]] as List;

          try {
            if (allrow.length > 0) {
              allrow.forEach((h) {
                srow=trow;
                h.forEach((key, value) {
                  srow = srow.replaceAll("{" + key + "}", g.null2str(value));
                });
                s += srow + ",";
              });
            }
          }catch(e){
            print("s_error:${e}");
          }
          s=g.rcut(s);
          print("s=${s}");
          page_ui= page_ui.replaceAll("{*}",s);
        });
      }






      g.regiskey(widget.page_key);
      bc=context;


      //
      // if(cmdval("cfg_regis_firebase")=="true"){
      //     cfg_regis_firebase();
      // }
      print("loadpage_init_ok");

    }catch(e){
      print("loadpage_init_error:${e.toString()}");
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      load_page_finish();
    });


    super.initState();
  }


  load_page_finish(){
    //initBluetooth();
  }


  Future<void> initBluetooth() async {



    bluetoothPrint.startScan(timeout: Duration(seconds: 4));
    bool isConnected=await bluetoothPrint.isConnected??false;
    bluetoothPrint.state.listen((state) {
      print('******************* cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            bt_connected = true;
            bt_tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            bt_connected = false;
            bt_tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if(isConnected) {
      setState(() {
        bt_connected=true;
      });
    }
  }


  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.black26
            ),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.green
            ),
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }






  @override
  void dispose() {
    g.close_page(widget.page_key);
    super.dispose();
  }


  getappbar() {
    // List<Widget> action=[Text("action_click")];
    String page_name = g.app_name;
    if (g.cmdval("page_name") != "") {
      page_name = g.cmdval("page_name");
    }
    if (g.cmdval("page_title") != "") {
      page_name = g.cmdval("page_title");
    }

    var r_action = null;
    var l_action = null;

    var title = null;
    title = Text(page_name);
    String sui = "";
    if (g.cmd.containsKey("r_action")) {
      sui = g.read_json(g.json_ui, g.cmdval("r_action"));
      r_action = DynamicWidgetBuilder.buildWidgets(
          jsonDecode(sui), context, new tclick(widget.page_key));
    }
    if (g.cmd.containsKey("l_action")) {
      sui = g.read_json(g.json_ui, g.cmdval("l_action"));
      l_action = DynamicWidgetBuilder.buildWidgets(
          jsonDecode(sui), context, new tclick(widget.page_key));
    }
    if (g.cmd.containsKey("c_action")) {
      sui = g.read_json(g.json_ui, g.cmdval("c_action"));
      title = DynamicWidgetBuilder.buildWidgets(
          jsonDecode(sui), context, new tclick(widget.page_key));
    }

    if (widget.showappbar) {
      return AppBar(
        elevation: 0.0,
        backgroundColor: g.getcolor(g.main_color),
        iconTheme: IconThemeData(color: Colors.white),
        leading: l_action,
        titleSpacing: 0,
        title: title,
        actions: r_action,
      );
    } else {
      return null;
    }
  }

//loadpage.build
  @override
  Widget build(BuildContext context) {

 try {




   //g.tmsg("loadpage_build:${widget.page_key}");
   if (g.screen_h == 0.0) {
     g.read_screen(g.ctx());
   }

   read_navinfo();



   bool confirm_exit = false;

   var lpanel = null;
   var rpanel = null;
   var bpanel = null;
   var vcolor = Colors.white;
   var ctime;
   String xui="";



   if (g.c.containsKey("lpanel")) {
      xui = g.read_json(g.json_ui, g.null2str(g.c["lpanel"]));
      if(xui!=""){
        lpanel =
            SafeArea(child: Container(
                width: g.screen_w * 0.75,
                child: Drawer(
                  child:
                  DynamicWidgetBuilder.build(
                      xui, context, new tclick(widget.page_key), widget.page_key),
                )));
      }
   }

   // auto by pageid_lpanel;
   if(g.json_ui.containsKey(widget.page_name+"_lpanel")){
      xui = g.read_json(g.json_ui,widget.page_name+"_lpanel");
      if(xui!=""){
       lpanel =
           SafeArea(child: Container(
               width: g.screen_w * 0.75,
               child: Drawer(
                 child:
                 DynamicWidgetBuilder.build(
                     xui, context, new tclick(widget.page_key), widget.page_key),
               )));
      }
   }



   if (g.c.containsKey("rpanel")) {
     xui = g.read_json(g.json_ui, g.null2str(g.c["rpanel"]));
     if(xui!=""){
       rpanel =
           SafeArea(child: Container(
               width: g.screen_w * 0.75,
               child: Drawer(
                 child:
                 DynamicWidgetBuilder.build(
                     xui, context, new tclick(widget.page_key), widget.page_key),
               )));
     }
   }
   if(g.json_ui.containsKey(widget.page_name+"_rpanel")){
     xui = g.read_json(g.json_ui,widget.page_name+"_rpanel");
     if(xui!=""){
       rpanel =
           SafeArea(child: Container(
               width: g.screen_w * 0.75,
               child: Drawer(
                 child:
                 DynamicWidgetBuilder.build(
                     xui, context, new tclick(widget.page_key), widget.page_key),
               )));
     }
   }




   if (g.c.containsKey("bpanel")) {
     xui = g.read_json(g.json_ui, g.null2str(g.c["bpanel"]));
     if(xui!=""){
       bpanel = DynamicWidgetBuilder.build(xui, context, new tclick(widget.page_key), widget.page_key);
     }
   }


   print("loadpage_build=${tcmd}  : ${g.cmd}");


 sval=widget.page_name+"_bpanel";

  if(json_ui.containsKey(sval)){
    try {
      xui = g.read_json(g.json_ui, sval);
      if (xui != "") {
        bpanel = DynamicWidgetBuilder.build(
            xui, context, new tclick(widget.page_key), widget.page_key);
      }
    }catch(e){
      print("find b_panel.error. ${e}");
    }
  }




   bool is_disble = false; // defalut close
   if (g.null2str(g.c["swipe_back"]) == "false") {
     is_disble = true; // open
   }

   if (widget.is_tab) {
     is_disble = true;
   }


   // main.loadpage

   var swipe = DismissiblePageDismissDirection.startToEnd;

   String swipedir=g.null2str(g.c["swipetype"]);
   if(g.c.containsKey("swipe_dir")){
     swipedir=g.null2str(g.c["swipe_dir"]);
   }


   switch (swipedir) {
     case "s":
       swipe = DismissiblePageDismissDirection.startToEnd;
       break;
     case "e":
       swipe = DismissiblePageDismissDirection.endToStart;
       break;
     case "d":
       swipe = DismissiblePageDismissDirection.down;
       break;
     case "u":
       swipe = DismissiblePageDismissDirection.up;
       break;
     case "h":
       swipe = DismissiblePageDismissDirection.horizontal;
       break;
     case "v":
       swipe = DismissiblePageDismissDirection.vertical;
       break;
     case "m":
       swipe = DismissiblePageDismissDirection.multi;
       break;

   }




   if (g.c.containsKey("page_background")) {
     if (g.null2str(g.c["page_background"]) == "no") {
       vcolor = Colors.transparent;
     } else {
       vcolor = g.getcolor(g.c["page_background"]);
     }
   }


   switch (g.null2str(g.c["swipe2back"])) {
     case "a":
     case "b":
       return
           DismissiblePage(
         onDismissed: () {
           Navigator.of(context).pop(g.q);
         },
         dragSensitivity: 1.0,
         minScale: 0.97,
         maxTransformValue: 0.1,
         backgroundColor:g.c.containsKey("page_bkcolor")? g.getcolor(g.c["page_bkcolor"]):g.getcolor("#D3D3D3"),
         disabled: is_disble,
         startingOpacity:1,
         minRadius: 0.0,
         maxRadius: 0.0,
        // reverseDuration: const Duration(milliseconds: 200),
         direction: swipe,
         isFullScreen: true,
         child: WillPopScope(
           onWillPop: () async {

             if(Navigator.canPop(g.ctx())){
               f_nav_exit("");
             }else {
               DateTime now = DateTime.now();
               if (currentBackPressTime == null ||
                   now.difference(currentBackPressTime) > Duration(seconds: 2)) {
                 currentBackPressTime = now;
                 ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('Press Back Button Again to Exit')));
                 return Future.value(false);
               }
               close_app();
             }


             /* g.nav="back";
           //  await onexit();
             if (confirm_exit) {
               DateTime now = DateTime.now();
               if (ctime == null ||
                   now.difference(ctime) > Duration(seconds: 2)) {
                 //add duration of press gap
                 ctime = now;
                 *//*ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Press Back Button Again to Exit'))
                  );*//*
                 g.tmsg("Press Back Button Again to Exit");

                 //scaffold message, you can show Toast message too.
                 return Future.value(false);
               }

               return Future.value(true);
             } else {
               return Future.value(true);
             }*/
           },
           child:
           Scaffold(
             backgroundColor: vcolor,
             appBar: getappbar(),
             drawer: lpanel,
             endDrawer: rpanel,
             body: getbody(bpanel),
           ),
         ),
       );
       break;
     case "x":
       return Dismissible(
         direction: DismissDirection.horizontal,
         key: Key(g.newkey()),
         onDismissed: (_) => Navigator.of(context).pop(g.q),
         child: Scaffold(
           appBar: getappbar(),
           backgroundColor: vcolor,
           drawer: lpanel,
           endDrawer: rpanel,
           body: getbody(bpanel),
         ),
       );
       break;

     default :


       // mainloadpage


       return


         WillPopScope(

           /*
             onWillPop: () async {
               if(Navigator.canPop(g.ctx())){
                 f_nav_exit("");
               }else {
                 DateTime now = DateTime.now();
                 if (currentBackPressTime == null ||
                     now.difference(currentBackPressTime) > Duration(seconds: 2)) {
                   currentBackPressTime = now;
                   ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('Press Back Button Again to Exit')));
                       return Future.value(false);
                 }
                 close_app();
               }
             },
             */
             onWillPop: ()=> nav_exit(context),
             child:
             Scaffold(
               backgroundColor: vcolor,
               appBar: getappbar(),
               drawer: lpanel,
               endDrawer: rpanel,
               body: getbody(bpanel),
             ));


       break;
   }

 }catch(e){
   print("loadpage_build.error.${e}");
 }

}


  Future<bool> nav_exit(BuildContext context) async{




    if(webview_control != null){
      if (await webview_control.canGoBack()) {
        webview_control.goBack();
      }
      else {
        if(Navigator.canPop(g.ctx())){
          f_nav_exit("");
        }else {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Press Back Button Again to Exit')));
            return Future.value(false);
          }
          close_app();
        }
      }

    }else {
      if(Navigator.canPop(g.ctx())){
        f_nav_exit("");
      }else {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Press Back Button Again to Exit')));
          return Future.value(false);
        }
        close_app();
      }

    }



  }

onexit() async {
    try{
      if(g.list_ui.containsKey(widget.page_key)){
        if(g.list_ui[widget.page_key].containsKey("on_exit")){
          await ojclick(widget.page_key, "on_exit");
        }
      }
    }catch(e){}
}


  getbody(bpanel) {


    print("bpanel=${bpanel}");

    if(bpanel==null){
      return
        SafeArea(
         child:
            FutureBuilder<Widget>(
              future: _buildWidget(bc),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                // g.g_ctx = context;
                if (snapshot.hasError) {
                  //msgbox(gctx,snapshot.error);
                  bmsg("snapshot.error:${snapshot.error}");
                  print("snapshot.error:${snapshot.error}");

                }
                if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                }
                return snapshot.hasData
                    ? SizedBox.expand(
                  child: snapshot.data,
                )
                    : Text("");
              },
            )
        );

    }else {

      double min_h=g.cdbl(g.cmdval("min_h"),0.3);
      double max_h=g.cdbl(g.cmdval("max_h"),0.8);


      var xborder =BorderRadius.all(Radius.circular(0.0));


      if(g.cmdval("border_box")!=""){
        List<String>  r= g.cmdval("border_box").split(",");
        xborder = new BorderRadius.only(
          topLeft: Radius.circular(g.cdbl(r[0], 0.0)),
          topRight: Radius.circular(g.cdbl(r[1], 0.0)),
          bottomLeft: Radius.circular(g.cdbl(r[2], 0.0)),
          bottomRight: Radius.circular(g.cdbl(r[3], 0.0)),
        );
      }


      return
        SlidingUpPanel(
          renderPanelSheet: false,
          borderRadius:xborder,
          color: Colors.transparent,
          defaultPanelState:PanelState.CLOSED,
          backdropEnabled:true,
          backdropOpacity:0.3,
          controller:panel_control[widget.page_key],
          minHeight: MediaQuery.of(context).size.height*min_h,
          maxHeight: MediaQuery.of(context).size.height*max_h,
          panel: bpanel,
          body: SafeArea(
              child:
              FutureBuilder<Widget>(
                future: _buildWidget(bc),
                builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  // g.g_ctx = context;
                  if (snapshot.hasError) {
                    msgbox(gctx,snapshot.error);
                  }
                  if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                  }
                  return snapshot.hasData
                      ? SizedBox.expand(
                    child: snapshot.data,
                  )
                      : Text("");
                },
              )
          ),
        );
    }













   /* return
      SafeArea(
        child:
        SlidingUpPanel(
          controller:  g.gpc[widget.skey],
          minHeight: 0.0,
          maxHeight: 200.0,
          backdropEnabled: true,
          panel:Container(),
          body: FutureBuilder<Widget>(
            future: _buildWidget(bc),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              // g.g_ctx = context;
              if (snapshot.hasError) {
                msgbox(gctx,snapshot.error);
              }
              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
              }
              return snapshot.hasData
                  ? SizedBox.expand(
                child: snapshot.data,
              )
                  : Text("");
            },
          )
        ),
      );*/



  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text(
              'YES', style: TextStyle(fontWeight: FontWeight.bold,color: g.getcolor("#1280C2")),
            ),
          ),
        ],
      ),
    ) ??
        false;
  }



loadpage_success(String page_key) async{
 try {
   // reset

   //g.alert("${skey}_run_${g.getrunseq()}  ${g.init_run}");


   //g.active_key=page_key;

   g.last_cmd = "";
   g.this_skey == page_key;
   String gval = "";


   //Future.delayed(Duration(milliseconds: 0), () {
     //print("loadpage_succes_${skey}");

     iscall_intent = false;
     g.call_navtime = -1;
     regis_eventx(page_key);

     int time_init0 = 0;
     if (g.c.containsKey("time_init")) {
       time_init0 = g.cint(g.c["time_init"], 0);
     }


     Future.delayed(Duration(milliseconds: time_init0), () async {
       bool isfoundui = true;
       bool isfoundinit0 = false;


       try {
         if (g.init_run) {


           isfoundui =  await f_readuicmd(page_key, "");

         //  g.alert("loadpage_success");


           String kcmd = g.null2str(g.c["kcmd"]);
           //  List<String> a="init0,run1,run2,run3,run4,run5".split(",");



           List<String> a = "init0".split(",");

           if(g.cmdval("page_init")!=""){
             a =g.cmdval("page_init").split(",");
           }
           String vid = "";
           if (g.null2str(g.cmd["run_init0"]) == "false") {
             a = [];
           }



           if (g.cmd.containsKey("init_run")) {
             a.clear();
             if (g.cmdval("init_run") != "false") {
               a = g.cmdval("init_run").split(",");
             }
           }



         //  g.tmsg("a=${a}");

           print("kcmd=${kcmd}");

           if (a.length > 0) {
             a.forEach((str) {
               if (str == "init0") {
                 g.init0_req = true;
               }
               str = kcmd + str;
               vid = str;
               if (!is_bottom_sheet) {
                 if (g.list_ui[page_key].containsKey(vid)) {
                   oj2cmd(g.list_ui[page_key][vid], page_key);
                   isfoundinit0 = true;
                 }
               }

               vid = page_key + "." + str;
               if (!isfoundinit0) {
                 if (g.list_ui[page_key].containsKey(vid)) {
                   oj2cmd(g.list_ui[page_key][vid], page_key);
                   isfoundinit0 = true;
                   //tmsg("call_${vid}");
                 }
               }
             });
           }
         }

         g.init_run = true;

         if (g.c.containsKey("init_cmd")) {
           gval = g.null2str(g.c["init_cmd"]);
           gval = g.null2str(g.info[gval]);
           if (gval != "") {
             cmd(gval, page_key, true);
           }
         }
         if (!isfoundinit0) {
          // alert("not_found_init0=${isfoundinit0}"+g.list_ui[skey].toString());
         }
         if (g.isloadprofile) {
           g.isloadprofile = false;
           List lx = g.info["profile_field"].toString().split(",");
           lx.forEach((str) {
             //  g.readkey(str).then((value){
             //   g.kk[str]=value;
             // });
           });
         }

         loadpage_waitcmd(page_key);
         loadpage_jobcmd(page_key);
       } catch (e) {}
     });
  // });

   /* Future.delayed(Duration(milliseconds: 1000), () {
      g.tmsg("call load app");
      f_readuicmd(skey,"nocmd");
    });*/

 }catch(e){
   g.alert("loadpage.error.${e}");
 }

  }

  onclick(){
    msgbox(gctx,"onclick");
  }


  Future<Widget> _buildWidget(BuildContext context) async {

    //tmsg("createui_"+widget.skey);

    //g.allbc[widget.skey]=context;
    await loaduix();


    /*if(g.send_callapi != ""){

      await loaduix();
    }else {
      //#recheck
      print("case 22222222222 ");
      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      if(page_ui==""){
        //alert("not_found_ui");
      }

      // g.restartapp();
      try  {
        if(g.send_bind.length>0){
          g.send_bind.forEach((k, v) {
            page_ui=page_ui.replaceAll("{s."+k+"}", v);
          });
        }
      }catch(e){}

    }*/




    return DynamicWidgetBuilder.build(
        page_ui, context, new tclick(widget.page_key),widget.page_key);



  }



  Future loaduix() async {
    try {
      final rx = await g.http_get(g.geturl(g.send_callapi));
      if (rx.statusCode == 200) {
        g.jsonx = rx.body;
        try {
          List allrow = jsonDecode(g.jsonx)["d"] as List;
          if (allrow.length > 0) {
            Map<String, dynamic> h = allrow[0] as Map<String, dynamic>;
            // if(h.containsKey("l")){
            //   sui=g.null2str(h["l"]);
            // }
            h.forEach((key, value) {
              page_ui = page_ui.replaceAll("{" + key + "}", g.null2str(value));
            });
          }
        } catch (e) {}
        await Future.delayed(Duration(milliseconds: widget.time_waitui), () {});
        g.send_callapi = "";
        if (g.send_bind.length > 0) {
          g.send_bind.forEach((k, v) {
            page_ui = page_ui.replaceAll("{s." + k + "}", v);
          });
        }
      }

    }catch(e){}

  }

  run_lodpage_finish(){

    try{
      int time_init0=g.time_init0;
      if(g.cmdval("time_init0")!=""){
        time_init0=g.cint(g.cmdval("time_init0"),0);
      }
      time_init0=100;
      Future.delayed(Duration(milliseconds: time_init0), () {
        if(g.nav!="back"){
          loadpage_success(widget.page_key);
        }
      });
      g.isrun=false;
    }catch(e){}
  }
  @override
  void afterFirstLayout(BuildContext context) {
     run_lodpage_finish();

  }



}


class tclick implements ClickListener {
  String skey;
  tclick(this.skey);

  @override
  void onClicked(String event) {
    cmd(event,skey,false);
  }







/*
  _getIPAddress() async {
    String url = 'https://httpbin.org/ip';
    var httpClient = createHttpClient();
    var response = await httpClient.read(url);
    Map data = JSON.decode(response);
    String ip = data['origin'];
  }

*/


}


getojid(String id){
  return (find.byKey(Key(id))).evaluate().single.widget;
}

bool showdialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      g.iscomfirm=false;
      Navigator.of(context, rootNavigator: true)
          .pop(false); // dismisses only the dialog and returns false
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {
      g.iscomfirm=true;
      Navigator.of(context, rootNavigator: true)
          .pop(true); // dismisses only the dialog and returns false
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}









dalert(String s){
  msg(g.getrunseq()+"."+s);
}
alert(String s){
  msg(s);
}

Future input_dialog() async {


  String teamName = '';
  var board_type=getkeyboardtype(g.cmdval("t_keyboard_type"));
  return showDialog(
    context: g.ctx(),
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(g.strx(g.cmdval("t_title"), "?")),
        content: new Row(
          children: [
            new Expanded(
                child: new TextField(
                  keyboardType:board_type(),
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: "", hintText: ""),
                  onChanged: (value) {
                    teamName = value;
                    g.plink["input_value"]=value;
                    g.pvar["input_data"]=value;
                  },
                ))
          ],
        ),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(teamName);
            },
          ),
        ],
      );
    },
  );


}

regis_eventx(String skey){
  try{
    g.event_bus.stream.listen((data) {
      ojclick(skey, "event_bus");
    });
  }catch(e){}

}

void mqtt_connected() {
  //alert('mqtt_connected');
  print("mqtt_connected");
}

// unconnected
void mqtt_disconnected() {
  //alert('mqtt_disconnected');
  print("mqtt_disconnected");

}

// subscribe to topic succeeded
void mqtt_onSubscribed(String topic) {
  // alert('mqtt_onSubscribed: $topic');
}

// subscribe to topic failed
void mqtt_onSubscribeFail(String topic) {
  // alert('mqtt_onSubscribeFail $topic');
}

// unsubscribe succeeded
void mqtt_onUnsubscribed(String topic) {
  //alert('mqtt_onUnsubscribed: $topic');
}

// PING response received
void mqtt_pong() {
  // alert('mqtt_pong');
}
void f_mqtt_subx(){


  /*

  List<String> a;
  List<String> b;



  if(g.cmd.containsKey("mqtt_unsub")){
    a=g.cmdval("mqtt_unsub").split(",");
    a.forEach((sx) {
      mqtt_client.unsubscribe(sx);
    });
  }
  // mqtt_subkey=key1[path1,key2[path2
  if(g.cmd.containsKey("mqtt_subkey")){
    a=g.cmdval("mqtt_subkey").split(",");
    a.forEach((sx) {
      b=sx.split("[");
      if(g.k_data.containsKey(b[0])){
        mqtt_client.unsubscribe(g.k_data[b[0]]);
      }
      g.k_data[b[0]]=b[1];
      mqtt_client.subscribe(b[1], MqttQos.atLeastOnce);
    });
  }
  if(g.cmd.containsKey("mqtt_sub")){
    a=g.cmdval("mqtt_sub").split(",");
    a.forEach((sx) {
      mqtt_client.subscribe(sx, MqttQos.atLeastOnce);
    });
  }

  */


}
void f_mqtt_sub(){

  gmqtt_client.subscribe(g.cmdval("f_mqtt_sub"), MqttQos.atLeastOnce);
}
void f_mqtt_unsub(){

  List<String> a=g.cmdval("f_mqtt_unsub").split(",");
  a.forEach((s1) {
    gmqtt_client.unsubscribe(s1);
  });

}
Future<void> f_mqtt_pub() async {
  if (gmqtt_client.connectionStatus.state != MqttConnectionState.connected) {
    await gmqtt_client.doAutoReconnect();
  }

  try{

    var pubTopic = g.cmdval("path");
    final builder = MqttClientPayloadBuilder();

    List <String> a,b;
    Map<String, dynamic> h = new Map<String, dynamic>();  // language
    String pub_data=g.cmdval("pub_data");

    String sval="";

    if(g.cmd.containsKey("pub_pr")){
      a=g.cmdval("pub_pr").split(",");
      a.forEach((s1) {
        b=s1.split("[");
        if(b.length>=2){

          sval=b[1];
          if(sval=="{systemdate}"){
            sval=DateTime.now().toString();
          }
          h[b[0]]=b[1];
        }
      });
      if(g.cmd.containsKey("pub_q")){
        selectx(g.null2str(g.cmd["pub_q"]),g.active_key);
        g.q.forEach((key, value) {
          h[key]=value;
        });

      }

      pub_data  = jsonEncode(h);
    }

    if(g.cmdval("_debug")=="true"){
      g.bmsg("${pubTopic} : ${pub_data}");
    }

    builder.addUTF8String( pub_data);
    gmqtt_client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload);

  }catch(e){
    alert("mqtt_pub.error."+e.toString());
  }

}
void f_mqtt_discconnect(){
  try{
    gmqtt_client.disconnect();
  }catch(e){}

}


void f_firebase_login(String skey) async{

  if(g.regis_firebase){

    try {

      String u_email=g.cmdval("u_email");
      String u_password=g.cmdval("u_password");

      UserCredential u = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: u_email,
          password: u_password
      );

      FBCloudStore.instanace.takeUserInformationFromFBDB().then((documents) {
        if (documents.length > 0) {
          FBCloudStore.instanace.saveUserDataToFirebaseDatabase(
              documents[0]['email'] ?? '',
              documents[0]['userId'],
              documents[0]['name'],
              g.null2str(documents[0]['intro']),
              "https://preloved.com/img/u.png").then((userData){
          });
        }else {
        }
      });

      ojclick(skey, g.cmdval("y_click"));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        alert('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        alert('The account already exists for that email.');
      }
    } catch (e) {
    }
  }


}
void f_saveform(String skey){
  try {
    var allui = find.byType(xfield_uiex);
    Map<String, dynamic> h = new Map<String, dynamic>(); // link
    xfield_uiex ui;
    for (int i = 0; i < allui
        .evaluate()
        .length; i++) {
      ui = allui
          .at(i)
          .evaluate()
          .single
          .widget as xfield_uiex;
      h = ui.getdata();
      h.forEach((key, value) {
        g.saveiform(key, value);
        //g.form[key] = value;
      });
    }
  }catch(e){}

}
void f_saveform2(String skey){
  try {
    var allui = find.byType(formui_ex);
    Map<String, dynamic> h = new Map<String, dynamic>(); // link
    formui_ex ui;
    for (int i = 0; i < allui
        .evaluate()
        .length; i++) {
      ui = allui
          .at(i)
          .evaluate()
          .single
          .widget as formui_ex;
      h = ui.getdata();
      h.forEach((key, value) {
        g.saveiform(key, value);
      });
    }
    alert(g.form.toString());
  }catch(e){}

}


void f_chatwith(String skey) {

  String myid=g.cmdval("u_id");
  String fid=g.cmdval("f_id");
  String f_token=g.cmdval("f_token");
  String u_name=g.cmdval("u_name");
  String u_fname=g.cmdval("f_name");
  String u_imgurl=g.cmdval("u_imgurl");
  String u_fimgurl=g.cmdval("f_imgurl");

 /* try {

    String chatID = makeChatId(myid, fid);
    Navigator.push(
        g.ctx(),
        MaterialPageRoute(
            builder: (context) => ChatRoom(myid,
                u_name,
                u_imgurl,
                f_token,
                fid,
                chatID,
                u_fname,
                u_fimgurl)));
  } catch (e) {
    print(e.message);
  }*/

}

void f_chatlist_query(String skey) {

  try {

    String gridview=g.cmdval("gridview");


    gridview_ex wd;
    gridview_ex tgridview=null;
    var allui = find.byType(gridview_ex);
    for (int i = 0; i < allui.evaluate().length; i++) {
      wd = allui.at(i).evaluate().single.widget as gridview_ex;
      print("compage ${gridview}  :  ${wd.id()} ");

      if(gridview==wd.id()||skey+"."+gridview==wd.id()){
        tgridview=wd;
      }
    }
   // g.tmsg("grid_view:"+gridview);

    if(tgridview!=null){
      FirebaseFirestore.instance.collection("/users/h12fFoxEa3hwjR0leVXcBXJBUjk2/chatlist").get().then((
          db) {


        List lv=[];
        Map<String, dynamic> h = new Map<String, dynamic>();
        int im= db.docs.length;
        //wd.eventx.add("clear");
        for(int i=0; i<im; i++){
          h=db.docs[i].data();
          wd.dt.add(h);


        }


        //wd.dt.add(lv);

        //alert("dt"+wd.dt.toString());
        wd.eventx.add("xxx");

        // querySnapshot.docs.forEach((result) {


        // int im=result.data().length;
        // for(int i=0; i<im; i++){
        //   alert(result.data().keys.toString());
        // }


        // List lv=result as List;
        // lv.forEach((row) {
        //    alert(row.toString());
        // });
        // result.forEach((key, value) {
        //   alert(key+":"+value.toString());
        // });
        // });
      });
    }




  }catch(e){
    alert("f_chatlist_query.error."+e.toString());

  }



  // alert("call f_chatlist_query");
  // StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance
  //         .collection('users')
  //        // .where('chatWith', isEqualTo: userData['userId'])
  //         .snapshots(),
  //     builder: (context, chatListSnapshot) {
  //
  //             alert("found :"+chatListSnapshot.data.toString());
  //     });


}




Future<void> checkAuthStatus() {
  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if(user != null){
      g.papp["firebase_uid"]=user.uid;
    }
  });
}



void
f_firebase_regis(String skey,Map<String, dynamic> tcmd) async{
  try {

   // g.tmsg("firebase.cmd:${tcmd}");

    String u_email = g.null2str(tcmd["u_email"]);
    String u_password =g.null2str(tcmd["u_password"]);

    if(u_email==""){
      u_email="u"+g.login_id+"@gmail.com";
    }
    if(u_password==""){
      u_password="88888888pP";
    }


    try{
      fb_user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: u_email,
          password: u_password
      );
    }catch(e){
      var userid = await fba.FBAuth.instanace.addUser(g.ctx(), u_email, u_password);
      fb_user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: u_email,
          password: u_password
      );
    }








    checkAuthStatus();
    await NotificationController.instance.gettoken();
    await NotificationController.instance.takeFCMTokenWhenAppLaunch();


    /*if(g.isdebug()){
      g.alert("firebase_info=${fb_user.user.email}  ${fb_user.user.uid}");
    }*/


    //g.tmsg("f_firebase_regis");
    // add chat firebase user
    try {
      String u_img = "https://preloved.com/img/u.png";


      FBCloudStore.instanace.saveUserDataToFirebaseDatabase(
          u_email,
          fb_user.user.uid,
          u_email,
          u_email,
          u_img).then((userData) {


      });
    } catch (e) {}

    NotificationController.instance.initLocalNotification();
    NotificationController.instance.updateTokenToServer();


    Future.delayed(Duration(milliseconds: 100), () {
      if (g.cmd.containsKey("x_click")) {
        ojclick(skey, g.cmdval("x_click"));
      }
    });






    // g.tmsg("f_firebase_regis=true:" + g.null2str(g.pprofile["firebase_fcmtoken"]));
  }catch(e){
    alert("f_firebase_regis.error."+e.toString());
  }


}
void  f_create_userchat(String skey) async{

  if(g.regis_firebase){

    String u_name=g.cmdval("u_name");
    String u_email=g.cmdval("u_email");
    String u_title=g.cmdval("u_title");
    String u_img=g.cmdval("u_img");
    String chat_id=g.cmdval("chat_id");

    if(u_img==""){
      u_img="https://preloved.com/img/u.png";
    }

    var userid= await fba.FBAuth.instanace.addUserUsingEmail(g.ctx(),u_email);
    await NotificationController.instance.takeFCMTokenWhenAppLaunch();


    FBCloudStore.instanace.saveUserDataToFirebaseDatabase(
        u_email,
        chat_id,
        u_name,
        u_title,
        u_img).then((userData){

      NotificationController.instance.initLocalNotification();
      NotificationController.instance.updateTokenToServer();
      ojclick(skey, g.cmdval("y_click"));

    });

  }



}

void  f_create_account(String skey) async{

  if(g.regis_firebase){

    String u_name=g.cmdval("u_name");
    String u_email=g.cmdval("u_email");
    String u_title=g.cmdval("u_title");
    String u_img=g.cmdval("u_img");
    if(u_img==""){
      u_img="https://preloved.com/img/u.png";
    }

    var userid= await fba.FBAuth.instanace.addUserUsingEmail(g.ctx(),u_email);
    await NotificationController.instance.takeFCMTokenWhenAppLaunch();



    FBCloudStore.instanace.saveUserDataToFirebaseDatabase(
        u_email,
        userid,
        u_name,
        u_title,
        u_img).then((userData){
      NotificationController.instance.initLocalNotification();
    });
    NotificationController.instance.updateTokenToServer();


  }


}
void  f_goto_chatlist() async{
  if(g.regis_firebase){

    try {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user != null) {
          String _userId = user.uid;
          FBCloudStore.instanace.takeUserInformationFromFBDB().then((documents) {
            if (documents.length > 0) {


              String email = documents[0]['email'] ?? '';
              String name = documents[0]['name'];
              String intro = documents[0]['intro'];
              String uimg = "https://preloved.com/img/u.png";
              _userId = documents[0]['userId'];



          /*    Navigator.push(g.ctx(), MaterialPageRoute(
                  builder: (context) => ChatList(_userId, name, uimg)));

*/
              //
              // FBCloudStore.instanace.saveUserDataToFirebaseDatabase(
              //     email, _userId, name, info, uimg).then((userData) {
              //   if (userData != null) {
              //
              //     Navigator.push(g.ctx(), MaterialPageRoute(
              //         builder: (context) => ChatList(userData[0], name, uimg)));
              //   }
              //
              // });


            }
          });
        } else {
          alert("not_create_account");
        }
      });
    }catch(e){

      alert("f_goto_chatlist.error."+e.toString());

    }
  }




}




Future<void> f_sendnoti(String skey) async {


  String str_token=g.cmdval("firebase_token");


/*  await NotificationController.instance.send_noti_touser(str_token,
      g.cmdval("title"),
      g.cmdval("detail"),
      g.cmdval("refid"));*/

  await g.send_noti_touser(str_token,
      g.cmdval("title"),
      g.cmdval("detail"),
      g.cmdval("image"),
      g.cmdval("refid"));
}



call_mqtt_connect( Map<String, dynamic> tcmd) async {

  String tval="";
    try{
      tval=g.null2str(tcmd["mqtt_server"]);
      if(tval!=""){
        int mqtt_port = g.cint(g.hval(tcmd,"mqtt_port"), 1883);
        String mqtt_server = g.null2str2(g.hval(tcmd,"mqtt_server"), "broker.emqx.io");
        String mqtt_clientname = g.null2str2(
            g.hval(tcmd,"mqtt_client_name"), "client_" + g.newkey());




        gmqtt_client =
            MqttServerClient.withPort(mqtt_server, mqtt_clientname, mqtt_port);
        gmqtt_client.logging(on: true);
        gmqtt_client.onConnected = mqtt_connected;
        gmqtt_client.onDisconnected = mqtt_disconnected;
        gmqtt_client.onUnsubscribed = mqtt_onUnsubscribed;
        gmqtt_client.onSubscribed = mqtt_onSubscribed;
        gmqtt_client.onSubscribeFail = mqtt_onSubscribeFail;
        gmqtt_client.pongCallback = mqtt_pong;

        // with password login
        if (tcmd.containsKey("mqtt_u")) {
          try {
            final connMessage = MqttConnectMessage()
                .authenticateAs(g.hval(tcmd,"mqtt_u"), g.hval(tcmd,"mqtt_p"))
                .keepAliveFor(60)
                .startClean()
                .withWillQos(MqttQos.atLeastOnce);
            gmqtt_client.connectionMessage = connMessage;
          } catch (e) {}
        }
      }

    }catch(e){}
  try{
    await gmqtt_client.connect();
  }catch(e){}

}
Future<MqttServerClient> f_mqtt_connect(String skey) async {

  try {
    Map<String, dynamic> tcmd = new Map<String, dynamic>();
    g.cmd.forEach((key, value) {
      tcmd[key] = value;
    });

    print("mqtt_cmd:${tcmd}");

    var tval = "";
    gridview_ex grid = null;
    String grid_topic="";
    if (tcmd.containsKey("into_datagrid")) {
      List<String> l= g.hval(tcmd,"into_datagrid").split("[");
      var into_datagrid = l[0];
      grid_topic=l[1];
      if (g.list_ui[skey].containsKey(into_datagrid)) {
        grid = g.list_ui[skey][into_datagrid] as gridview_ex;
      }
    }

   //await call_mqtt_connect(tcmd);


    // start connect
    try{
      tval=g.null2str(tcmd["mqtt_server"]);
      if(tval!=""){
        int mqtt_port = g.cint(g.hval(tcmd,"mqtt_port"), 1883);
        String mqtt_server = g.null2str2(g.hval(tcmd,"mqtt_server"), "broker.emqx.io");
        String mqtt_clientname = g.null2str2(
            g.hval(tcmd,"mqtt_client_name"), "client_" + g.newkey());




        gmqtt_client =
            MqttServerClient.withPort(mqtt_server, mqtt_clientname, mqtt_port);
        gmqtt_client.logging(on: true);
        gmqtt_client.onConnected = mqtt_connected;
        gmqtt_client.onDisconnected = mqtt_disconnected;
        gmqtt_client.onUnsubscribed = mqtt_onUnsubscribed;
        gmqtt_client.onSubscribed = mqtt_onSubscribed;
        gmqtt_client.onSubscribeFail = mqtt_onSubscribeFail;
        gmqtt_client.pongCallback = mqtt_pong;

        // with password login
        if (tcmd.containsKey("mqtt_u")) {
          try {
            final connMessage = MqttConnectMessage()
                .authenticateAs(g.hval(tcmd,"mqtt_u"), g.hval(tcmd,"mqtt_p"))
                .keepAliveFor(60)
                .startClean()
                .withWillQos(MqttQos.atLeastOnce);
            gmqtt_client.connectionMessage = connMessage;
          } catch (e) {}
        }
      }

    }catch(e){}
    try{
      await gmqtt_client.connect();
    }catch(e){
      g.tmsg("mqtt_connect.error.${e}");
    }
    gmqtt_client.autoReconnect=true;
    gmqtt_client.resubscribeOnAutoReconnect=true;
    // end-connect



    try {


      try {
        if (tcmd.containsKey("mqtt_unsub")) {
          List<String> a =g.null2str(tcmd["mqtt_unsub"]).split(",");
          a.forEach((s1) {
            gmqtt_client.unsubscribe(s1);
          });
        }
      } catch (e) {}


      String str_sub = g.hval(tcmd,"mqtt_sub");



      // clear sub old topic
      String mqtt_key = g.hval(tcmd,"mqtt_key");
      if(mqtt_key!=""){
        mqtt_key=g.hval(g.mqtt_key,mqtt_key);
        if(mqtt_key!=""){
          List<String> ax= mqtt_key.split(",");
            ax.forEach((s1) {
              gmqtt_client.unsubscribe(s1);
            });
        }
        // save current path
        mqtt_key = g.hval(tcmd,"mqtt_key");
        g.mqtt_key[mqtt_key]=str_sub;
      }



       print("mqtt_sub_topic:${str_sub}");





        List<String> a = str_sub.split(",");
        List<String> b;
        a.forEach((s1) {
          b=s1.split("[");
            if(b.length >=2){
              if (g.null2str(g.k_data[b[1]]) != "") {
                gmqtt_client.unsubscribe(g.null2str(g.k_data[b[1]]));
              }
              g.k_data[b[1]] = b[0];
            }
          gmqtt_client.subscribe(b[0], MqttQos.atLeastOnce);
        });








      if (g.hval(tcmd,"mqtt_pub") != "") {
        var pubTopic = g.hval(tcmd,"mqtt_pub");
        final builder = MqttClientPayloadBuilder();
        String pub_data=g.hval(tcmd,"pub_data");

        Map<String, dynamic> h = new Map<String, dynamic>(); //focus row
        List b;
        pub_data.split(",").forEach((s1) {
          b=s1.split("[");
          h[b[0]]=b[1];
        });
        builder.addString(json.encode(h).toString());
        gmqtt_client.publishMessage(
            pubTopic, MqttQos.atLeastOnce, builder.payload);
      }
      if (g.hval(tcmd,"mqtt_close") != "") {
        int idelay = g.cint(g.hval(tcmd,"mqtt_close"), 100);
        Future.delayed(Duration(milliseconds: idelay), () {
          if (str_sub != "") {
            gmqtt_client.unsubscribe(str_sub);
          }
          gmqtt_client.disconnect();
        });
      }


      if (tcmd.containsKey("x_click")) {
        ojclick(skey, g.null2str(tcmd["x_click"]));
      }
    } catch (e) {
      alert('mqtt connect error.Exception: $e');
      gmqtt_client.disconnect();
    }
    Map<String, dynamic> h =new Map<String, dynamic>();

    gmqtt_client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload;
      final payload =
      MqttPublishPayload.bytesToStringAsString(message.payload.message);




      g.mqtt_msg = utf8.decode(payload.runes.toList());
      if (g.null2str(tcmd["mqtt_debug"]) == "true") {
        g.tmsg("mqtt_debug ${c[0].topic}:${g.mqtt_msg}");
      }


      print("mqtt_data:${c[0].topic} =  ${g.mqtt_msg}");
      try {
        Map<String, dynamic> h = json.decode( g.mqtt_msg);
          mqtt_cmd("",h);
        print("mqtt_background:${h}");
      }catch(e){}


      if (grid != null) {
        if (!grid.eventx.isClosed) {
          if(g.null2str(h["this_cmd"])!="true"){
            try {
              if(grid_topic==""){
                grid.eventx.add("mqtt_addrow");
              }else if (grid_topic==c[0].topic) {
                grid.eventx.add("mqtt_addrow");
              }
            } catch (e) {}
          }
        }
      }


      if (g.null2str(tcmd["save2app"]) == "true") {
        try {
          var h = jsonDecode(g.mqtt_msg) as Map<String, dynamic>;
          h.forEach((key, value) {
            g.papp[key] = value;
          });
          g.app_stream.add("update");
        } catch (e) {}
      }


      tval=g.null2str(tcmd["t_click"]);
      if (tval!="") {
        g.t_click = tval;
      }
      tval=g.null2str(tcmd["t_click"]);
      if (tval!="") {
        g.t_click = tval;
      }
      g.addeventbus(skey, "mqtt_receive");
    });


    return gmqtt_client;
  }catch(e){
    print("mqtt.error."+e.toString());
  }
}


showAlertDialog(String stitle,String smsg){
  showDialog(
      context: g.ctx(),
      builder: (BuildContext context){
        return  Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Container(
                width: g.screen_w - 16,
                height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100]
                ),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      stitle,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          smsg,
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                            color: Colors.black87,
                          ),
                        ),
                      ) ,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text("No")
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text("Yes")
                        )
                      ],
                    )
                  ],
                )
            )
          ],
        );
      }
  );
}

Future msgbox(BuildContext context,String str_msg) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Info'),
        content:  Text(str_msg),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              //Navigator.of(context).pop();
              Navigator.of(context,rootNavigator: true).pop();

            },
          ),
        ],
      );
    },
  );
}


class DefaultClickListener implements ClickListener {

  var textEditingControllers = <TextEditingController>[];

  @override
  void onClicked(String event) {


/*
    g.f["data"]="click me";

    msgbox(ctx,"onClick.event:"+event);

    var xtext = getojid("btn_post1");
    var id=xtext.key.toString().replaceAll("[<'", "").replaceAll("'>]", "");
    var textFind =  find.byType(RaisedButton);//find.byKey(Key('btn_post1'));
    var btn1 = (textFind.at(0).evaluate().single.widget) as RaisedButton;

    msgbox(ctx,id+":"+id+":"+ (btn1.child as Text).data);
 */


  }







/*
  _getIPAddress() async {
    String url = 'https://httpbin.org/ip';
    var httpClient = createHttpClient();
    var response = await httpClient.read(url);
    Map data = JSON.decode(response);
    String ip = data['origin'];
  }

*/



}








Future<void> reloadapi() async {

}

void setojval(Widget wg,String val){
  if(wg is textfield_ex){
    (wg as textfield_ex).setval(val);
  }
  if(wg is text_ex){
    (wg as text_ex).setval(val);
  }
  if(wg is textview){
    (wg as textview).setval(val);
  }
  if(wg is xui_ex){
    (wg as xui_ex).setval(val);
  }
}

String  grid_readcheckbox_data( List dt){

  try {
    String s = "";
    Map<String, dynamic> h = new Map<String, dynamic>(); // language
    dt.forEach((dr) {
      h = dr;
      if (h["rcheck"] == "1") {
        s += g.null2str(h["rdata"]) + ",";
      }
    });
    s = rcut(s);
    return s;
  }catch(e){}
  return "";

}
String getojval(Widget wg ,String skey,String id){
  String val="";
  String vid="";
  try {
    if(wg is textfield_ex){
      val= (wg as textfield_ex).val();
    }
    if(wg is textformfield_ex){
      val= (wg as textformfield_ex).val();
    }
    if(wg is button_ex){
      val= (wg as button_ex).val();
    }

    if(wg is gridview_ex){
      val=grid_readcheckbox_data((wg as gridview_ex).dt);
    }
    if(wg is text_ex){

     // g.active_key=skey;

      if(g.isfoundfield(id)){
        List a=id.split(".");
        val=g.getdatafield(id);

      }else {
        val= (wg as text_ex).val();
       // alert("f:${g.iform[g.active_key]}");
      }
    }
  }catch(e){}

  return val;

}

//
// String read_form(String skey){
//
//
//
//   g.fval=g.f[skey];
//   g.active_key=skey;
//   String val="";
//   String sid="";
//   String sval="";
//
//
//
// g.f1=new Map<String, String>();
//
//
//   if(val==""){
//
//     var allui;
//     Widget wd;
//     // textfield
//     allui = find.byType(textfield_ex);
//     for (int i = 0; i < allui.evaluate().length; i++) {
//       wd = allui.at(i).evaluate().single.widget;
//       sid=(wd as textfield_ex).id();
//       sval= getojval(wd,skey,sid);
//       if(k==sid){
//         return sval;
//       }
//       if(skey+"."+k==sid){
//         return sval;
//       }
//     }
//
//     // text form field
//     allui = find.byType(textformfield_ex);
//     for (int i = 0; i < allui.evaluate().length; i++) {
//       wd = allui.at(i).evaluate().single.widget;
//       sid=(wd as textformfield_ex).id();
//       sval= getojval(wd,skey,sid);
//       if(k==sid){
//         return sval;
//       }
//       if(skey+"."+k==sid){
//         return sval;
//       }
//     }
//
//     // text_ex
//     allui= find.byType(text_ex);
//     for (int i = 0; i < allui.evaluate().length; i++) {
//       wd = allui.at(i).evaluate().single.widget;
//       sid=(wd as text_ex).id();
//       sval= g.null2str(getojval((wd as text_ex),skey,sid));
//
//       if(k==sid){
//         print("find_text_ok:"+sid+":"+k+" val:"+sval);
//         return sval;
//       }
//       sid=sid.replaceAll(skey+".","");
//       if(k==sid){
//         if(g.fval.containsKey(sid)){
//           sval= g.null2str(g.fval[sid]);
//         }
//         return sval;
//       }
//     }
//   }
//   return val;
// }
//


// String read_form(String skey){
//
//
//
//   g.fval=g.f[skey];
//   g.active_key=skey;
//   String sid="";
//   String sval="";
//
//    // g.f1=new Map<String, String>();
//
//     var allui;
//     Widget wd;
//     allui = find.byType(textfield_ex);
//     for (int i = 0; i < allui.evaluate().length; i++) {
//       wd = allui.at(i).evaluate().single.widget;
//       sid=(wd as textfield_ex).id();
//       sval= g.null2str(getojval(wd,skey,sid));
//
//      // g.f1[sid]=sval;
//     }
//
//     // text form field
//     allui = find.byType(textformfield_ex);
//     for (int i = 0; i < allui.evaluate().length; i++) {
//       wd = allui.at(i).evaluate().single.widget;
//       sid=(wd as textformfield_ex).id();
//       sval= g.null2str(getojval(wd,skey,sid));
//      // g.f1[sid]=sval;
//
//     }
//     // text_ex
//     allui= find.byType(text_ex);
//     for (int i = 0; i < allui.evaluate().length; i++) {
//       wd = allui.at(i).evaluate().single.widget;
//       sid=(wd as text_ex).id();
//       sval= g.null2str(getojval(wd,skey,sid));
//      // g.f1[sid]=sval;
//     }
//
//
// }

bind(Map<String, dynamic> h, BuildContext bc){

  if(g.send_bind.length==0){
    return;
  }

  var finger;
  h.forEach((k, v) {
    finger = find.byKey(Key(k));
    if(finger.evaluate().length>0){
      Widget  wd=finger.at(0).evaluate().single.widget;
      setojval(wd,"bind");
    }
  });



  g.send_bind.clear();
 // updateui(bc);

}

//
// selectval(String s){
//   s=","+s+",";
//   s=s.replaceAll(",,", ",");
//
//   Map<String, dynamic> q = new Map<String, dynamic>();
//   var allui =find.byType(textfield_ex);
//   textfield_ex wd;
//   text_ex wd2;
//   for(int i=0; i<allui.evaluate().length; i++){
//     wd=allui.at(i).evaluate().single.widget as textfield_ex;
//     if(s.contains(","+wd.id()+",")){
//       q[wd.id()]=wd.val();
//     }
//   }
//   allui =find.byType(text_ex);
//   for(int i=0; i<allui.evaluate().length; i++){
//     wd2=allui.at(i).evaluate().single.widget as text_ex;
//     if(s.contains(","+wd2.id()+",")){
//       q[wd2.id()]=wd2.val();
//     }
//   }
//   return q;
// }


void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    if(!(el is gridview_ex)){
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
  }
  if(!(context is gridview_ex)){
    (context as Element).visitChildren(rebuild);
  }
}

updateuix(BuildContext bc){

  // if( find.byType(SingleChildScrollView).evaluate().length > 0  ) {
  //   find.byType(SingleChildScrollView).evaluate().toList().forEach((element) {
  //     rebuildAllChildren(element);
  //   });
  // }else if( find.byType(Expanded).evaluate().length > 0  ){
  //   find.byType(Expanded).evaluate().toList().forEach((element) {
  //     rebuildAllChildren(element);
  //   });
  // }else {
  //   rebuildAllChildren(bc);
  // }

  rebuildAllChildren(bc);

}


void setvfield(String fieldname,String sval){

  try {
    var x = g.fx[g.active_key];
    if (x == null) {
      x = g.newmap();
    }
    x[fieldname] = sval;
    g.fx[g.active_key] = x;
  }catch(e){}

}
String getvfield(String fieldname){
  try {
    var x = g.fx[g.active_key];
    if (x == null) {
      x = g.newmap();
    }
    return g.null2str(g.fx[g.active_key][fieldname]);
  }catch(e){}
  return "";
}

// l.pr[1,




clear_field(String skey,String vcmdtext){


  g.tmsg("clear field=${vcmdtext}");



  /*
  String sval="";

  setoj

    arr=vcmdtext.split(",");
    arr.forEach((ui_name) {
      g.saveiform(ui_name, "");
    });

    var allui;
    Widget wd;
    textfield_ex txt;
    allui =find.byType(textfield_ex);
  bool isfound=false;
  for(int i=0; i<allui.evaluate().length; i++){
      txt=allui.at(i).evaluate().single.widget;
       arr.forEach((vid) {
         if(g.idmath(txt.id(), vid)){
            txt.txtc.text="";
            isfound=true;
         }
      });
  }



 // g.list_ui[skey]=list;
*/





}
String selectx(String s,skey){
  String sx = "";
  g.q.clear();
  try {
    String sval = "";
    List<String> a = s.split(",");
    List<String> b;
    String x = "";
    String vid="";
    Widget wd;


    // if(s.contains("f.")){
    //   //read_form(skey);
    // }

    List allrow;
    Map<String, dynamic> vjs = new  Map<String, dynamic>();
    try{
      allrow= jsonDecode(jsonx)["d"] as List;
      if(allrow.length>0){
        vjs = allrow[0] as  Map<String, dynamic>;
      }
    }catch(e){}

    a.forEach((s) {
      if (!s.contains(".")) {
        g.q[s] = g.null2str(g.cmd[s]);
        sx += "&" + s + "=" + g.null2str(g.cmd[s]);
      } else {
        b = s.split(".");

        switch (b[0]) {

          case "i":
            sval="";
            if(g.i.containsKey(b[1])){
              sval=g.null2str(g.i[b[1]][b[2]]);
            }

            break;
          case "f":

            if(g.isfoundfield(b[1])){
              sval=g.getdatafield(b[1]);
            }else {
              vid=b[1];
              if(g.list_ui[skey].containsKey(vid)){
                //g.tmsg("case 1");

                wd=g.list_ui[skey][vid];
                sval=getojval(g.list_ui[skey][vid],skey,vid);
              }else  {
               // g.tmsg("case 2");

                vid=skey+"."+b[1];
                if(g.list_ui[skey].containsKey(vid)){
                  wd=g.list_ui[skey][vid];
                  sval=getojval(g.list_ui[skey][vid],skey,vid);
                }
              }

            }
            //g.alert("ifrom:${iform[active_key]}");
            break;

          case "fv":
            sval=g.getvfield(b[1]);
            break;

          case "fx":
            if (fx.containsKey(b[1])) {
              sval = fx[b[1]];
            }
            break;
          case "k":
            if (g.pkey.containsKey(b[1])) {
              sval = g.pkey[b[1]];
            }
            break;
          case "g":
            sval = g.null2str(g.g[b[1]]);
            break;
          case "sys":
            sval = g.null2str(g.sys[b[1]]);
            break;
          case "r":
            sval = g.null2str(g.preturn[b[1]]);
            break;
          case "rb":
            sval = g.null2str(g.rowbind[b[1]]);
            break;
          case "v": // variable
            sval = g.null2str(g.pvar[b[1]]);
            break;
          case "pf": // variable
            sval = g.null2str(g.pprofile[b[1]]);
            break;
          case "lz":
          case "l": // variable
            sval = g.null2str(g.plink[b[1]]);
            // alert("l:"+sval+" from  select $s");
            break;
          case "s": // variable
            sval = g.null2str(g.psend[b[1]]);
            break;
          case "b": // variable
            sval = g.null2str(g.pback[b[1]]);
            break;
          case "a": // variable
            sval = g.null2str(g.papp[b[1]]);
            break;
          case "c": // variablef
            sval = g.null2str(g.c[b[1]]);
            if(g.px.containsKey(skey)){
              sval=g.null2str(g.px[skey][b[1]]);
            }
            break;
          case "lg": // variable
            sval = g.null2str(g.lg[b[1]]);
            break;
          case "j": // variable
            sval = g.null2str(g.jd[b[1]]);
            break;
          case "jd": // variable
            sval = g.null2str(g.jd[b[1]]);
            break;
          case "jh": // variable
            sval = null2str(jh[b[1]]);
            break;
          case "c": // variable
            sval = null2str(c[b[1]]);
            break;
          case "fr": // variable
            sval = null2str(g.fr[b[1]]);
            break;

          case "js": // variable
            sval  = null2str(vjs[b[1]]);
            break;
          case "dr": // variable
            sval  = null2str(dr[b[1]]);
            break;
          case "h": // variable
            sval = null2str(hx[b[1]]);
            break;

        }
        sval=g.encode_url(sval);
        g.q[b[b.length-1]] = sval;
        sx += "&" + b[1] + "=" + sval;
      }
    });
  }catch(e){
    //alert("selectx.error."+e.toString());
  }

  //("f:"+g.f[skey].toString());
  return sx;

}

String systemval(){

  String r="";
  g.login_id=g.strx(g.null2str(g.pkey["login_id"]),"");
  g.login_id=g.strx(g.login_id,"999");
  r+="&login_id="+g.login_id;

  List<String> a="device_id,device_via,device_version".split(",");
  a.forEach((sval) {
    r+="&"+sval+"="+g.null2str(sys[sval]);
  });


  return r;
}
Future<void> callapi(String skey, String apiname) async{
  g.callapi_endjob=false;

  apiname=apiname.toLowerCase();
  try {


    if(skey==""){
      skey=g.active_key;
    }


    if(g.cmdval("api_wait")=="true"){
      g.show_loadding(true);
    }




    if(g.cmdval("auto_hidekeyboard")=="true"){
      try{
        FocusManager.instance.primaryFocus.unfocus();
      }catch(e){}
    }


    // reset for call api
    g.callapi_ok=false;
    bool allow_callapi=true;
    String sval="";

    if(g.cmd.containsKey("read_rcheck")){
      await readrcheck(skey,g.cmdval("read_rcheck"));
    }

    List<String> a,b;
    Map<String, dynamic> hrow = new Map<String, dynamic>();
    Map<String, dynamic> hpr = new Map<String, dynamic>();

    String url_call = "";

    if(g.cmd.containsKey("api_url")){
      url_call=g.cmdval("api_url").replaceAll("{guid}", g.create_uuid());
    }else {
      url_call=g.url_api.replaceAll("{guid}", g.create_uuid());
    }

    url_call=g.decode_url(url_call);

    //  query select
    selectx(g.null2str(g.cmd["q"]),skey);


    if( apiname!="" &&  apiname!="true" ){
      g.q["api"]=apiname;
    }

    g.q.forEach((k1, v1) {
      url_call+="&"+k1+"="+v1;
      hpr[k1]=v1;
    });

    /*g.q.forEach((k1, v1) {
      url_call+="&"+k1+"="+Uri.encodeComponent(v1);
    });*/


    if(g.cmd.containsKey("api_q")){
      selectx(g.null2str(g.cmd["api_q"]),skey);
      g.q.forEach((k1, v1) {
        v1=decode_url(v1);
        url_call+="&"+k1+"="+Uri.encodeComponent(v1);
        hpr[k1]=Uri.encodeComponent(v1);
      });
    }
    if(g.cmd.containsKey("api_qreq")){
      selectx(g.null2str(g.cmd["api_qreq"]),skey);
      g.q.forEach((k1, v1) {
        v1=decode_url(v1);
        url_call+="&"+k1+"="+Uri.encodeComponent(v1);
        hpr[k1]=Uri.encodeComponent(v1);
        if(g.null2str(v1)==""){
          allow_callapi=false;
          print_log("Require Field:"+k1);
        }
      });
      if(!allow_callapi){
        g.showoverlay(false);
        f_ncmd(skey);
        return "";
      }
    }

    if(g.cmd.containsKey("api_q2")){
      selectx(g.null2str(g.cmd["api_q2"]),skey);
      g.q.forEach((k1, v1) {
        url_call+="&"+k1+"="+v1;
        hpr[k1]=v1;
      });
    }

    // send parameter
    if(g.cmd.containsKey("api_pr")){
      a=getfval(skey,g.cmdval("api_pr")).split(",");
      a.forEach((s1) {
        b=s1.split("[");
        if(b.length>=2){
          b[1]=g.decode_url(b[1]);
          url_call+="&"+b[0]+"="+Uri.encodeComponent(b[1]);
          hpr[b[0]]=Uri.encodeComponent(b[1]);
        }
      });
    }

    if(g.cmd.containsKey("api_pr2")){
      a=getfval(skey,g.cmdval("api_pr2")).split(",");
      a.forEach((s1) {
        b=s1.split("[");
        if(b.length>=2){
          url_call+="&"+b[0]+"="+b[1];
          hpr[b[0]]=b[1];
        }
      });
    }



    // send_pr
    if(g.cmd.containsKey("send_pr")){
      a=g.cmdval("send_pr").split(",");
      a.forEach((s1) {
        b=s1.split("[");
        if(b.length>=2){
          url_call+="&"+b[0]+"="+Uri.encodeComponent(b[1]);
          hpr[b[0]]=Uri.encodeComponent(b[1]);
        }
      });
    }




    url_call+=systemval();
    int trow=0;
    g.setscroll=g.cmdval("set_scroll");



    xval=g.cmdval("api_reqfield");
    if(xval !=""){
      a=xval.split(",");

      a.forEach((scol) {
        if(g.null2str(hpr[scol])==""){
          allow_callapi=false;
        }
      });
      if(!allow_callapi){
        g.showoverlay(false);
        f_ncmd(skey);
        return "";
      }
    }


    try{
      if(g.cmd.containsKey("grid_info")){
        String grid_info=g.cmdval("grid_info");

        /*if(!g.list_ui.containsKey(skey)){
        await f_readui(skey);
      }*/

        if(g.list_ui[skey].containsKey(grid_info)) {

          gridview_ex gx = g.list_ui[skey][grid_info] as gridview_ex;
          trow = gx.dt.length;


          //g.alert(" ${skey} row_count=${trow} ${grid_info} ${g.list_ui[skey].keys}");

          if(g.cmdval("api_reqone")=="true"){
            if(trow > 0){
              g.showoverlay(false);
              return "";
            }
          }

          if (trow > 0  && g.cmdval("fill") != "clear" ) {

            hrow = gx.dt[0];
            if (hrow.containsKey("rowid")) {
              url_call += "&a_rowid=" + g.null2str(hrow["rowid"]);
              hrow = gx.dt[trow - 1];
              url_call += "&z_rowid=" + g.null2str(hrow["rowid"]);
            }

            // custom rowid
            if (g.cmd.containsKey("rowid")) {
              url_call += "&a_rowid=" + g.null2str(g.cmdval(["rowid"]));
              hrow = gx.dt[trow - 1];
              url_call += "&z_rowid=" + g.null2str(g.cmdval(["rowid"]));
            }
          }

        }else {
          // g.tmsg(" ${skey} not_found_datagrid ${grid_info}   ${g.list_ui[skey].keys}");
          g.print_log("${skey}_not_found_datagrid ${grid_info}   ${g.list_ui[skey].keys}");
        }
      }
    }catch(e){}





    if(g.cmdval("fill") == "clear" || g.cmdval("fill") == "reset" ){
      trow=0;
    }

    url_call+="&t_rowcount="+trow.toString();
    String save_json=g.null2str(g.cmd["save_json"]);




    // add default config
    if(cfg_api_pr!=""){
     // g.bmsg(cfg_api_pr);
    }
    url_call+=cfg_api_pr;




    try {
      sval = g.cmdval("datagrid_upload_fileinfo");
      if (sval != "") {
        if (g.list_ui[skey].containsKey(sval)) {
          g.select_file="";
          gridview_ex gx = g.list_ui[skey][sval];
          gx.dt.forEach((dr) {
            g.select_file += dr["data"] + ",";
          });
          g.select_file = g.rcut(g.select_file);
        }
      }
    }catch(e){}


    /* if(g.cmd.containsKey("api_wait")){
      EasyLoading.show(status: 'Waiting...');
    }*/



    var rx;


    // send file upload
    if(g.cmd.containsKey("api_file_upload")){
      try {

        selectx(g.null2str(g.cmd["api_file_upload"]), skey);
        xval = "";
        g.q.forEach((k1, v1) {
          if (g.null2str(v1) != "") {
            xval += v1 + ",";
          }
        });
        xval = g.rcut(xval);
        g.select_file = g.decode_url(xval);
        //g.tmsg("file upload =${g.select_file}");
        if (g.select_file != "") {
          allow_callapi = false;
          g.jsonx = await upload_file(url_call, skey, hpr);
        }

      }catch(e){
        g.tmsg("api_file_upload.error.${e}");
      }


    }else if(g.cmd.containsKey("_getfile")){
      allow_callapi=false;
      await f_getfile(skey,g.cmdval("_getfile"));
      if(g.select_file!=""){
        g.jsonx =  await upload_file(url_call,skey,hpr);
      }
    }else if(g.cmdval("_uploadimg")!=""){
      allow_callapi=false;
      await f_getfile(skey,g.cmdval("_uploadimg"));
      //Future.delayed( Duration(milliseconds: 500), () async {
        if(g.select_file!=""){
          g.jsonx =  await upload_file(url_call,skey,hpr);
        }
       //});
    }
    else if(g.cmdval("_uploadimg2")!=""  || g.cmdval("upload_img")=="true"){
      allow_callapi=false;
     // Future.delayed( Duration(milliseconds: 500), () async {
        g.jsonx =  await upload_file(url_call,skey,hpr);
      //});
    }



    if(allow_callapi){

      bool isnewcall=true;
      String save_json=g.null2str(g.cmd["save_json"]);
      if(g.cmd.containsKey("api_k")){
        save_json=g.read_memory(g.cmdval("api_k"));
        if(save_json != ""){
          //g.tmsg("reuse api =${save_json}");
        }
      }
      if(g.cmd.containsKey("api_save2file")){
        save_json=g.readkey(g.cmdval("api_save2file"));
      }
      if(save_json != ""){
        g.jsonx=save_json;
        g.callapi_ok=true;
        isnewcall=false;
      }
      if(isnewcall){

          if(g.cmdval("used_api")=="last"
              ||g.cmdval("get_last_json")=="true"
              ||g.cmdval("fromjson")=="last"
              ||g.cmdval("fromjson")=="true"

          ){
            g.callapi_ok=true;
          }else {

            g.callapi_ok=false;
            try{
              if(g.cmd.containsKey("api_info")){

                    String api_info=g.cmd["api_info"];
                    String api_url=g.decode_url(g.cmdval("api_url").replaceAll("{guid}", g.create_uuid()));

                    var api_methed="POST";
                    var request = http.MultipartRequest(
                        api_methed, Uri.parse(api_url));

                    String js_api=g.read_json(g.json_ui,api_info);

                    hpr.forEach((key, value) {
                      js_api=js_api.replaceAll("{${key}}", value);
                    });
                    if(g.cmdval("api_pr_d")=="true"){
                      jd.forEach((key, v) {
                        try {
                          js_api=js_api.replaceAll("{" + key + "}", null2str(v));
                        }catch(e){
                        }
                      });
                    }

                  //  alert(js_api);
                    var  dx=jsonDecode(js_api).cast<String,String>();
                    request.fields.addAll(dx);
                    http.StreamedResponse response = await request.send();
                    if (response.statusCode == 200) {
                      g.jsonx =  await response.stream.bytesToString();
                     // g.alert(g.jsonx);
                    }

              }else {
                g.api_url_log=url_call;
                rx= await g.http_get(g.geturl(url_call));
                g.jsonx= rx.body.toString();
                g.callapi_ok=(rx.statusCode == 200);

              }




            }catch(e){}
          }
      }
    }

    //g.jsonx = json.decode( g.jsonx ).toString();

    if(g.cmdval("_setdebug")=="true" ||
        g.cmdval("_setdebugr")=="true" ||
        g.cmdval("setdebug")=="true"){
      g.alert("call:"+url_call+" return="+g.jsonx);
    }






    if (true) {

      if(save_json!=""){
        g.save_memory(save_json, g.jsonx);
      }
      // for update replace
      if(g.cmd.containsKey("saveapi_k")){
        g.save_memory(g.cmdval("saveapi_k"), g.jsonx);
      }
      if(g.cmd.containsKey("api_k")){
        g.save_memory(g.cmdval("api_k"), g.jsonx);
      }
      if(g.cmd.containsKey("api_save2file")){
        g.savekey(g.cmdval("api_save2file"), g.jsonx);
      }
      if(g.cmdval("api_save_app_json")=="true"){
         g.app_json= g.jsonx;
      }

      if(g.cmdval("save2key")=="true"){
        try{
          List allrow= jsonDecode(g.jsonx)["d"] as List;
          if(allrow.length > 0 ) {
            Map<String, dynamic> h = allrow[0] as  Map<String, dynamic>;
            print("save2key=${h}");
            h.forEach((k, v) {
              g.savekey(k, v);
            });
          }
        }catch(e){
          print("save2key.error"+e.toString());
        }
      }

      // default_d
      try{
        List allrow= jsonDecode(g.jsonx)["d"] as List;
        if(allrow.length > 0 ) {
          Map<String, dynamic> h = allrow[0] as  Map<String, dynamic>;
          if(g.isdebug()){
            g.alert("default_api_return=${h}");
          }
         // g.tmsg("default_api_return=${h}");
          h.forEach((key, value) {
            g.jd[key]=value;
          });
        }
      }catch(e){
        print("default_d.error"+e.toString());
      }


      if(g.cmd.containsKey("api_d")){
        String dval=g.cmdval("api_d");
        try{
          List allrow= jsonDecode(g.jsonx)[dval] as List;
          if(allrow.length > 0 ) {
            Map<String, dynamic> h = allrow[0] as  Map<String, dynamic>;
            h.forEach((key, value) {
              g.jd[key]=value;
            });
          }
        }catch(e){
          print("save2key.error"+e.toString());
        }
      }



    //  msg(g.getrunseq()+".debug:"+url_call+":"+g.g_json+"  jd="+g.jd.toString());





      /*if(g.list_ui[skey].containsKey(vcmdtext)){
                    gridview_ex gx=g.list_ui[skey][vcmdtext];
                    gx.eventx.add("datagrid_updaterow");
                  }else {
                    alert("not_found_datagrid:${vcmdtext} ${g.list_ui[skey].toString()}");
                  }*/

      Map<String, dynamic> h = new Map<String, dynamic>();

      // save2sys=d
      if(g.cmdval("save2sys") != ""){
        try{
          List allrow= jsonDecode(g.jsonx)[g.cmdval("save2sys")] as List;
          if(allrow.length > 0 ) {
             h = allrow[0] as  Map<String, dynamic>;
            h.forEach((k, v) {
              g.sys[k]=v;
            });
          }
        }catch(e){
        }
      }

      // save2sys=d
      if(g.cmdval("save2h") != ""){
        try{
          List allrow= jsonDecode(g.jsonx)[g.cmdval("save2h")] as List;
          if(allrow.length > 0 ) {
            h = allrow[0] as  Map<String, dynamic>;
            h.forEach((k, v) {
              jh[k]=v;
            });
          }
        }catch(e){
        }
      }

      // h.fieldname.varlane,,,
      if(g.cmdval("savejs2field") != ""){
        try{
          a=g.cmdval("savejs2field").split(",");
          a.forEach((s1) {
            b=s1.split(".");
            List allrow= jsonDecode(g.jsonx)[b[0]] as List;
            if(allrow.length > 0 ) {
              h = allrow[0] as  Map<String, dynamic>;
              save_var(b[2],b[1],g.null2str(h[b[1]]));
            }
          });
          }catch(e){
        }
      }

      // d.pf,d.var
      if(g.cmdval("api_save2x")!=""){
        try{
           List<String> a=g.cmdval("api_save2x").split(",");
           List<String> b;
           a.forEach((s1) {
                  b=s1.split(".");
                  List allrow= jsonDecode(g.jsonx)[b[0]] as List;
                  if(allrow.length > 0 ) {
                    h = allrow[0] as  Map<String, dynamic>;
                    g.savedata2(b[1], h);
                  }
           });
        }catch(e){}
      }
      // d.pf,d.v,d.l,
      if(g.cmdval("api_saveto")!=""){
        try{
          List<String> a=g.cmdval("api_saveto").split(",");
          List<String> b;
          a.forEach((s1) {
            b=s1.split(".");
            List allrow= jsonDecode(g.jsonx)[b[0]] as List;
            if(allrow.length > 0 ) {
              h = allrow[0] as  Map<String, dynamic>;
              g.savedata2(b[1], h);
            }
          });
        }catch(e){}
      }



      if(g.cmdval("save2var")!=""){
        try{
          String sx=g.cmdval("save2var");
          sx=","+sx+",";
          List allrow= jsonDecode(g.jsonx)["d"] as List;
          if(allrow.length > 0 ) {
            Map<String, dynamic> h = allrow[0] as  Map<String, dynamic>;
            h.forEach((k, v) {
              if(sx.contains(","+k+",")){
                g.pvar[k]=v;
              }
            });
          }
        }catch(e){}
      }
      // save to language
      if(g.cmdval("save2lg")!=""){
        try{
          String tval=g.cmdval("save2lg");
          List allrow= jsonDecode(g.jsonx)[tval] as List;
          allrow.forEach((h) {
           g.lg[h["k"]]=h["v"];
          });
        }catch(e){}
      }

      if(g.cmdval("save2profile")!=""){
        try{
          String colname=g.cmdval("save2profile");
          List allrow= jsonDecode(g.jsonx)[colname] as List;
          if(allrow.length > 0 ) {
            Map<String, dynamic> h = allrow[0] as  Map<String, dynamic>;
            h.forEach((k, v) {
              pprofile[k]=v;
            });
          }
        }catch(e){}
      }
      if(g.cmdval("save2ui")!=""){
        try{
          String colname=g.cmdval("save2ui");
          List allrow= jsonDecode(g.jsonx)[colname] as List;
          if(allrow.length > 0 ) {
            Map<String, dynamic> h = allrow[0] as  Map<String, dynamic>;
            h.forEach((k, v) {
              pprofile[k]=v;
              g.saveiform(k,g.null2str(v));
              update_field(skey,k,g.null2str(v));

            });
          }
        }catch(e){}
       // updateui(g.ctx());
      }



      callapi_r(g.jsonx,skey);
      g.show_loadding(false);


    if(g.cmdval("update_qloop")!=""){
        g.qloop_key=g.newkey();
      }


      // if(g.cmdval("rclick")!=""){
      //   Future.delayed( Duration(milliseconds: 1000), () {
      //     g.t_click=g.cmdval("rclick");
      //   });
      // }


      if(g.cmdval("end_click")!=""){
        Future.delayed( Duration(milliseconds: 100), () {
          runclick2(g.cmdval("end_click"),skey);
          //g.b_click=g.cmdval("end_click");
        });
      }
      if(g.cmdval("t_click")!=""){
        // g.t_click=g.cmdval("t_click");
        runclick2(g.cmdval("t_click"),skey);
      }

      if(g.cmdval("close_and_click")!=""){
        g.rclick=g.cmdval("close_and_click");
        int idelay=100;
        Future.delayed( Duration(milliseconds: idelay), () {
          g.nav="back";
          clear_pop();
          Navigator.pop(g.ctx(),g.q);
        });
      }



      if(g.cmdval("api_nav_exit")!=""){
        g.rclick=g.cmdval("api_nav_exit");
        if( g.rclick=="true"){
          g.rclick="";
        }
        int idelay=100;
        Future.delayed( Duration(milliseconds: idelay), () {
          g.nav="back";
          clear_pop();
          Navigator.pop(g.ctx(),g.q);
        });
      }


      if(g.cmdval("api_backclick")!=""){
        g.rclick=g.cmdval("api_backclick");
        if( g.rclick=="true"){
          g.rclick="";
        }
        int idelay=100;
        Future.delayed( Duration(milliseconds: idelay), () {
          g.nav="back";
          clear_pop();
          Navigator.pop(g.ctx(),g.q);
        });
      }
      if(g.cmdval("api_exit_click")!=""){
        g.rclick=g.cmdval("api_exit_click");
        if(g.rclick==""){
          g.rclick="";
        }
        if(g.cmdval("exit_msg")!=""){
             g.tmsg(g.cmdval("exit_msg"));
        }

        int idelay=100;
        Future.delayed( Duration(milliseconds: idelay), () {
          g.nav="back";
          clear_pop();
          Navigator.pop(g.ctx(),g.q);
        });
      }






    }
  }catch(e){
    //msg("callapi.error"+e.toString());
    g.print_log("callapi.error"+e.toString());
  }
  g.show_loadding(false);
  return g.jsonx;
}
void runclick2(String s,String skey){
  try {

    List<String> a = s.split(",");
    a.forEach((sval) {
      if (g.list_ui[skey].containsKey(sval)) {
           oj2cmd(g.list_ui[skey][sval],skey);
      } else {
        sval = skey + "." + s;
        if (g.list_ui[skey].containsKey(sval)) {
          oj2cmd(g.list_ui[skey][sval],skey);

        }
      }
    });

  }catch(e){}

}


getui_bytype(String skey,String uiname,String uitype){
  String s="";

  int i =0;
  var ui=null;

  if(list_ui[skey].containsKey(uiname)){
    ui=list_ui[skey][uiname];
  }
  if(ui==null){
    uiname=uiname.split(".").last;
    if(list_ui[skey].containsKey(uiname)){
      ui=list_ui[skey][uiname];
    }
  }
  if(ui==null){

    if(uitype=="gridview"){
      f_readui_gridview(skey);
    }else {
      f_readui(skey);
    }
    f_readui(skey);

    // scan ui again

    //g.tmsg("find ${uiname} ${list_ui[skey].keys}");

    if(list_ui[skey].containsKey(uiname)){
      ui=list_ui[skey][uiname];
    }
    if(!uiname.contains(".")){
      if(ui==null){
        uiname=skey+"."+uiname;
        if(list_ui[skey].containsKey(uiname)){
          ui=list_ui[skey][uiname];
        }
      }

    }
    if(ui==null){
      uiname=uiname.split(".").last;
      if(list_ui[skey].containsKey(uiname)){
        ui=list_ui[skey][uiname];
      }
    }
  }

  return ui;
}


bool f_readui_gridview(String tskey){


  Map<String, dynamic> regisui = new Map<String, dynamic>();
  var allui;
  Widget wd;


  try{
    regisui.clear();
  }catch(e){}
  allui =find.byType(gridview_ex);
  var il=0;
  try{
    il=allui.evaluate().length;
  }catch(e){}

 // alert("find_grid=${il}");

if(il>0){
  for(int i=0; i<il; i++){
    wd=allui.at(i).evaluate().single.widget;
    regisui[(wd as gridview_ex).id()]=wd;
    print("find_grid_${(wd as gridview_ex).id()}");
  }
}


  try {
    g.list_ui[tskey]=regisui;
  }catch(e){}

  return !regisui.isEmpty;


}
bool f_readuicmd(String tskey,String stag){

  Map<String, dynamic> regisui = new Map<String, dynamic>();
  var allui;
  Widget wd;


  if(stag=="cmd"){
      allui =find.byType(gridview_ex);
      for(int i=0; i<allui.evaluate().length; i++){
        wd=allui.at(i).evaluate().single.widget;
        regisui[(wd as gridview_ex).id()]=wd;
      }

      allui =find.byType(cmd_ex);
      for(int i=0; i<allui.evaluate().length; i++){
        wd=allui.at(i).evaluate().single.widget;
        regisui[(wd as cmd_ex).id()]=wd;
      }

      try {
        g.list_ui[tskey]=regisui;
      }catch(e){}
  }
  if(stag==""){

    allui =find.byType(gridview_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as gridview_ex).id()]=wd;
    }

    allui =find.byType(cmd_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as cmd_ex).id()]=wd;
    }

    // button
    allui =find.byType(button_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as button_ex).id()]=wd;
    }
    // text
    allui =find.byType(text_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as text_ex).id()]=wd;
    }

    // textfield
    allui =find.byType(textfield_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as textfield_ex).id()]=wd;
    }

    // textformfield
    allui =find.byType(textformfield_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as textformfield_ex).id()]=wd;
    }

    // networkimg
    allui =find.byType(networkimage_ex);
    for(int i=0; i<allui.evaluate().length; i++){
      wd=allui.at(i).evaluate().single.widget;
      regisui[(wd as networkimage_ex).id()]=wd;
    }
    try {
      g.list_ui[tskey]=regisui;
    }catch(e){}

  }

return !regisui.isEmpty;


}
bool f_readui(String tskey){

  Map<String, dynamic> regisui = new Map<String, dynamic>();
  var allui;
  Widget wd;


  allui =find.byType(gridview_ex);
  for(int i=0; i<allui.evaluate().length; i++){
    wd=allui.at(i).evaluate().single.widget;
    regisui[(wd as gridview_ex).id()]=wd;
  }
  // button
  allui =find.byType(button_ex);
  for(int i=0; i<allui.evaluate().length; i++){
    wd=allui.at(i).evaluate().single.widget;
    regisui[(wd as button_ex).id()]=wd;
  }
  // text
  allui =find.byType(text_ex);
  for(int i=0; i<allui.evaluate().length; i++){
    wd=allui.at(i).evaluate().single.widget;
    regisui[(wd as text_ex).id()]=wd;
  }

  allui =find.byType(cmd_ex);
  for(int i=0; i<allui.evaluate().length; i++){
    wd=allui.at(i).evaluate().single.widget;
    regisui[(wd as cmd_ex).id()]=wd;
  }

  // textfield
  allui =find.byType(textfield_ex);
  for(int i=0; i<allui.evaluate().length; i++){
    wd=allui.at(i).evaluate().single.widget;
    regisui[(wd as textfield_ex).id()]=wd;
  }

  // textformfield
  allui =find.byType(textformfield_ex);
  for(int i=0; i<allui.evaluate().length; i++){
    wd=allui.at(i).evaluate().single.widget;
    regisui[(wd as textformfield_ex).id()]=wd;
  }

  // networkimg
  allui =find.byType(networkimage_ex);
  for(int i=0; i<allui.evaluate().length; i++){
    wd=allui.at(i).evaluate().single.widget;
    regisui[(wd as networkimage_ex).id()]=wd;
  }
  try {
    g.list_ui[tskey]=regisui;
  }catch(e){}

 // g.tmsg("ui count${regisui.length}");
  logx("regis_ui:${regisui.keys}");

  return !regisui.isEmpty;

}



f_regis_fmsg(String skey) async {
  try{


    FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,badge: true,sound: true
    );


    try{

      await get_fcmToken();
      await getTopics();
    }catch(e){}




    var android_noti = AndroidInitializationSettings('ic_launcher');
    var ios_noti = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
          print("onDidReceiveLocalNotification called.");
          g.local_noti(title,body, "","");

        });


    var noti_setting = InitializationSettings(
        android: android_noti, iOS: ios_noti);


    flutterLocalNotificationsPlugin.initialize(noti_setting);


    print("fb_token_regis:${gfirebase_token}");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("FirebaseMessaging_onMessage:${message}");
      RemoteNotification noti = message.notification;
      AndroidNotification android = message.notification?.android;
      if (noti != null && android != null) {
        g.local_noti(noti.title, noti.body, "","");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("FirebaseMessaging_onMessage:${message}");
      RemoteNotification noti = message.notification;
      AndroidNotification android = message.notification?.android;
      if (noti != null && android != null) {
        g.local_noti(noti.title, noti.body, "","");
      }
    });


     //await get_fcmToken();
     //await getTopics();


  }catch(e){
   g.alert("f_regis_fmsg_error."+e.toString());

  }


}
get_fcmToken() async {
  try{
    gfirebase_token = await FirebaseMessaging.instance.getToken();
    gfirebase_token = g.null2str(gfirebase_token);

   // g.tmsg("fb_token:${gfirebase_token}");

    print("fb_token:${gfirebase_token}");
  if(gfirebase_token != ""){
      g.gfirebase_token=gfirebase_token;
      g.papp["fb_token"]=gfirebase_token;
  }}catch(e){
    alert("get_fcmToken.error :${e}");
  }

}
getTopics() async {
  try {
    List subscribed = [];
    await FirebaseFirestore.instance
        .collection('topics')
        .get()
        .then((value) =>
        value.docs.forEach((element) {
          if (gfirebase_token == element.id) {
            subscribed = element
                .data()
                .keys
                .toList();
          }
        }));
  }catch(e){}


}


Future<void> firebase_add(String skey) async {


  String msg=g.cmdval("msg");
  await FirebaseFirestore.instance
      .collection(g.cmdval("firebase_add"))
      .doc(DateTime.now().millisecondsSinceEpoch.toString()).set({
    'idFrom': "a",
    'idTo': "b",
    'timestamp': DateTime.now().millisecondsSinceEpoch,
    'content': msg,
    'type':"text",
    'isread':false,
  });

  if(g.cmd.containsKey("x_click")){
    ojclick(skey, g.cmdval("x_click"));
  }

}

Future<void> into_datagrid(String skey,String s_json) async {
  bool isok=true;
  try {

    g.datagrid_tag = "";
    List<String> arr = g.cmdval("into_datagrid").split(",");
    List<String> a;
    List<String> b;
    if(g.cmd.containsKey("finto_datagrid")){
      arr = g.cmdval("finto_datagrid").split(",");
    }



    try{
      if(!g.list_ui.containsKey(skey)){
        await f_readui_gridview(skey);
      }
    }catch(e){
      g.alert("f_readui_gridview.error.${e} ${g.list_ui.keys}");
    }

    print("call_into_datagrid:"+skey+":"+arr.toString()+g.list_ui[skey].toString());



    arr.forEach((scol) {

      try{

        b = scol.split(".");
        if (b.length == 3) {
          b[1] = b[1] + "." + b[2];
          b.removeLast();
        }
        List l=[];

        List<String> c=b[0].split("[");
        String rx=b[0].replaceAll('\n', '\\n');
        try{

          // case key value

          if(c.length>=2){
            var map = HashMap.from(jsonDecode(s_json)[c[0]][c[1]]);
             map.forEach((key, value) {
               value["row_k"]=key;
               l.add(value);
             });
           // g.alert("l=${l}");
            }else {
             l=jsonDecode(s_json)[c[0]];
           }


        }catch(e){
         // alert("json_decode_error.${e}");
        }


       if(g.isdebug()){
         g.alert("datainto->${b[0]}:${l.length} ${l}");
       }

        if (g.cmdval("data_revert") == "true") {
          l = l.reversed.toList();
        }
        if(g.cmd.containsKey("group_by")){
          l= l.groupBy(g.cmdval("group_by"));
          List lx=[];

          lx.addAll(l);
          l.clear();
          Map<String, dynamic> dr = new Map<String, dynamic>();
          Map<String, dynamic> h = new Map<String, dynamic>();

          List<String> hfield=g.cmdval("header_field").split(",");
          String header_all=g.cmdval("header_all");
          for(int i=0;i<lx.length;i++){


           // alert(lx[i].keys.first);
            xval=lx[i].keys.first;
            dr = new Map<String, dynamic>();
            dr["dk"]=xval;
            dr["dv"]=lx[i][xval];
            h=lx[i][xval][0];
            if(header_all!=""){
                h.forEach((key, value) {
                  dr[header_all+key]=value;
               });
            }

            hfield.forEach((sfield) {
              if(h.containsKey(sfield)){
                dr[sfield]=h[sfield];
              }
            });
            //alert("dr=${dr}");
            l.add(dr);
            //lx.add(dr);
          }
          lx.clear();

          //alert("groupby=${l}");

          /*l.clear();
          l.addAll(lx);
          lx.clear();*/



        }

        if(g.cmd.containsKey("js_filter")){

          // vender=fieldname[010,02,03
          a=g.cmdval("js_filter").split("[");
          Map<String, dynamic> h = new Map<String, dynamic>();  //call intent
          List l2=[];
          l.forEach((dr) {
            h=dr;
            if(h.containsKey(a[0])){
              if(g.str_in2(h[a[0]], a[1])){
                l2.add(dr);
              }
            }
          });
          l=l2;
        }

        g.jdb[b[1]] = l;
        if(g.isdebug()){
          //alert("database_into_datagrid:" + b[1] + "=" + g.db[b[1]].length.toString());
        }
      }catch(e){
        isok=false;
      }

    });
  }catch(e){
    g.alert("into_datagrid.error.${e}");
    isok=false;
  }
  //if(isok){
  finto_datagrid(skey,g.cmdval("into_datagrid"), false);
  //}
}

Future<Null>  api_saveto(String s_json,String skey){
  List<String> x,a;


  // d,a
  if (g.cmd.containsKey("api_saveto")) {
    x=g.cmdval("api_saveto").split(",");
    x.forEach((strx) {

      int idelay=0;
      bool is_error=false;
      Map<String, dynamic> h=new  Map<String, dynamic>();
      a=strx.split(".");

      if(a.length>=2){
        try {
          List l = jsonDecode(s_json)[a[0]] as List;
          var ilen=0;
          try {
            ilen = l.length;
          }catch(e){
            is_error=true;
          }

          if(!is_error && (l.length > 0)){
            try {
              h = l[0] as Map<String, dynamic>;
              switch(a[1]){
                case "pf":
                  h.forEach((tkey, tval) {
                    g.pprofile[tkey]=tval;
                  });
                  g.savekey("this_pf",json.encode(g.pprofile));
                  break;
                case "sys":
                  h.forEach((tkey, tval) {
                    g.sys[tkey]=tval;
                  });
                  break;
                case "var":
                  h.forEach((tkey, tval) {
                    g.pvar[tkey]=tval;
                  });
                  g.savekey("this_var", json.encode(g.pvar));
                  break;

                case "l":
                  h.forEach((tkey, tval) {
                    g.plink[tkey]=tval;
                  });
                  break;
                case "a":
                  h.forEach((tkey, tval) {
                    g.papp[tkey]=tval;
                  });
                  g.savekey("this_app",json.encode(g.papp));
                  break;

              }
            }catch(e){}
          }

        }catch(e){
          print("save2profile.error="+e.toString()+g.jsonx.toString());
        }
      }
    });
  }
}

void finto_datagrid(String skey,String s, bool iscopy){

  try {
  //  g.alert("finto_datagrid:${s}  ${g.cmd}");

    List<String> arr = s.split(",");
    List b;
    Map<String, dynamic> griddb = new Map<String, dynamic>();

    try {
      if(arr.length>0){

        arr.forEach((scol) {
          b = scol.split(".");
          if (b.length == 3) {
            b[1] = b[1] + "." + b[2];
            b.removeLast();
          }
          griddb[b[1]] = b[0];
        });

      }
    }catch(e){}



into_grid = new Map<String, dynamic>(); //focus row

bool isfound = false;

arr.forEach((sui) {
  var ui=readui(sui,skey);

    if(ui==null){
      ui=getui_bytype(skey,sui,"gridview");
    }
    if(ui!=null){
      gridview_ex wd = ui as gridview_ex;
     // g.ggrid_id=wd.id();
      if(!g.into_grid.containsKey(wd.id())){
        g.into_grid[wd.id()]=wd.id();
        if (iscopy) {

        }
        print("call_intodatagrid_: ${wd.id()} ");
        if(g.cmdval("api_reqone")=="true"){
          if(wd.dt.length==0){
            wd.add_event("into_datagrid");
          }
        }else {
          print("into_datagrid_addcmd: ${wd.id()} ");
          wd.add_event("into_datagrid");
        }
    }else {
        print("not_found_into_datagrid: ${wd.id()} ");
    }
  }
});



  }catch(e){
    print("set_datagrid.error="+e.toString());
  }
}

Future<void> callapi_r(String s_json,String skey) async {
  try {

    print("callapi_________________________return:"+g.cmd.toString());

    String sval="";
    List<String> a,b,c;

    if (g.cmd.containsKey("save_note_tag")) {
      g.note_tag[g.cmdval("save_note_tag")]=g.cmdval("save_note_tag");
    }

    if (g.cmd.containsKey("savejs")) {
      g.jdatabase[g.cmdval("savejs")]=g.jsonx;
    }

    if (g.cmd.containsKey("savedb")) {
      try {
        List<String> arr = g.cmdval("savedb").split(",");
        List<String> a;
        arr.forEach((scol) {
          try {
            a=scol.split(".");
            g.db[a[1]] = jsonDecode(g.jsonx)[a[0]] as List;
            g.alert("db:${g.db[a[1]] }");

          } catch (e) {
            print("savedb.error." + e.toString());
          }
        });
      }catch(e){}
    }

    if (g.cmd.containsKey("set2datagrid")) {
      List<String> a=g.cmdval("set2datagrid").split(",");
      var ui=getui_bytype(skey,a[1],"gridview");
      if(ui!=null){
        gridview_ex gx=ui as gridview_ex;
        gx.eventx.add("set2datagrid");

      }

    }
    if (g.cmd.containsKey("into_datagrid")) {
      into_datagrid(skey,g.jsonx);
    }

    await api_saveto(s_json,skey);
    sval=g.cmdval("api_trigger");
    if (sval!= "") {
      g.app_stream.add(sval);
      // updateui(g.ctx());
    }
    sval=g.cmdval("app_stream");
    if (sval== "true") {
      g.app_stream.add(sval);
      // updateui(g.ctx());
    }

    Map<String, dynamic> h=new  Map<String, dynamic>();





   var tval=g.cmdval("callback_bind");
    if (tval!="") {
      int idelay=0;
      if(g.cmd.containsKey("callback_bind_delay")){
        idelay=g.cint(g.cmdval("callback_bind_delay"),0);
      }


      Future.delayed(Duration(milliseconds: idelay), () async {
        bool is_error=false;


        try {
          List l = jsonDecode(s_json)[tval] as List;

        //  g.tmsg("callback_bind:${xval} : ${l}");

          var ilen=0;
          try {
            ilen = l.length;
          }catch(e){
            is_error=true;
          }


          if(!is_error && (l.length > 0)){
            try {
              h = l[0] as Map<String, dynamic>;
            }catch(e){}

            try{
              h.forEach((k, v) {
                try{
                  g.saveiform(k, v);
                  update_field(skey,k, v);
                }catch(e){}
              });
            }catch(e){}
          }

          //g.tmsg("callback_bind:"+g.getform().toString());
        }catch(e){
          //alert("callback_bind.error="+e.toString()+s_json.toString()+" : "+h.toString());
         // g.tmsg("callback_bind.error="+e.toString()+g.jsonx.toString());

        }
      });
    }


    if (g.cmd.containsKey("api_callback_bind")) {
      try {
        List<String> a = g.cmdval("api_callback_bind").split(",");
        List<String> b;
        a.forEach((s1) {
          if(s1.contains("[")){
            b = s1.split("[");
          }else {
            b = s1.split("<");
          }
          if (b.length >= 2) {
            g.saveiform(b[0], b[1]);
            update_field(skey,b[0], b[1]);

          }
        });
        //await updateui(g.ctx());
      }catch(e){

      }
    }




    // callback_saveto
    if (g.cmd.containsKey("callback_savex")) {
      a=g.cmdval("callback_savex").split("[");
      List l = jsonDecode(s_json)[a[0]] as List;
      bool isupdatef=false;
      try {
        h = l[0] as Map<String, dynamic>;
        b=a[1].split(",");
        b.forEach((s1) {
          c=s1.split(".");
          switch(c[0]){
            case "a":
              g.papp[c[1]]=g.null2str(h[c[1]]);
              break;
            case "l":
              g.plink[c[1]]=g.null2str(h[c[1]]);
              break;
            case "v":
              g.pvar[c[1]]=g.null2str(h[c[1]]);
              break;
            case "pf":
              g.pprofile[c[1]]=g.null2str(h[c[1]]);
              break;
            case "f":
              g.saveiform(c[1], g.null2str(h[c[1]]));
              update_field(skey,c[1], g.null2str(h[c[1]]));
              isupdatef=true;
              break;
          }
        });
        if(isupdatef){
         // updateui(g.ctx());
        }
      }catch(e){}
    }


    if (g.cmd.containsKey("q_rowcount")) {
      try {
        List qrow = jsonDecode(s_json)[g.cmdval("q_rowcount")] as List;
        int row_count=0;
        try{
          row_count=qrow.length;
        }catch(e){}
        g.plink["q_rowcount"]="$row_count";
        // g.tmsg("q_rowcount=$row_count");

      } catch (e) {}
    }



    if (g.cmd.containsKey("save2db")) {
      try {
        List<String> arr = g.cmdval("save2db").split(",");
        arr.forEach((scol) {
          try {
            g.db[scol] = jsonDecode(s_json)[scol] as List;
            alert("save2db ${g.db[scol].length}");
          } catch (e) {
            print("save2db.error." + e.toString());
          }
        });
      }catch(e){}
    }
    if (g.cmd.containsKey("row2click")) {
      sval=g.cmdval("row2click");
      if(sval!=""){
        try {
          List allrow = jsonDecode(s_json)["d"] as List;
          if (allrow.length > 0) {
            sval=sval+"x";
          }else {
            sval=sval+"0";
          }
          runclick2(sval,skey);
        } catch (e) {}
      }

    }


    if (g.cmd.containsKey("save2key")) {
      try {

        List allrow = jsonDecode(s_json)["d"] as List;
        if (allrow.length > 0) {
          Map<String, dynamic> h = allrow[0] as Map<String, dynamic>;
          h.forEach((k, v) {
            g.savekey(k, v);
          });
        }

      } catch (e) {}
    }










    if (g.cmdval("callback_ojclick") != "") {
      try {

        g.active_key = skey;
        String sojclick=g.cmdval("callback_ojclick");

        try{
          List allrow= jsonDecode(s_json)["d"] as List;
          if(allrow.length > 0 ) {
            Map<String, dynamic> h = allrow[0] as  Map<String, dynamic>;
            h.forEach((key, value) {
              sojclick=sojclick.replaceAll("[j."+key+"]",value.toString());
            });
          }
        }catch(e){}

        bool isfound=false;
        List<String> s = sojclick.split(",");
        s.forEach((scol) {
          Object b = findui(scol);
          if (b != null) {
            isfound=true;
            oj2cmd(b,skey);
          }
        });
        if(!isfound){
          runclick(g.cmdval("fnullclick"),skey);
        }
      } catch (e) {
        print("callback_ojclick.error." + e);
      }
    }



    if (g.cmdval("api_rclick") != "") {
      try {


        g.active_key = skey;
        String sojclick=g.cmdval("api_rclick");
        List allrow=[];


        try{

          try {
            allrow = jsonDecode(s_json)["q_return"] as List;
          }catch(e){}
          if(allrow==null){
            allrow= jsonDecode(s_json)["d"] as List;
          }

          if(allrow.length > 0 ) {
            Map<String, dynamic> h = allrow[0] as  Map<String, dynamic>;
            h.forEach((key, value) {
              sojclick=sojclick.replaceAll("(j."+key+")",value.toString());
            });
          }
          a=g.cmdval("api_rclick_field").split(",");
          a.forEach((s1) {
            sojclick=sojclick.replaceAll("(j."+s1+")","");
          });

          sojclick=sojclick.replaceAll("(j.", "");
          sojclick=sojclick.replaceAll(")", "");


        }catch(e){}


        if(g.isdebug()){
          alert("api_rclick:"+sojclick);
        }

        bool isfound=false;
        List<String> s = sojclick.split(",");

        s.forEach((scol) {
          Object b = findui(scol);
          if (b != null) {
            isfound=true;
            oj2cmd(b, skey);
          }
        });
        if(!isfound){
          runclick(g.cmdval("fnullclick"),skey);
        }
      } catch (e) {
        print("api_rclick.error." + e);
      }
    }


    if (g.cmd.containsKey("call_backjscmd")) {
      g.run_cmd=readjscmd(g.cmdval("call_backjscmd"));
    }

    if (g.cmd.containsKey("callback_tmsg")) {
      tmsg(g.cmdval("callback_tmsg"));
    }

    if (g.cmd.containsKey("callback_bmsg")) {
      g.bmsg(g.cmdval("callback_bmsg"));
    }
    if (g.cmd.containsKey("callback_noti")) {
      g.show_noti(g.cmdval("callback_noti"));
    }


  }catch(e2){
    //alert("callapi_r.error."+e2.toString());
  }
  g.callapi_endjob=true;
}



void runclick(String sui,String skey){
  Object b = findui(sui);
  if (b != null) {
    oj2cmd(b,skey);
  }
}


findui(String sid){

  var allui;
  allui= find.byType(cmd_ex);
  String id="";
  cmd_ex b;
  for (int i = 0; i < allui.evaluate().length; i++) {
    b = allui.at(i).evaluate().single.widget as cmd_ex;
    id=b.id();
    if(id==sid ||g.active_key+"."+sid==id){
      return b;
    }
  }
   allui = find.byType(text_ex);
  text_ex b2;
  for (int i = 0; i < allui.evaluate().length; i++) {
    b2 = allui.at(i).evaluate().single.widget as text_ex;
    id=b2.id();
    if(id==sid ||g.active_key+"."+sid==id){
      return b2;
    }
  }
  return null;
}

//
// void update_datagrid(bool iscopy){
//   try{
//
//     Map<String, dynamic> griddb = new Map<String, dynamic>();
//     var allui =find.byType(gridview_ex); //find.byKey(Key(ids[1]));
//     gridview_ex wd;
//     for(int i=0; i<allui.evaluate().length; i++){
//       wd=allui.at(i).evaluate().single.widget as gridview_ex;
//       print("griddb:_____________"+griddb.toString()+":"+wd.id());
//       if(griddb.containsKey(wd.id())){
//         print("into______________grid: :"+wd.id()+":"+griddb[wd.id()]);
//         if(iscopy){
//           g.db[wd.id()]=g.db[griddb[wd.id()]];
//         }
//         g.set_gridcmd(wd.id(),"into_datagrid");
//       }
//     }
//
//
//   }catch(e){}
// }



Future<void> loadpage_waitcmd(String skey) async {
  // force run
  if(g.t_click!=""){
     await ojclick(skey,g.t_click);
    g.t_click="";
  }

  // check only page
  if(g.this_skey==skey){
    if(g.is_noti){
      //print("found_noti");
      //g.is_noti=false;
      //tmsg("found_noti_");
    }
    if(g.b_click!=""){
      ojclick(skey,g.b_click);
      g.b_click="";
    }

    if(g.page_cmd!=""){
      loopcmd(g.page_cmd,skey,false);
      g.page_cmd="";
    }

  }

  // force run
  if(g.run_cmd!=""){
    loopcmd(g.run_cmd,skey,false);
    g.run_cmd="";
  }

  // loop
    Future.delayed(const Duration(milliseconds: 500), () {
    loadpage_waitcmd(skey);
  });

}
Future<void> loadpage_jobcmd(String skey) async {
  try {

    String r = await read_textfile("job");
    if (r != "") {
      Map<String, dynamic> h = new Map<String, dynamic>();
      h = json.decode(r);
      if (h.containsKey("save2x")) {
        h.remove("save2x");
        g.savedata2(h["save2x"], h);
      }
      if (h.containsKey("app_stream")) {
        xval = h["app_stream"];
        h.remove("app_stream");
        h.forEach((skey, svalue) {
          g.papp[skey] = svalue;
        });
        g.app_stream.add(xval);
      }
      if (h.containsKey("t_click")) {
        ojclick(skey, h["t_click"].toString());
      }
      if (h.containsKey("run_cmd")) {
        loopcmd(h["run_cmd"].toString(),skey,false);
      }
      save_textfile("job","");

    }
  }catch(e){}
  Future.delayed(const Duration(milliseconds: 1000), () {
    loadpage_jobcmd(skey);
  });

}




/*
Object getui(skey,String k){

  var ui=null;
  var isfound=false;
  String a,b;
  list_ui[skey].keys.forEach((vid) {
    if(!isfound) {
      a = vid
          .split(".")
          .last
          .toLowerCase();
      b = k
          .split(".")
          .last
          .toLowerCase();
      print("compare ${a}  ${b}");
      if (a == b) {
        ui = list_ui[skey][vid];
        print("compare_found ${a}  ${b}");
        isfound = true;
      }
    }
  });




  */
/* for (int i=0; i<list_ui[skey].keys.length; i++){
   a=list_ui[skey].keys.iterator[0].toString().split(".").last;

  }*//*

  */
/*if(list_ui[skey].containsKey(k)){
   return list_ui[skey][k];
  }
  k=skey+"."+k;
  if(list_ui[skey].containsKey(k)){
    return list_ui[skey][k];
  }*//*

  return ui;
}

*/


Object getui_bylist(String skey,String k){

  var ui=null;
  var isfound=false;
  String a,b;
  list_ui[skey].keys.forEach((vid) {
    if(!isfound) {
      a = vid
          .split(".")
          .last
          .toLowerCase();
      b = k
          .split(".")
          .last
          .toLowerCase();
      print("compare ${a} : ${b}");
      if (a == b) {
        ui = list_ui[skey][vid];
        print("compare_found ${a}  ${b}");
        isfound = true;
      }
    }
  });
  return ui;
}

Object getui(String skey,String k){
  var ui=getui_bylist(skey,k);
 /* if( ui==null){
    f_readui(skey);
    ui=getuilist(skey,k);
  }*/
  return ui;
}


void update_field(skey,k,v){
  var ui=getui(skey,k);


  if(ui != null){
    if( ui is text_ex){
      (ui as text_ex).setval(v);
    }
    if(ui is textfield_ex) {
      (ui as textfield_ex).setval(v);
    }
    if(ui is textformfield_ex) {
      (ui as textformfield_ex).setval(v);
    }

    if(ui is networkimage_ex) {
      (ui as networkimage_ex).setval(v);
    }
  }else {
    if(g.isdebug()){
     // g.tmsg("bind_not_found:${k} ${skey} ${g.list_ui[skey].keys}");
    }
    print("el=${g.list_ui[skey].keys}");
  }
}



Future rcallintent(String page_key,BuildContext from_ctx,String cmd_text,String from_appid,String reqpage,String appid_req) async{

  Map<String, dynamic> rcmd=g.readcmdvar(cmd_text);


  g.active_key=page_key;

  g.print_log("event.rcallintent");
  if(g.nav != "back"){
    g.rclick="";
  }



  if(g.nav_count > 0){
    g.nav_count=g.nav_count-1;
    Navigator.pop(g.ctx(), g.q);
    return;
  }

  if(g.nav_code !="" ){
    if(g.null2str(rcmd["nav_code"])==g.nav_code){
       g.nav_code="";
    }else {
      Navigator.pop(g.ctx(), g.q);
      return;
    }
  }

  g.hide_keyboard();

  if(cmd_text.contains("back2close=true")){
    clear_pop();
    Navigator.pop(g.ctx(),g.q);
    return;
  }
  if(cmd_text.contains("back2exitapp=true")){
    close_app();
    return;
  }


if(true){
  try {




    Future.delayed(Duration(milliseconds: 200), () {
      try{
        FocusScope.of(from_ctx).unfocus();
      }catch(e){}
    });



    if(rcmd.containsKey("#k")){
      page_key=rcmd["#k"];
    }




    g.this_skey=page_key;
    print("active_key>"+g.this_skey+":"+g.list_ui[g.this_skey].toString());
    print("active_key>"+g.this_skey+":"+g.list_ui[g.this_skey].toString());

    if(g.px.containsKey(page_key)){
      g.c = new Map<String, dynamic>();
      g.px[page_key].forEach((key, value) {
        g.c[key]=value;
      });
    }



    bool iscallback=false;
    //g_ctx=from_ctx;
    // g.tmsg("cmd_text:"+cmd_text);


    if(cmd_text.contains("ret_f_readui=true")){
      await f_readui(page_key);
    }




    if(cmd_text.contains("loadapp")){
      g.appui= g.appui_org;
      g.active_appid = g.main_appid;
      g.appid_req    = main_appid;
      g.json_ui=jsonDecode(g.appui);
      g.readappconfig_fromjson();
    }

    if(g.rclick!="" || g.send_callback!=""){
      iscallback=true;
    }

    Map<String, dynamic> h=g.read_cmd(cmd_text);


   // g.tmsg("hcmd=${h}");

    if(cmd_text.contains("show_nav=false")){
     // g.add_event("show_bottombar");
    }

    String r_click=g.null2str(h["r_click"]);
    String callrclick=g.null2str(h["callrclick"]);

    if(h.containsKey("rclick")){
      r_click=g.null2str(h["rclick"]);
    }




    if(g.backcmd!=""){
      cmd(g.backcmd,page_key,false);
      g.backcmd="";
      return;
      // });
    }





    String vpage_rbind=g.getcmd(g.null2str(h["r_bind"]),page_key);
    if(g.page_rbind!=""){

        vpage_rbind=g.page_rbind;
        g.page_rbind="";
    }



    if(vpage_rbind!=""){


      Future.delayed(Duration(milliseconds:10), () async {
        try {

          vpage_rbind=getfval(page_key, vpage_rbind);
          List<String> a = vpage_rbind.split(",");
          List<String> b;

          g.print_log("page_rbind=${vpage_rbind}");


          a.forEach((s1) {
            if(s1.contains("[")){
              b = s1.split("[");
            }else {
              b = s1.split("<");
            }


           // g.tmsg("${skey}-> page_rbind=${b}");
            g.print_log("${page_key}-> page_rbind=${b}");

            if (b.length >= 2) {
              b[1]=decode_url(b[1]);
              try{
                g.saveiform(b[0], b[1]);
                update_field(page_key,b[0],b[1]);
                g.iform[page_key][b[0]]=b[1];
              }catch(e){}
            }
          });

        }catch(e){
          g.tmsg("page_rbind.error.${e}");
        }

      });



    }





    Widget wd;
    Map<String, dynamic> regisui = g.list_ui[page_key];
    if(regisui!=null){
      if(iscallback || r_click!=""){
        if(g.send_callback!=""){
          g.row_callback.forEach((vkey, vvalue) {
            g.saveiform(vkey, vvalue);
            update_field(page_key,vkey, vvalue);

            // if(g.f[skey].containsKey(vkey)){
            //   g.f[skey][vkey]=vvalue;
            // }
            // vkey=skey+"."+vkey;
            // if(g.f[skey].containsKey(vkey)){
            //   g.f[skey][vkey]=vvalue;f
            // }
          });

          // alert("rsend_callback:"+g.row_callback.toString()+" form="+g.f[skey].toString());
          //alert("rsend_callback:"+"   listui:"+g.list_ui[skey].keys.toString());

          //updateui(from_ctx);
        }

        // g.rclick ;
        if(g.rclick!=""){

       //   g.tmsg("rclick=${g.rclick}");

          int rclick_delay=g.rclick_delay;
          Future.delayed(Duration(milliseconds: rclick_delay), () {


            if(g.havekey(regisui,g.rclick)){
              oj2cmd(regisui[g.rclick],page_key);
            }else {

              g.rclick=page_key+"."+g.rclick;
              if(g.havekey(regisui,g.rclick)){
                oj2cmd(regisui[g.rclick] ,page_key);
              }else {
               // alert("not_found_:g.rclick"+g.rclick+":"+skey+":"+regisui.toString());
              }
            }
            g.rclick="";
            g.rclick_delay=100;
          });
        }

      }

      // r_click


      if(h.containsKey("rclick_delay")){
        rclick_delay=g.cint(h["rclick_delay"],rclick_delay);
      }
      Future.delayed(Duration(milliseconds: rclick_delay), () {
        if(r_click!=""){

          if(g.havekey(regisui,r_click)){
            oj2cmd(regisui[r_click],page_key);
          }else {
            r_click=page_key+"."+r_click;
            if(g.havekey(regisui,r_click)){
              oj2cmd(regisui[r_click],page_key);

            }else {
              // alert("not_found :r_click "+r_click+":"+regisui.keys.toString());
            }

          }
          r_click="";
        }
      });



      /*if(callrclick!=""){
        if (g.callrclick){
          g.callrclick=false;
          if(g.havekey(regisui,callrclick)){
            text_ex b=regisui[callrclick] as text_ex;
            cmd(b.getcmd(),skey,false);
          }else {
            callrclick=skey+"."+callrclick;
            if(g.havekey(regisui,callrclick)){
              text_ex b=regisui[callrclick] as text_ex;
              cmd(b.getcmd(),skey,false);
            }else {
              alert("not_found:callrclick"+regisui.keys.toString());
              print("regisui_key:"+regisui.keys.toString());


            }
          }
        }
        callrclick="";
      }*/



    }else {
      // alert("rcallintent_not_found_ui:"+skey);
    }

/*
    if(g.rcmd_text!=""){
      cmd(g.rcmd_text,skey,false);
      g.rcmd_text="";
    }*/

    g.send_callback="";

    loadpage_waitcmd(page_key);
    loadpage_jobcmd(page_key);


    /* if(from_appid==appid_req){
      Future.delayed(const Duration(milliseconds: 200), () {
        if(cmd_text.contains("replace_page=true")){
          g.nav="back";
          Navigator.pop(btx);
          return;
        }

      });
    }*/





  }catch(e){
    alert("do_callback.error" + e.toString());
  }

  g.showoverlay(false);
}



}
String getcmdtext(Object oj,String skey){
  try {

    if(oj is text_ex){
      return (oj as text_ex).getcmd();
    }
    if(oj is cmd_ex){
      return (oj as cmd_ex).getcmd();
    }
    return "";
  }catch(e){}
}

oj2cmd(Object oj,String skey){
  try {

    if(oj is text_ex){
      cmd((oj as text_ex).getcmd(),skey,false);
    }
    if(oj is cmd_ex){
      cmd((oj as cmd_ex).getcmd(),skey,false);
    }
    if(oj is networkimage_ex){
      cmd((oj as networkimage_ex).getcmd(),skey,false);
    }
  }catch(e){}
}

Future ojclick(String skey,String ojclick) async{
  bool isfound=false;
  try {

    //g.tmsg("fn_ojclick=${ojclick}");
    int iloop=0;

   // Map<String, dynamic> ui = new Map<String, dynamic>();
    List<String> arr=ojclick.split(",");


    try{
      if(g.list_ui.containsKey(skey)){
        g.list_ui[skey].forEach((id, value) {
          arr.forEach((s_col) {
            iloop+=1;
            if(s_col!="" && !isfound){
              print("${iloop}._ojfind: ${id}  ${s_col}");
              if(g.idmath(id,s_col)){
                print("found_id ${id}_${s_col}");
                oj2cmd(value,skey);
                isfound=true;
              }
            }
          });
        });
      }
    }catch(e){}



    if(!isfound){
      cmd_ex b;
      var allui = find.byType(cmd_ex);
      Widget wd;
      String id;
      List<String> v;
      Map<String, dynamic> tclick = new Map<String, dynamic>();

      iloop=0;

      for(int i=0; i<allui.evaluate().length; i++){
        b=allui.at(i).evaluate().single.widget;
        id=b.id();
        if(id!=""){

          g.list_ui[skey];
          arr.forEach((s_col) {
            if(s_col!=""){
              iloop+=1;
              print("${iloop}.new_ojfind: ${id}  ${s_col}");
              if(g.idmath(id,s_col)){

                cmd(b.getcmd(),skey,false);
                isfound=true;
                return isfound;

              }
            }
          });
        }
      }
    }
   // g.find_ui[skey]=ui;
  }catch(e){
    //tmsg("do_callback.error" + e.toString());
  }
  return isfound;
}



/*

Future ojclick(String skey,String ojclick) async{
  try {

    var allui = find.byType(text_ex);
    Widget wd;
    text_ex b;
    String id;
    List<String> v;
    List<String> arr=ojclick.split(",");
    Map<String, dynamic> tclick = new Map<String, dynamic>();
    for(int i=0; i<allui.evaluate().length; i++){
      b=allui.at(i).evaluate().single.widget as text_ex;
      id=b.id();
      if(id!=""){
        arr.forEach((s_col) {
          if(s_col!=""){
            print("check   ${id}  ${s_col}");
            if(g.idmath(id,s_col)){
              cmd(b.getcmd(),skey,false);
            }
          }
        });
      }
    }
  }catch(e){
    tmsg("do_callback.error" + e.toString());
  }
}
*/


Future<File> compressFile(File imageFile,int max_width) async{

  final tempDir = await path_provider.getTemporaryDirectory();
  final path = tempDir.path;
  String rand = g.newkey();

  img.Image image = img.decodeImage(imageFile.readAsBytesSync());
  img.Image smallerImage = img.copyResize(image, width: max_width);// choose the size here, it will maintain aspect ratio

  var f2 = new File('$path/img_$rand.jpg')..writeAsBytesSync(img.encodeJpg(image, quality: 85));

  return f2;


}

Future<String> upload_file(url,String skey,  Map<String, dynamic> pr) async {

  if(g.cmdval("f_wait")=="true"){
    g.show_loadding(true);
  }


  try {



    var request = http.MultipartRequest('POST', Uri.parse(url));
    print("uploadImage:"+g.q.toString()+" url:"+url);


    pr.forEach((key, value) {
      //request.fields[key] =Uri.encodeComponent(value);
      request.fields[key] = Uri.decodeComponent(value);
    });



    request.fields['guid'] = g.create_uuid();
    List<String> a=g.select_file.split(",");


    int iloop=1;
    int img_width=1024;


    if(g.cmdval("img_width")!=""){
      img_width=g.cint(g.cmdval("img_width"),img_width);
    }
    try {
      if (a.length > 0) {
        a.forEach((sfile) async {
          if(g.null2str(sfile)!=""){

            request.fields["file_name"] =Uri.encodeComponent(sfile);
            File srcfile;

            try{
              if(g.cmdval("compress_file")=="false"|| g.cmdval("compress_file")=="no"){
                srcfile = File(sfile);
              }else {
                srcfile = await compressFile(File(sfile), img_width);
              }
            }catch(e){
              srcfile = File(sfile);
            }


            var stream = await new http.ByteStream(
                DelegatingStream.typed(srcfile.openRead()));
            var length = await srcfile.lengthSync();
            var mfile = await new http.MultipartFile(
                "file_" + iloop.toString(), stream, length,
                filename: "file_" + iloop.toString());

          //  g.bmsg("file_upload =${mfile}");

            await request.files.add(mfile);

            iloop += 1;

          }
        });
      }
    }catch(e){}

    final rx = await request.send();
    final ret = await rx.stream.bytesToString();

    g.callapi_ok=(rx.statusCode == 200);


    return ret;


  }catch(e){
    g.bmsg("uploadImage.error."+e.toString());
  }

}

Future<String> upload_img_v1(url) async {
  try {



    var request = http.MultipartRequest('POST', Uri.parse(url));
    print("uploadImage:"+g.q.toString()+" url:"+url);
    g.q.forEach((key, value) {
      request.fields[key] = value;
    });

    request.fields['guid'] = g.create_uuid();
    List<String> a=g.select_file.split(",");
    int iloop=1;

    List<MultipartFile> list;
    a.forEach((sfile) async {
      var tfile=await http.MultipartFile.fromPath('file'+iloop.toString(), sfile);
      list.add(tfile);
      iloop+=1;
    });

    request.files.addAll(list);

    var res = await request.send();
    final rx = await http.Response.fromStream(res);
    return rx.body;

  }catch(e){}


}


Future uploadmultipleimage(str_url) async {


  try {
    http.MultipartRequest request = new http.MultipartRequest(
        'POST', Uri.parse(str_url));

    request.fields['user_id'] = '10';
    request.fields['post_details'] = 'dfsfdsfsd';

    List<MultipartFile> newList = new List<MultipartFile>();


    List<String> a = g.select_file.split(",");
    a.forEach((sfile) async {
      File imageFile = File(sfile);
      var stream =
      new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = new http.MultipartFile("imagefile", stream, length,
          filename: path.basename(imageFile.path));
      newList.add(multipartFile);
    });


    request.files.addAll(newList);
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }catch(e){
    alert("uploadmultipleimage.error."+e.toString());
  }


}

Future<String> uploadImage2(url) async {
  try {

    var request = http.MultipartRequest('POST', Uri.parse(url));

    print("uploadImage:"+g.q.toString()+" url:"+url);
    g.q.forEach((key, value) {
      request.fields[key] = value;
    });

    request.fields['guid'] = g.create_uuid();


    List<String> a=g.select_file.split(",");
    int iloop=1;
    List<MultipartFile> newList = new List<MultipartFile>();

    a.forEach((sfile) async {

      File imageFile = File(sfile);
      var stream =
      new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = new http.MultipartFile("imagefile", stream, length,
          filename: path.basename(imageFile.path));
      newList.add(multipartFile);
      iloop+=1;

    });
    tmsg("call upload "+newList.toString());
    request.files.addAll(newList);
    var res = await request.send();
    final rx = await http.Response.fromStream(res);
    return rx.body;


  }catch(e){}


}

//
// Future uploadmultipleimage(List images) async {
//   var uri = Uri.parse("");
//   http.MultipartRequest request = new http.MultipartRequest('POST', uri);
//   request.headers[''] = '';
//   request.fields['user_id'] = '10';
//   request.fields['post_details'] = 'dfsfdsfsd';
//   //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
//   for (int i = 0; i < images.length; i++) {
//     var multipartFile = request.files.add(await http.MultipartFile.fromPath('file'+i.toString(), 'file'+i.toString()));
//
//
//     newList.add(multipartFile);
//   }
//   request.files.addAll(newList);
//   var response = await request.send();
//   if (response.statusCode == 200) {
//     print("Image Uploaded");
//   } else {
//     print("Upload Failed");
//   }
//   response.stream.transform(utf8.decoder).listen((value) {
//     print(value);
//   });
// }
//






f_apple_login() async {
  try{



    final r = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );


    g.plink["x_uid"]=r.userIdentifier;
    g.plink["x_email"]=r.email;
    g.plink["x_name"]=r.givenName;

    if (g.cmd.containsKey("f_click")){
      g.t_click=g.cmdval("f_click");
    }
    if (g.isdebug()){
      alert("login_info:${g.plink}");
    }



  }catch(e){}

}


Future f_google_login() async {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );


  try {
    g.googleUser = await _googleSignIn.signInSilently() ?? await _googleSignIn.signIn();


    g.plink["x_uid"]=googleUser.id;
    g.plink["x_email"]=googleUser.email;
    g.plink["x_name"]=googleUser.displayName;
    g.plink["x_photo_url"]=googleUser.photoUrl;

    if (g.cmd.containsKey("f_click")){
      g.t_click=g.cmdval("f_click");
    }
    if (g.isdebug()){
      alert("login_info:${g.plink}");
    }

  } catch (e) {
    if(g.isdebug()){
      g.alert("google_login_error:${e}");
    }
  }


}

f_google_logoff() async {
  try{

    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    g.googleUser = null;


    /*bool isSigned = await google_login.isSignedIn();
    if(isSigned){
      await google_login.signOut();
    }*/
  }catch(e){}

}


f_phone_login(){
  try {

    g.tmsg("phone: ${g.cmdval("phone_number")}");
    String y_click = g.cmdval("y_click");
    String n_click = g.cmdval("n_click");
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: g.cmdval("phone_number"),
        timeout: const Duration(seconds: 5),
        verificationCompleted: (firebaseUser) {
          var u = FirebaseAuth.instance.currentUser;
          g.plink["flogin_email"] = u.email;
          g.plink["flogin_name"] = u.displayName;
          g.plink["flogin_id"] = u.uid;
          g.plink["flogin_photourl"] = u.photoURL;
          g.plink["flogin_phone_number"] = u.phoneNumber;
          g.t_click = y_click;
          //
        },
        verificationFailed: (error) {
          g.t_click = n_click;
        },
        codeSent: (verificationId, [forceResendingToken]) {
          print(verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          //
        });
  }catch(e){}
}

f_phone_send_confirm() async {

  FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential user = await _auth.signInWithCredential(PhoneAuthProvider.credential(
      verificationId: g.cmdval("vid"), smsCode:g.cmdval("smdcode")));

}



Future<void> f_getfile(String skey,String stag) async {


  try {
    int file_limit = 6;
    int fcount = 0;

    g.select_file = "";
    g.select_filetype = "image";
    String bind_field=g.cmdval("bind_field");


    final ImagePicker _picker = ImagePicker();

    if (g.cmdval("img_src") == "camera") {

      final select_file = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: g.null2dbl(g.cmdval("img_width"), 1024),
        maxHeight: g.null2dbl(g.cmdval("img_height"), 1024),
      );
      g.select_file = select_file.path;

    }
    else if (g.cmdval("img_src") == "file") {

      final select_file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: g.null2dbl(g.cmdval("img_width"), 1024),
        maxHeight: g.null2dbl(g.cmdval("img_height"), 1024),
      );
      g.select_file = select_file.path;

    } else {

      if (stag == "#") {


      } else {

        String sfiletype=g.cmdval("file_type");
        var filetype = FileType.image;
        switch (sfiletype) {
          case "vdo":
            filetype = FileType.video;
            break;
          case "audio":
            filetype = FileType.audio;
            break;
          case "any":
            filetype = FileType.any;
            break;
          case "image":
            filetype = FileType.image;
            break;
          case "media":
            filetype = FileType.media;
            break;
          case "custom":
            filetype = FileType.custom;
            break;
        }



        if (g.cmd.containsKey("file_limit")) {
          file_limit = g.cint(g.cmd["file_limit"], 10);
        }
        // g.tmsg("file_limit=${file_limit}");
        double resize_width=g.cdbl(g.cmdval("resize_width"), 800.0);

        switch (g.cmdval("img_select_tool")) {
          case "1":
            final List<XFile> images = await _picker.pickMultiImage(
                maxWidth: g.null2dbl(g.cmdval("img_resize"), resize_width),
                maxHeight: g.null2dbl(g.cmdval("img_resize"), resize_width)
            );

            fcount=0;
            images.forEach((file) {
              if (fcount < file_limit) {
                g.select_file += file.path + ",";
              }
              fcount+=1;
            });

            break;

          case "2":

            try {
              List<Asset> resultList = <Asset>[];
              List<Asset> images = <Asset>[];

              int get_photo_delay=g.cint(g.cmdval("get_photo_delay"), 600);
              resultList = await MultiImagePicker.pickImages(
                maxImages: file_limit,
                enableCamera: true,
                selectedAssets: images,
             //   cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
                materialOptions: MaterialOptions(
                  actionBarTitle: "Get Photo",
                  allViewTitle: "All Photos",
                  useDetailsView: false,
                  selectCircleStrokeColor: "#000000",
                ),
              );
              g.select_file="";
              await getfilepath(resultList,0);
              await Future.delayed(Duration(milliseconds:get_photo_delay));

            } on Exception catch (e) {
            }
            break;
          default:


            bool is_mutiple = true;
            // g.tmsg("stag=${stag}");
            if (stag == "1") {
              is_mutiple = false;
            }


            FilePickerResult result = await FilePicker.platform.pickFiles(
                type: filetype,
                allowMultiple: is_mutiple,
                allowCompression: true);



            if (result != null) {


              List<File> files = result.paths.map((path) => File(path))
                  .toList();


              if (g.cmd.containsKey("img_resize") && sfiletype != "vdo") {

                int resize_width=g.cint(g.cmdval("resize_width"), 1024);
                final tempDir = await getTemporaryDirectory();
                final path = tempDir.path;
                files.forEach((tfile) {
                  if (fcount < file_limit) {
                    String rand = g.newkey();
                    Img.Image image = Img.decodeImage(tfile.readAsBytesSync());
                    Img.Image smallerImg = Img.copyResize(
                        image, width: g.null2int(g.cmdval("img_resize"), resize_width));
                    File cfile = new File("$path/image_$rand.jpg")
                      ..writeAsBytesSync(
                          Img.encodeJpg(smallerImg, quality: 100));
                    g.select_file += cfile.path + ",";
                    fcount += 1;
                  }
                });

              }
              else if(sfiletype=="vdo"){

                fcount=0;
                files.forEach((tfile) {
                  if (fcount < file_limit) {
                    g.select_file += tfile.path + ",";
                  }
                  fcount+=1;
                });
              }
              else {

                fcount=0;
                files.forEach((tfile) {
                  if (fcount < file_limit) {
                    g.select_file += tfile.path + ",";
                  }
                  fcount+=1;
                });

              }
            }
            break;
        }
        g.select_file = g.rcut(g.select_file);
      }
    }



    if (g.cmd.containsKey("resize")) {

      int resize_width=g.cint(g.cmdval("resize"),1024);
      List<String> l=  g.select_file.split(",");
      File f;
      g.select_file="";
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      l.forEach((tfile) {

        f=File(tfile);


        String rand = g.newkey();
        Img.Image image = Img.decodeImage(f.readAsBytesSync());
        Img.Image smallerImg = Img.copyResize(
            image, width: resize_width);
        File cfile = new File("$path/image_$rand.jpg")
          ..writeAsBytesSync(
              Img.encodeJpg(smallerImg, quality: 100));
        g.select_file += cfile.path + ",";



      });


    }

    if(g.cmdval("image_tag")=="crop"){

      File croppedFile = await ImageCropper().cropImage(
          sourcePath: g.select_file,
          aspectRatioPresets: Platform.isAndroid
              ? [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
              : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            title: 'Cropper',
          ));

      g.select_file=croppedFile.path;

    }




    // set file_limit
    try{
      if(g.select_file.split(",").length > file_limit){
        fcount=0;
        List<String> a=g.select_file.split(",");
        g.select_file="";
        a.forEach((str_file) {
          if (fcount < file_limit) {
            g.select_file += str_file + ",";
          }
          fcount+=1;
        });
        g.select_file = g.rcut(g.select_file);
      }
    }catch(e){}


    print("g.select_file=" + g.select_file);
    g.plink["select_file"] = g.select_file;

    if(bind_field!=""){


      bool isfound_ui=false;
      g.saveiform(bind_field,g.select_file);
      var  allui = find.byType(text_ex);
      text_ex txtex;
      for (int i = 0; i < allui.evaluate().length; i++) {
        txtex = allui.at(i).evaluate().single.widget;
        if(g.idmath(bind_field, txtex.id())){
          isfound_ui=true;
          g.saveiform(bind_field, g.select_file);
          update_field(skey,bind_field,g.select_file);
        }
      }
      if(!isfound_ui){

        allui = find.byType(textfield_ex);
        textfield_ex txtf;
        for (int i = 0; i < allui.evaluate().length; i++) {
          txtf = allui.at(i).evaluate().single.widget;
          if(g.idmath(bind_field, txtf.id())){
            isfound_ui=true;
            g.saveiform(bind_field, g.select_file);
            update_field(skey,bind_field,g.select_file);
          }
        }
      }




    }
  }catch(e){}


}

getfilepath(List<Asset> resultList,int ifile){
/*
  if(resultList.length > ifile){
   // FlutterAbsolutePath.getAbsolutePath(resultList[ifile].identifier).then((value){
      g.select_file+=value+",";
      if (resultList.length > ifile){
        return getfilepath(resultList,ifile+1);
      }
   // });
  }*/
  return getfilepath(resultList,ifile+1);


}

Future<String> getImageFileFromAssets(Asset asset) async {

  final byteData = await asset.getByteData();
  final tempFile =
  File("${(await getTemporaryDirectory()).path}/${asset.name}");
  final file = await tempFile.writeAsBytes(
    byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
  );
  return file.path.toString();
}


getDeviceID() async {
  String deviceId = g.null2str(g.getk("device_id"));
  if(deviceId==""){
    deviceId=g.genkey();
    g.savekey("deviceId",deviceId);
  }
  return deviceId;
}


Future<Null> _selectDate(BuildContext context) async {
  DateTime selectedDate = DateTime.now();
  final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate
  );

  if(picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
}
void f_ncmd(String skey){

  if(g.cmdval("nmsg")!=""){
    alert(g.cmdval("nmsg"));
  }
  if(g.cmdval("ncmd_click")!=""){
    ojclick(skey,g.cmdval("ncmd_click"));
  }
  if(g.cmdval("n_msg")!=""){
    alert(g.cmdval("n_msg"));
  }

}


void readrcheck(String skey,vcmdtext) {


  List<String>a = vcmdtext.split(",");
  List<String>b;
  String sval="";
  var allui = find.byType(gridview_ex);

  gridview_ex wd;
  Map<String, dynamic> h = new Map<String, dynamic>();


  String rcheck_field=g.cstr(g.cmdval("rcheck_field"),"data");
  String s="";
  for (int i = 0; i < allui.evaluate().length; i++) {
    wd = allui.at(i).evaluate().single.widget as gridview_ex;

    a.forEach((s1) {
      b=s1.split("[");
      if(g.ischeckid(skey, wd.id(), b[0])){
        wd.dt.forEach((h1) {
          h=h1;
          sval=g.null2str(h["rcheck"]);
          if(sval=="1"){
            s+=g.null2str(h[rcheck_field])+",";
          }
        });
        s=g.rcut(s);
        g.plink[b[1]]=s;
        //alert(g.genkey()+" readrcheck "+ g.plink.toString()+"="+b[1]);
      }
    });
  }


}

void clearval(String vcmdtext){
  try {
    List<String> a, b;
    a = vcmdtext.split(",");
    a.forEach((s1) {
      b = s1.split(".");
      switch (b[0]) {
        case "v":
          if (g.pvar.containsKey(b[1])) {
            g.pvar.remove(b[1]);
          }else if(b[1]=="*"){
            g.pvar.clear();
          }
          break;
        case "l":
          if (g.plink.containsKey(b[1])) {
            g.plink.remove(b[1]);
          }else if(b[1]=="*"){
            g.plink.clear();
          }
          break;
        case "jd":
          if (g.jd.containsKey(b[1])) {
            g.jd.remove(b[1]);
          }else if(b[1]=="*"){
            g.jd.clear();
          }
          break;
        case "sys":
          if (g.sys.containsKey(b[1])) {
            g.sys.remove(b[1]);
          }else if(b[1]=="*"){
            g.sys.clear();
          }
          break;
        case "s":
          if (g.sys.containsKey(b[1])) {
            g.sys.remove(b[1]);
          }else if(b[1]=="*"){
            g.sys.clear();
          }
          break;
        case "b":
          if (g.pback.containsKey(b[1])) {
            g.pback.remove(b[1]);
          }else if(b[1]=="*"){
            g.pback.clear();
          }
          break;
        case "fx":
          if (g.fx.containsKey(b[1])) {
            g.fx.remove(b[1]);
          }else if(b[1]=="*"){
            g.fx.clear();
          }
          break;
        case "a":
          if (g.papp.containsKey(b[1])) {
            g.papp.remove(b[1]);
          }else if(b[1]=="*"){
            g.papp.clear();
          }
          break;
      }
    });
  }catch(e){}


}




per_req(String sreq) async {
  try{

    List<Permission> p=[];
    Map<String, dynamic> h = new Map<String, dynamic>();  //call intent
    String x="";
    Permission.values.forEach((pv) {
      x=pv.toString().toLowerCase();
      x=x.replaceAll("permission.", "");
      h[x]=pv;
    });
    List<String> a=sreq.split(",");
    a.forEach((s1) {
      if(h.containsKey(s1)){
        p.add(h[s1]);
      }
    });
    Map<Permission, PermissionStatus> rt = await p.request();

  }catch(e){}
}
void cmd(String cmd_text, String skey,bool isinit ){
  if(!g.isrun){

    if(cmd_text.contains("cmd_info=")){
      cmd_text=cmd_text.replaceAll("cmd_info=","");
      cmd_text=g.null2str(g.info[cmd_text]);
    }

    if(cmd_text.contains("no2time")){
      if(g.str_cmd!=cmd_text){
        loopcmd(cmd_text,skey,isinit);
        g.str_cmd=cmd_text;
      }
    }else {
      loopcmd(cmd_text,skey,isinit);
    }
  }
}

clear_pop(){
  try{
    g.cmd.clear();
  }catch(e){}
}
void loopcmd(String s, String skey,bool isinit){
  g.allcmd=s.split("||");

  print("allcmd=${g.allcmd}");

  g.cmd_index=0;
  runcmd(g.allcmd[g.cmd_index],skey,isinit);

/*  g.allcmd.forEach((cmd_text) async {
    try {
      await runcmd(cmd_text,skey,isinit,0);
    }catch(e){}
  });*/
}

Future<Directory> getDownloadDirectory() async {
  if (Platform.isAndroid) {
   // return await DownloadsPathProvider.downloadsDirectory;
  }
  return await getApplicationDocumentsDirectory();
}

Future<String> downloadFile(String file_url ,Map<String, dynamic> h) async {

  int pdownload=0;
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
    //add more permission to request here.
  ].request();

  bool is_end=false;

  if(statuses[Permission.storage].isGranted){

    String extname=get_extname(file_url);
    final dir = await getDownloadDirectory();
    final savePath = path.join(dir.path, "file_${g.get_datetime_id()}.${extname}");

    await dio.Dio().download(
        file_url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {

            pdownload=(received / total * 100).toInt();
            print("Download: ${pdownload} %");
            if(pdownload==100){
              if(h.containsKey("f_click")){
                if(!is_end){
                  is_end=true;
                  g.t_click=g.null2str(h["f_click"]);
                }
              }
            }
          }else {
            g.tmsg("Save file:${savePath}");
          }
        });

  }


}

Future<void> onStart_service() async {


  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  String str_status="";
  service.onDataReceived.listen((event) {
    if (event["action"] == "setAsForeground") {
      service.setForegroundMode(true);
      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });


  // bring to foreground

  String service_mode=g.read_cfg("show_service");
  if(service_mode=="true"){
    service.setForegroundMode(true);
  }else {
    service.setForegroundMode(false);
  }


  Timer.periodic(Duration(seconds: 5), (timer) async {
   // if (!(await service.isServiceRunning())) timer.cancel();
     str_status="";

   // g.tmsg("service_mqtt_status:${gmqtt_service.connectionStatus.state}");


    try{
       if (gmqtt_service.connectionStatus.state == MqttConnectionState.connected) {
         str_status="."+g.service_mqtt_server+":"+g.service_mqtt_sub;
       }else {
         service_mqtt_connect(service);
       }
     }catch(e){}

    String dt = DateFormat('H:mm:ss').format(DateTime.now());
    service.setNotificationInfo(
      title: "Connect"+str_status,
      content: "${dt}: ${service_msg}",
    );
    //print("f_service : ${mqtt_service.connectionStatus}");
    service.sendData(
      {"current_date": DateTime.now().toIso8601String()},
    );

  });
  service_mqtt_connect(service);

}


service_mqtt_connect(FlutterBackgroundService service) async {

  try{
    await g.gmqtt_service.disconnect();
  }catch(e){}


  await g.readappconfig_fromdb();
  g.readlogin();

  if(g.login_id!=""){
    try {
      String s = g.read_cfg(
          "mqtt_connect"); //"mqtt_server=223.27.210.227;mqtt_sub=app/noti;mqtt_tmsg=true;";//g.read_cfg("mqtt_connect");
      Map<String, dynamic> tcmd = new Map<String, dynamic>();
      tcmd = g.read_cmd(s);

      //print("service_mqtt_connect=${s}");

      var gval = "";
      int mqtt_port = g.cint(g.null2str(tcmd["mqtt_port"]), 1883);
      g.service_mqtt_server =
          g.null2str2(g.null2str(tcmd["mqtt_server"]), "broker.emqx.io");
      String mqtt_clientname = g.null2str2(
          g.null2str(tcmd["mqtt_client_name"]), "client_" + g.newkey());

      g.service_mqtt_sub = g.null2str(tcmd["mqtt_sub"]);
      g.service_mqtt_sub =
          g.service_mqtt_sub.replaceAll("{login_id}", g.login_id);


      print("mqtt_service:${g.service_mqtt_server}");
      print("mqtt_service_login_id=${g.login_id}");
      print("mqtt_sub=${g.service_mqtt_sub}");

      gmqtt_service = new MqttServerClient.withPort(
          g.service_mqtt_server, mqtt_clientname, mqtt_port);
      gmqtt_service.logging(on: true);
      gmqtt_service.onConnected = mqtt_connected;
      gmqtt_service.onDisconnected = mqtt_disconnected;
      gmqtt_service.onUnsubscribed = mqtt_onUnsubscribed;
      gmqtt_service.onSubscribed = mqtt_onSubscribed;
      gmqtt_service.onSubscribeFail = mqtt_onSubscribeFail;
      gmqtt_service.pongCallback = mqtt_pong;
      gmqtt_service.autoReconnect = true;


      await gmqtt_service.connect();
      gmqtt_service.autoReconnect = true;


      List<String> a = g.service_mqtt_sub.split(",");
      a.forEach((s1) {
        gmqtt_service.subscribe(s1, MqttQos.atLeastOnce);
      });


      gmqtt_service.updates.listen((
          List<MqttReceivedMessage<MqttMessage>> c) async {
        final MqttPublishMessage message = c[0].payload;
        final payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
        // alert('Received message:$payload from topic: ${c[0].topic}>');
        String dt = DateFormat('mm:ss').format(DateTime.now());
        g.mqtt_msg = utf8.decode(payload.runes.toList());
        service_msg = g.mqtt_msg;


        try {
          Map<String, dynamic> h = json.decode(service_msg);
          mqtt_cmd("background", h);
          print("mqtt_background:${h}");
        } catch (e) {}

        service.setNotificationInfo(
          title: "Message",
          content: "${dt}: ${g.service_msg}",
        );
      });


    }catch(e){
      print("mqtt.connect.error.${e}");
    }

  }else {
    try{
      service.stopBackgroundService();
    }catch(e){}
  }



}




/*
service_mqtt_connect(FlutterBackgroundService service) async {

  try{
    await g.gmqtt_service.disconnect();
  }catch(e){}

  String gval="";

  await g.readappconfig2();
  try {
    gval = await g.read_textfile("cfg");
    cfg_app = jsonDecode(gval);

   // g.tmsg("cfg_app=${cfg_app}");
  }catch(e){
    g.tmsg("read textfile error${e}");
  }


  g.readlogin();


  if(g.login_id!=""){

    String s=g.read_cfg("mqtt_connect");//"mqtt_server=223.27.210.227;mqtt_sub=app/noti;mqtt_tmsg=true;";//g.read_cfg("mqtt_connect");
    s=s.replaceAll("{login_id}",g.login_id);

    Map<String, dynamic> tcmd = new Map<String, dynamic>();
    tcmd=g.read_cmd(s);


    g.tmsg("tcmd=$tcmd");
    logx("tcmd=$tcmd");

    var gval = "";
    int mqtt_port = g.cint(g.null2str(tcmd["mqtt_port"]), 1883);
    g.service_mqtt_server = g.null2str2(g.null2str(tcmd["mqtt_server"]), "broker.emqx.io");
    String mqtt_clientname = g.null2str2(
        g.null2str(tcmd["mqtt_client_name"]), "client_" + g.newkey());

    g.service_mqtt_sub=g.null2str(tcmd["mqtt_sub"]);
    g.service_mqtt_sub=g.service_mqtt_sub.replaceAll("{login_id}", g.login_id);


    print("mqtt_service:${g.service_mqtt_server}");
    print("mqtt_service_login_id=${g.login_id}");
    print("mqtt_sub=${g.service_mqtt_sub}");

    gmqtt_service =  new MqttServerClient.withPort(g.service_mqtt_server, mqtt_clientname, mqtt_port);
    gmqtt_service.logging(on: true);
    gmqtt_service.onConnected = mqtt_connected;
    gmqtt_service.onDisconnected = mqtt_disconnected;
    gmqtt_service.onUnsubscribed = mqtt_onUnsubscribed;
    gmqtt_service.onSubscribed = mqtt_onSubscribed;
    gmqtt_service.onSubscribeFail = mqtt_onSubscribeFail;
    gmqtt_service.pongCallback = mqtt_pong;
    gmqtt_service.autoReconnect = true;


    await gmqtt_service.connect();
    gmqtt_service.autoReconnect=true;



    List<String> a=g.service_mqtt_sub.split(",");
    a.forEach((s1) {
      gmqtt_service.subscribe(s1, MqttQos.atLeastOnce);
    });


    gmqtt_service.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) async {

      final MqttPublishMessage message = c[0].payload;
      final payload =
      MqttPublishPayload.bytesToStringAsString(message.payload.message);
      // alert('Received message:$payload from topic: ${c[0].topic}>');
      String dt = DateFormat('mm:ss').format(DateTime.now());
      g.mqtt_msg=utf8.decode(payload.runes.toList());
      service_msg=g.mqtt_msg;



      try {
        Map<String, dynamic> h = json.decode(service_msg);
        mqtt_cmd("background",h);
        print("mqtt_background:${h}");
      }catch(e){}

      service.setNotificationInfo(
        title: "Message",
        content: "${dt}: ${g.service_msg}",
      );


    });
  }else {
    try{
      service.stopBackgroundService();
    }catch(e){}
  }



}

*/


mqtt_cmd(String stag,Map<String, dynamic> h) async {
  if(g.null2str(h["this_cmd"])=="true"){


    save_textfile("job",json.encode(h).toString());
    if(g.null2str(h["_debug"])=="true"){
     g.tmsg(stag+" mqtt:${h}");
    }
    try {
      String sval = "";
      if (h.containsKey("noti_title")) {
        g.local_noti(g.null2str(h["noti_title"]), g.null2str(h["noti_detail"]),
            g.null2str(h["noti_tag"]), g.null2str(h["noti_img"]));
      }
      if (h.containsKey("play_sound")) {
        await playsound(g.null2str(h["play_sound"]));
      }

      if (h.containsKey("tmsg")) {
        g.tmsg(g.null2str(h["tmsg"]));
      }

      /*if (h.containsKey("t_click"))
      {
        g.t_click=g.null2str(h["t_click"]);
        g.savekey("t_click", g.t_click);
      }*/
      if (h.containsKey("run_cmd")) {
        g.run_cmd=g.null2str(h["run_cmd"]);
      }

    }catch(e){}
  }
}


Future<void> call_service(String msg,String skey) async {
if(enable_service) {
  try {
    List<String> l = msg.split(",");
    switch (l[0]) {
      case "start":
        FlutterBackgroundService.initialize(onStart_service);
        break;
      case "stop":
        var isRunning =
        await FlutterBackgroundService().isServiceRunning();
        if (isRunning) {
          FlutterBackgroundService().sendData(
            {"action": "stopService"},
          );
        }
        break;
      case "restart":
        try {
          var isRunning =
          await FlutterBackgroundService().isServiceRunning();
          if (isRunning) {
            FlutterBackgroundService().sendData(
              {"action": "stopService"},
            );
          }
        } catch (e) {}
        Future.delayed(Duration(milliseconds: 1000), () async {
          await FlutterBackgroundService.initialize(onStart_service);
        });
        break;
      case "mode_b":
        FlutterBackgroundService().sendData({"action": "setAsBackground"});
        break;
      case "mode_f":
        FlutterBackgroundService().sendData({"action": "setAsForeground"});
        break;
      default:
        break;
    }
  } catch (e) {}
}

}

//main.function

start_save_sound() async {

  try{


    g.recordingSession = FlutterSoundRecorder();
    await g.recordingSession.openRecorder();
    await g.recordingSession.setSubscriptionDuration(Duration(milliseconds: 10));
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();



    String pathToAudio = '/sdcard/Download/temp.wav';
    g.recordingSession = FlutterSoundRecorder();




    Directory directory = Directory(path.dirname(pathToAudio));

    if (!directory.existsSync()) {
      //directory.createSync();
    }
    g.recordingSession.openRecorder();
    await g.recordingSession.startRecorder(
      toFile:pathToAudio,
    );

    StreamSubscription _recorderSubscription =
    g.recordingSession.onProgress.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(
          e.duration.inMilliseconds,
          isUtc: true);
      var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);

    });
    _recorderSubscription.cancel();

  }catch(e){
    g.alert("start_save_sound.error.${e}");
  }

}


void f_loop(Map<String, dynamic> tcmd){

     int idelay=g.cint(g.null2str(tcmd["f_loop_timer"]),5000);
     Future.delayed(Duration(milliseconds: idelay), () async {
        g.t_click=g.null2str(tcmd["loop_t_click"]);
        f_loop(tcmd);
     });


}




f_showinfo(vcmdtext,skey){
  List<String> l=vcmdtext.split(",");
  l.forEach((s) {
    switch(s){

      case "l":
        alert(g.active_key+"link=${iform[g.plink]}");
        break;

      case "form":
        alert(g.active_key+"_form=${iform[g.active_key]}");
        break;

    }

  });
}

f_get_location() async {

  String google_key = g.cmdval("google_key");




  //-------------


/*  geo.LocationResult result = await Navigator.of(g.ctx()).push(
      MaterialPageRoute(builder: (context) => PlacePicker(google_key)));*/

//g.alert("${result}");

//----------------

  var googlePlace = GooglePlace(google_key);
  var r2 = await googlePlace.queryAutocomplete.get("pizza near sydne");

  g.alert("${r2}");

 /* try {
    String google_key = g.cmdval("google_key");

    final headers = <String, String>{
      if (defaultTargetPlatform == TargetPlatform.iOS)
        'x-ios-bundle-identifier': g.packet_name, // com.my.app
      if (defaultTargetPlatform == TargetPlatform.android) ...{
        'x-android-package':g.packet_name, // com.my.app
        'x-android-cert':g.android_sha, // signing key used to build/publish the app
      }
    };

    g.tmsg("google_key=${headers}");

    var googlePlace = GooglePlace(google_key,headers: headers);
     var result = await  googlePlace.search.getFindPlace(
         "Museum of Contemporary Art Australia", InputType.TextQuery);
// await googlePlace.search.getFindPlace(g.cmdval("search_text"), InputType.TextQuery);
    g.alert("${result}");
  }catch(e){
    g.bmsg("f_get_location.error.${e}");
  }*/

}

f_bind(String vcmdtext,String skey){
  try {

    var allui;
    xval=vcmdtext;
    xval=xval.replaceAll("<<", "{").replaceAll(">>", "}");
    xval=g.getcmd(xval,skey);

    //g.tmsg("call f_gind ${xval}");

    List<String> a = xval.split(",");
    List<String> b;
    a.forEach((s1) {
      if (s1.contains("[")) {
        b = s1.split("[");
      } else {
        b = s1.split("<");
      }
      if (b.length >= 2) {
        b[1]=g.decode_url(b[1]);
      //  g.tmsg("f_bind ${b}");

        try {
          g.saveiform(b[0], b[1]);
          update_field(skey, b[0], b[1]);
          g.iform[g.active_key][b[0]] = b[1];
        }catch(e){}

      }
    });

    //await updateui(g.ctx());
  } catch (e) {

  }
}



f_nav_exit(String vcmdtext){

  if(vcmdtext==""){
    vcmdtext=g.vcmdtext;
  }

  g.nav = "back";
  g.cr.clear();
  g.cmd.forEach((key, value) {
    g.cr[key]=value;
  });

  if (vcmdtext != "true") {
    g.rclick = vcmdtext;
  }
  if (g.c.containsKey("wait_page_active")) {
    g.wait_page_active(
        g.cint(g.null2str(g.c["wait_page_active"]), 400));
  }
  if (g.c.containsKey("nav_delay")) {
    g.wait_page_active(g.cint(g.null2str(g.c["nav_delay"]), 400));
  }
  clear_pop();
  Navigator.pop(g.ctx(), g.q);
}

void runcmd(String cmd_text, String skey,bool isinit ) {
 var can_run=true;
 var tcmd=g.read_cmd(cmd_text);
 if(tcmd.containsKey("cmd_fixtime")){
   int cmd_fixtime=g.cintx(tcmd["cmd_fixtime"]);
   DateTime now = DateTime.now();
   if(g.run_time == null){
     g.run_time=now;
   }
   if (now.difference(g.run_time) < Duration(milliseconds: cmd_fixtime)) {
     g.tmsg("wait..");
     can_run=false;
   }
   g.run_time=now;
 }


 g.papp["new_guid"]=g.create_uuid();
 if(cmd_text.contains("runone=true")){
   if(g.last_cmd==cmd_text){
     can_run=false;
   }
 }

 if(cmd_text.contains("cmd_onetime=true")){
   if(!g.cmd_onetime){
     g.cmd_onetime=true;
   }else {
     can_run=false;
   }
 }


 if(cmd_text.trim()==""){
  // g.alert("src_cmd=${cmd_text}");
   can_run=false;
 }


 if(cmd_text.contains("pause_cmd=")){
   var c= g.read_cmd(cmd_text);
   var itime=g.cintx(c["pause_cmd"]);

   if(g.last_cmd != cmd_text){
     can_run=true;
     g.last_cmd=cmd_text;
     Future.delayed(Duration(milliseconds: itime), () async {
       g.last_cmd="";
     });

   }else {
     can_run=false;
     print("pause_cmd");

   }


 }

 if(cmd_text.contains("fix_dblclick=true")){
   if(g.last_cmd==cmd_text){
     can_run=false;
   }
 }


if(cmd_text.contains("dbl_cmd=false")){
 // if(g.init0_req){
    if(g.last_cmd==cmd_text){
      can_run=false;
      g.init0_req=false;
    }
 // }
}


 print("${can_run} runcmd= ${skey}: $cmd_text");

 if(can_run) {

   g.pvar["new_guid"]=g.create_uuid();
   g.last_cmd=cmd_text;
   var xval = "";
   try {
     print("src_cmd= ${skey}: $cmd_text");

     if ((cmd_text.contains("regisui=true"))) {
       Future.delayed(Duration(milliseconds: 0), () async {
         if (!g.is_regisui.containsKey(skey)) {
           // g.tmsg(" find regis ui");
           f_readuicmd(skey, "");
           g.is_regisui[skey] = true;
         }
       });
     }
     cmd_text = cmd_text.replaceAll("{info_os}", g.getos());
     cmd_text = cmd_text.replaceAll("{os}", g.getos());
     cmd_text = cmd_text.replaceAll("{k}", skey);
     cmd_text = cmd_text.replaceAll("{x.login_id}", g.login_id);
     cmd_text = cmd_text.replaceAll("{x.gen_guid}", g.create_uuid());
     cmd_text = cmd_text.replaceAll("{newid}", g.create_uuid());
     cmd_text = cmd_text.replaceAll(
         "{this_systemdate}", (new DateTime.now()).toString());
     cmd_text =
         cmd_text.replaceAll("{t.systemdate}", (new DateTime.now()).toString());
     cmd_text = cmd_text.replaceAll("{t.newid}", g.create_uuid());
     cmd_text = cmd_text.replaceAll("{t.login_id}", g.login_id);
     cmd_text = cmd_text.replaceAll("{t.k}", skey);


     if (Platform.isIOS) {
       cmd_text = cmd_text.replaceAll("{this_os}", "ios");
     }else if( Platform.isAndroid) {
       cmd_text = cmd_text.replaceAll("{this_os}", "android");
     }else if( Platform.isWindows) {
       cmd_text = cmd_text.replaceAll("{this_os}", "window");
      }


     String vid = "";
     String sval = "";


     //read parameter from string cmd

     if (!(cmd_text.contains("vcmd=no"))) {
       try {
         cmd_text=getfval(skey,cmd_text);
       } catch (e) {}
     } else {
       print("cmd_not_replace");
     }


     /*  if(g.isdebug()){
      alert("call_cmd_with_par:"+cmd_text);
    }
*/


    // g.tmsg("run_:${g.getrunseq()}" + cmd_text);


     if (isinit) {
       if (g.init0cmd == cmd_text) {
         return;
       }
       g.init0cmd = cmd_text;
     }


     // if(g.cmdval("runone")!=""){
     //   if(!g.run_one.containsKey(g.cmdval("runone"))){
     //     g.run_one[g.cmdval("runone")]="true";
     //   }else {
     //     g.bmsg("run_one:"+g.run_one.toString());
     //     return;
     //   }
     // }

     //


     g.scmd = cmd_text;
     print("runcmd_call=  $cmd_text");





     if (cmd_text == "") {
       return;
     }
     cmd_text = cmd_text.replaceAll("{@k}", skey);
     g.readcmd(cmd_text);

     int idelay = 0;
     if (g.cmd.containsKey("calldelay")) {
       idelay = int.parse(g.cmdval("calldelay"));
     }
     if (g.cmd.containsKey("cmd_delay")) {
       idelay = int.parse(g.cmdval("cmd_delay"));
     }

     if (g.cmdval("show_wait") == "true") {
       g.show_loadding(true);
       if (idelay < 500) {
         idelay = 500;
       }
     }





     Future.delayed(Duration(milliseconds: idelay), () async {
       if (!g.is_active) {
         if (g.cmdval("autocmd") != "true") {
           return;
         }
       }


       if (g.cmd.containsKey("lock_time")) {
         if (g.lock_time != "") {
           return;
         }
         g.lock_time = g.cmdval("lock_time");
         Future.delayed(
             Duration(milliseconds: g.cint(g.cmdval("lock_time"), 3000)), () {
           g.lock_time = "";
         });
       }


       String vid = "";
       String vcmd = "";
       String vcmdtext = "";
       List<String> a, b;
       var allui;
       bool callnext = true;
       String ncmd = "";


       // if(g.cmdval("_reqfield") !="" ){
       //   selectx(g.cmdval("_reqfield"), skey);
       //   g.q.forEach((key, value) {
       //     if(value==""){
       //       callnext=false;
       //       ojclick(skey,g.cmdval("ncmd"));
       //       return;
       //     }
       //   });
       // }

       if (g.cmdval("_clearxval") != "") {
         List<String> s1 = g.cmdval("_clearxval").split(",");
         s1.forEach((scol) {
           if (scol == "g") {
             g.g = new Map<String, dynamic>();
           }
           if (scol == "l") {
             g.plink = new Map<String, dynamic>();
           }
           if (scol == "v") {
             g.pvar = new Map<String, dynamic>();
           }
         });
       }


/*

      if(g.cmdval("_saveq2g") !="" ){
        selectx(g.cmdval("_saveq2g"), skey);
        g.q.forEach((key, value) {
          g.g[key]=value;
        });
      }
      if(g.cmdval("_saveq2l") !="" ){
        selectx(g.cmdval("_saveq2l"), skey);
        g.q.forEach((key, value) {
          g.l[key]=value;
        });
      }
      if(g.cmdval("_saveq2v") !="" ){
        selectx(g.cmdval("_saveq2v"), skey);
        g.q.forEach((key, value) {
          g.v[key]=value;
        });
      }
      if(g.cmdval("_saveq2k") !="" ){
        selectx(g.cmdval("_saveq2v"), skey);
        g.q.forEach((key, value) {
           g.savekey(key, value);
        });
      }

*/

       if (g.cmdval("_showtag") == "true") {
         alert(g.cmd.toString());
       }
       if (g.cmdval("cmd_debug") == "true") {
         alert(g.cmd.toString());
       }






       if (g.cmdval("if_login") != "") {
         switch (g.cmdval("if_login")) {
           case "true":
             if (!g.check_login()) {
               f_ncmd(skey);
               return;
             }
             break;
           case "false":
             if (g.check_login()) {
               f_ncmd(skey);
               return;
             }
             break;
         }
       }


       if (g.cmd.containsKey("if_datagrid_isempty")) {
         alert(g.list_ui[skey].toString());

         /* if(g.list_ui[skey].containsKey(g.cmdval("if_datagrid_isempty"))){
          alert(g.cmdval("if_datagrid_isempty"));
        }*/
       }

       if (g.cmd.containsKey("check_apik")) {
         if (g.mem.containsKey(g.cmdval("check_apik"))) {
           f_ncmd(skey);
           callnext = false;
         }
       }


       if (g.cmd.containsKey("if_req")) {
         a = getfval(skey,g.cmdval("if_req")).split(",");
         a.forEach((s1) {
           if (s1 == "") {
             f_ncmd(skey);
             callnext = false;
             return;
           }
         });
       }
       if (g.cmd.containsKey("if_req_value")) {
         a = getfval(skey,g.cmdval("if_req_value")).split(",");
         a.forEach((s1) {
           if (s1 == "" ||s1 == "0" ) {
             f_ncmd(skey);
             callnext = false;
             return;
           }
         });
       }



       if (g.cmdval("_iffound") != "") {
         final rx = await selectx(g.cmdval("_iffound"), skey);
         alert(rx.toString());
         return;
       }

       if (g.cmdval("if_str_in") != "") {
         a = g.cmdval("if_str_in").split("[");
         if (!a[0].contains(a[1])) {
           f_ncmd(skey);
           callnext = false;
           return;
         }
       }
       if (g.cmdval("if_str_not_in") != "") {
         a = g.cmdval("if_str_not_in").split("[");
         if (a[0].contains(a[1])) {
           f_ncmd(skey);
           callnext = false;
           return;
         }
       }

       if (g.cmdval("if_dataisnull") != "") {
          xval=g.cmdval("if_dataisnull");
          if(g.db.containsKey(xval)){
            if(g.db[xval].length>=0){
            //  g.tmsg("Data Existing...");
              f_ncmd(skey);
              callnext = false;
              return;
            }
          }
       }

       if (g.cmdval("if_flag") != "") {
         if(!g.fg.containsKey(g.cmdval("if_flag"))){
           f_ncmd(skey);
           callnext = false;
           return;
         }
       }
       if (g.cmdval("if_flag2") != "") {
         if(!g.fg.containsKey(g.cmdval("if_flag2"))){
           f_ncmd(skey);
           callnext = false;
           return;
         }else {
           g.fg.remove(g.cmdval("if_flag2"));
         }
       }

       if (g.cmdval("if_check") != "") {
         a = getfval(skey,g.cmdval("if_check")).split("[");

         if (a[0].trim().toLowerCase() != a[1].trim().toLowerCase()) {
           f_ncmd(skey);
           callnext = false;
           return;
         }
       }
       if (g.cmdval("if_cal") != "") {
         try {
           List a = [];
           a = getfval(skey,g.cmdval("if_cal")).split("[");

           String opr = a[1].replaceAll("(eq)", "=");

           print_log("if_cal a= ${a}");
           math.Parser p = math.Parser();
           math.Expression exp = p.parse(a[0]);
           a[0] = exp.evaluate(math.EvaluationType.REAL, null).toString();
           print_log("step_2 ${a}");

           var x = g.cdbl(a[0], 0);
           var y = g.cdbl(a[2], 0);

           print_log("step_3 ${x}  ${y}");

           switch (opr) {
             case "=":
               if (!(x == y)) {
                 f_ncmd(skey);
                 callnext = false;
                 return;
               }
               break;
             case ">":
               if (!(x > y)) {
                 f_ncmd(skey);
                 callnext = false;
                 return;
               }
               break;
             case "<":
               if (!(x < y)) {
                 f_ncmd(skey);
                 callnext = false;
                 return;
               }
               break;
             case ">=":
               if (!(x >= y)) {
                 f_ncmd(skey);
                 callnext = false;
                 return;
               }
               break;
             case "<=":
               if (!(x <= y)) {
                 f_ncmd(skey);
                 callnext = false;
                 return;
               }
               break;
             case "!=":
               if (!(x != y)) {
                 f_ncmd(skey);
                 callnext = false;
                 return;
               }
               break;
           }
         }catch(e){
          // alert("if_cal.error.${e}");
         }




       }

      /* if (g.cmdval("if_y") != "") {
         a = g.cmdval("if_y").split("[");
         //g.tmsg("if_y:"+a.toString());

         if (a[0].trim() != a[1].trim()) {
           f_ncmd(skey);
           callnext = false;
           return;
         }
       }

       if (g.cmdval("if_n") != "") {
         a = g.cmdval("if_n").split("[");
         //g.tmsg("if_n:"+a.toString());

         if (a[0].trim() == a[1].trim()) {
           f_ncmd(skey);
           callnext = false;
           return;
         }
       }*/


     /*  if (g.cmdval("if_match") != "") {
         a = g.cmdval("if_match").split("[");
         //alert(a.toString()+"  :  "+g.cmd.toString());
         if (a[0] != a[1]) {
           f_ncmd(skey);
           callnext = false;
           return;
         }
       }*/


       if (g.cmd.containsKey("if_true")) {
         if (!g.cbool(g.cmdval("if_true"))) {
           callnext = false;
           f_ncmd(skey);
           return;
         }
       }

       if (g.cmdval("f_checkfield") != "") {
         a = g.cmdval("f_checkfield").split(",");
         a.forEach((s1) {
           b = s1.split(".");
           //alert("check field:"+b.toString());
           switch (b[1]) {
             case "*":
               if (b[0] == "") {
                 callnext = false;
               }
               break;
             case "email":
               if (!isEmail(b[0])) {
                 callnext = false;
               }
               break;
           }
         });
         if (!callnext) {
           f_ncmd(skey);
         }
       }


       if (g.cmdval("_reqfield") != "") {
         g.q.clear();
         selectx(g.cmdval("_reqfield"), skey);
         g.q.forEach((key, value) {
           if (value == "") {
             callnext = false;
           }
         });
         if (!callnext) {
           f_ncmd(skey);
           return;
         }
       }

       if (g.cmdval("_ifgrdx") != "") {
         callnext = false;
         List<String> a = g.cmdval("_ifgrdx").split(".");
         allui = find.byType(gridview_ex);
         gridview_ex wd;
         for (int i = 0; i < allui
             .evaluate()
             .length; i++) {
           wd = allui
               .at(i)
               .evaluate()
               .single
               .widget as gridview_ex;
           if (wd.id() == a[0]) {
             if (a[1] == "0") {
               if (wd
                   .getlist()
                   .length == 0) {
                 callnext = true;
               }
             } else {
               if (wd
                   .getlist()
                   .length >= 0) {
                 callnext = true;
               }
             }
           }
         }
       }


       if (g.cmdval("_if") != "") {
         try {
           print("found if");
           Map<String, dynamic> q = g.q;
           String s = g.query_fromstr(g.cmdval("_if"));

           // tmsg(s);
           List<String> s1 = s.split(",");
           selectx(s, skey);


           tmsg(g.q.toString() + ":" + s);
           List<String> s2;
           s = g.cmdval("_if");
           String sval = "";
           s1.forEach((val) {
             sval = g.null2str(g.q[val.split(".")[1]]);
             s = s.replaceAll("{" + val + "}", sval);
           });

//tmsg(s);

         } catch (e) {
           tmsg("_if.error." + e.toString());
           print("_if.error." + e.toString());
         }

         // _if=11(eq)12 ,11(req)123
       }




// confirm text


       if (callnext) {
         String confirm_text = g.cmdval("confirm_text");
         if (confirm_text != "") {
           var result = await DialogUtils.dialog_yesno(
               g.ctx(), g.cmdval("confirm_title"), confirm_text);
           if (!result) {
             callnext = false;
             return;
           }
         }


         if (cmd_text != "" && callnext) {
           List<String> a = cmd_text.split(";");
           List<String> b, c, d;


           if (g.isdebug()) {
             //alert("iform="+g.iform.toString());
           }

           /*  if(cmd_text.contains("rcmd_text=true")){
            g.rcmd_text=cmd_text.replaceAll("rcmd_text=true", "rcmd_text=false");
            g.nav="back";
            Navigator.pop(g.ctx(),g.q);
            return;
          }*/


           for (String s in a) {
             if (s != "") {
               b = s.split("=");
               vcmd = b[0];
               vcmdtext = b[1];

               g.vcmdtext=vcmdtext;

               //startcmd maincmd


               // main.cmd
               //  print("cmd_:${vcmd}  ${vcmdtext}");

               switch (vcmd) {

               /*  case "f_printx":

             await Navigator.push(
                      g.ctx(),
                      MaterialPageRoute(
                          builder: (context) => printx()
                      ));

                   break;*/

                 //delay_click=1000[button_click
          case "f_setdata":
                    await savedata(skey, vcmdtext);
                   break;


              case "f_read_gps_info":
                    await f_read_gps_info();
                   break;

                 case "f_create_guid":
                   g.papp["this_guid"]=g.create_uuid();
                   break;
                 case "f_firebase_init":
                   await g.cmd_firebase_init();
                   break;

                 case "f_check_apn_token":
                   String rx=await FirebaseMessaging.instance.getAPNSToken();
                   alert("apn:${rx}");
                   print("apn:${rx}");
                   break;

                 case "fake_login":

                   sval = await input_dialog();
                   Map<String, dynamic> h = new Map<String, dynamic>();
                   h["login_id"]=sval;
                   g.saveprofile(h);
                   g.restartapp("");

                   break;

                 //
                 case "f_addflag":
                   g.fg[vcmdtext]=true;
                   break;

                 case "f_removeflag":
                   if(g.fg.containsKey(vcmdtext)){
                     g.fg.remove(vcmdtext);
                   }
                   break;

                 case "f_showinfo":
                   f_showinfo(vcmdtext,skey);
                   break;

                 case "f_get_inputdialog":
                 case "f_input_dialog":
                 case "f_input":
                   sval = await input_dialog();
                   g.savevfield(g.strx(vcmdtext, "input_dialog"), sval);
                   break;

                 case "f_copy2clipboard":
                   FlutterClipboard.copy(vcmdtext).then(( value ) => print('copied'));
                   break;

                 case "f_clear_tmsg":
                    Fluttertoast.cancel();
                   break;

                case "f_gmap_cmd":
                try {


                /*  await Navigator.push(
                      g.ctx(),
                      MaterialPageRoute(
                          builder: (context) => getplace_autocomplate()
                      ));
*/

                         allui = find.byType(xui_ex);
                         gridview_ex wd;
                         xui_ex ui;
                         for (int i = 0; i < allui.evaluate().length; i++) {
                           ui = allui.at(i).evaluate().single.widget;
                           a = vcmdtext.split(",");
                           if(g.idmath(ui.id(),a[0])){
                             ui.add_event(vcmdtext);
                             break;
                           }
                         }
                       }catch(e){
                         g.tmsg("f_move_location.error.${e}");
                       }

                   break;







                 case "f_getplace":
                   switch (vcmdtext) {
                     case "true":


                 /*      await Navigator.push(
                           g.ctx(),
                           MaterialPageRoute(
                               builder: (context) => map_search()
                           ));*/


                   /*    geo.LocationResult result = await Navigator.of(g.ctx())
                           .push(MaterialPageRoute(
                           builder: (context) =>
                               PlacePicker(g.google_apikey(),
                                 displayLocation: g.my_location,
                               )));

                       */
                       break;
                     case "getplace":
                       await Navigator.push(
                           g.ctx(),
                           MaterialPageRoute(
                               builder: (context) => getplace()
                           ));
                       break;


                     case "search":
                       await Navigator.push(
                           g.ctx(),
                           MaterialPageRoute(
                               builder: (context) => getplace_autocomplate()
                           ));
                       break;
                     case "x":
                       GooglePlace googlePlace;
                       googlePlace = GooglePlace(g.google_apikey());
                       var result = await googlePlace.autocomplete.get(
                           "thailand food ");
                       g.tmsg("${result.predictions.length}");
                       break;

                   }

                   break;
                 case "f_getplace2":
                   await Navigator.push(
                       g.ctx(),
                       MaterialPageRoute(
                           builder: (context) => getplace()
                       ));

                   break;
                 case "call_ftest":

try {
  var request = http.MultipartRequest(
      'POST', Uri.parse('https://mkpservice.shippop.dev/pricelist/'));

 // var hx=g.read_json(g.json_ui, "api") as Map<String, String>;
 // g.alert(g.read_json(g.json_ui, "api"));
var  dx=jsonDecode(g.read_json( g.json_ui,"api")).cast<String,String>();
   request.fields.addAll(dx);


  /*request.fields.addAll({
                     'api_key': 'dv47f3bec0691b14525daf608ea70b55b82a1901ad0e900fbe5c73a1b2cd3f072afa355d70efb70f641664507440',
                     'data[0][from][name]': 'ชื่อผู้ส่ง อยู่ตรงนี้จ้ายาวๆไป',
                     'data[0][from][address]': '123/456 Testor Tower',
                     'data[0][from][district]': 'บางรัก',
                     'data[0][from][state]': 'บางรัก',
                     'data[0][from][province]': 'กรุงเทพมหานคร',
                     'data[0][from][postcode]': '10200',
                     'data[0][from][tel]': '0800000000',
                     'data[0][to][name]': 'ชื่อผู้รับ อยู่ตรงนี้จ้ายาวๆไป',
                     'data[0][to][address]': '456/789 Testor Tower',
                     'data[0][to][district]': 'บางรัก',
                     'data[0][to][state]': 'บางรัก',
                     'data[0][to][province]': 'กรุงเทพมหานคร',
                     'data[0][to][postcode]': '10600',
                     'data[0][to][tel]': '0800000000',
                     'data[0][parcel][name]': 'size A',
                     'data[0][parcel][weight]': '1001',
                     'data[0][parcel][width]': '10',
                     'data[0][parcel][length]': '15',
                     'data[0][parcel][height]': '15',
                     'data[0][special_code]': ''
                   });*/


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String r = await response.stream.bytesToString();
    g.alert(r);
  }
  else {
    print(response.reasonPhrase);
  }
}catch(e){
  g.alert("error.${e}");
}

               /* await Navigator.push(
                       g.ctx(),
                       MaterialPageRoute(
                           builder: (context) => GoogleSearchPlacesApi()
                       ));*/

                  // googlemap_nowpoint
                   // OrderTrackingPage
               /*    await Navigator.push(
                       g.ctx(),
                       MaterialPageRoute(
                           builder: (context) => gplace()
                       ));*/


                   break;




                 case "f_test":


                   try {
                     Map data = {
                       "api_key": "dv47f3bec0691b14525daf608ea70b55b82a1901ad0e900fbe5c73a1b2cd3f072afa355d70efb70f641664507440",
                       "data": [
                         {
                           "from": {
                             "name": "ชื่อผู้ส่ง - นามสกุล",
                             "address": "522 ซอยรัชดาภิเษก 26 ถนนรัชดาภิเษก  แขวงสามเสนนอก เขตห้วยขวาง กรุงเทพมหานคร",
                             "district": "-",
                             "state": "-",
                             "province": "-",
                             "postcode": "10310",
                             "tel": "0929053355"
                           },
                           "to": {
                             "name": "ชื่อผู้รับ นามสกุล",
                             "address": "522 ซอยรัชดาภิเษก 26 ถนนรัชดาภิเษก  แขวงสามเสนนอก เขตห้วยขวาง กรุงเทพมหานคร",
                             "district": "-",
                             "state": "-",
                             "province": "-",
                             "postcode": "10310",
                             "tel": "0929053355"
                           },
                           "parcel": {
                             "name": "-",
                             "weight": "1",
                             "width": "1",
                             "length": "1",
                             "height": "1"
                           },
                           "showall": "1"
                         }
                       ]
                     };
                     //encode Map to JSON
                     var body = json.encode(data);


                     var response = await http.post(
                         Uri.parse("https://mkpservice.shippop.dev/pricelist"),
                         headers: {"Content-Type": "application/json"},
                         body: body
                     );

                     // print("${response.statusCode}");
                     // print("${response.body}");

                     alert("r=${response.body}");


                     /* var formData = dio.FormData.fromMap(d);


                    alert("form=${formData}");


                    var responce = await dio.Dio().get(
                      "https://mkpservice.shippop.dev/pricelist",
                      queryParameters: d
                    );
                    alert("r=${responce}   api=${d['api_key']}");*/


                   } catch (e) {
                     g.alert("error.${e}");
                   }


                   break;

                   /* case "f_playx":

                await Navigator.push(
                      g.ctx(),
                      MaterialPageRoute2(
                          builder: (context) => MyApp()
                      ));
                  break;*/


                   /* try {


                if(a_player==null){
                  a_player = await AudioService.init(
                    builder: () => AudioPlayerHandler(),
                    config: const AudioServiceConfig(
                      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
                      androidNotificationChannelName: 'Audio playback',
                      androidNotificationOngoing: true,
                    ),
                  );
                }


                    final item = MediaItem(
                      id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
                      album: "Science Friday",
                      title: "A Salute To Head-Scratching Science",
                      artist: "Science Friday and WNYC Studios",
                      duration: const Duration(milliseconds: 5739820),
                      artUri: Uri.parse(
                          'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
                    );


                a_player.play();

                   // g.a_player.addQueueItem(item);
                   // g.a_player.play();
                    //g.a_player.playMediaItem(item);
                  }catch(e){
                    g.alert("f_playx.error.${e}");
                  }
*/


                   break;


                 case "f_playx2":
                   try {
                     if (a_player == null) {
                       a_player = await AudioService.init(
                         builder: () => AudioPlayerHandler(),
                         config: const AudioServiceConfig(
                           androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
                           androidNotificationChannelName: 'Audio playback',
                           androidNotificationOngoing: true,
                         ),
                       );
                     }


                     final item = MediaItem(
                       id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
                       album: "Science Friday",
                       title: "A Salute To Head-Scratching Science",
                       artist: "Science Friday and WNYC Studios",
                       duration: const Duration(milliseconds: 5739820),
                       artUri: Uri.parse(
                           'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
                     );


                     a_player.play();
                   } catch (e) {
                     g.alert("f_playx.error.${e}");
                   }


                   break;
                 case "f_jscal":
                   List<String> a = g.cmdval("f_jscal").split(".");
                   dynamic dx = jsonDecode(g.read_json(g.json_ui, a[0]));
                   try {
                     JsEvalResult rt = flutterJs.evaluate(dx[a[1]]);
                     g.plink["jscal"] = rt.stringResult;
                   } catch (e) {
                     //alert("f_jscal.error.${e}");
                   }
                   break;
                 case "f_jsreq":
                   List<String> a = g.cmdval("f_jsreq").split(".");
                   dynamic dx = jsonDecode(g.read_json(g.json_ui, a[0]));
                   try {
                     var asyncResult = await flutterJs.evaluateAsync(dx[a[1]]);
                     await flutterJs.executePendingJob();
                     final promiseResolved = await flutterJs.handlePromise(
                         asyncResult);
                     g.plink["jsret"] = promiseResolved.stringResult;
                   } catch (e) {
                     // alert("jsret.error.${e}");
                   }
                   break;

                 case "f_lconcat":
                   await g.f_concat(g.cmdval("f_lconcat"));
                   break;

                 case "f_get_location":
                   await f_get_location();
                   break;

                 case "f_call_mqtt_connect":
                   await call_mqtt_connect(g.cmd);
                   break;

                 case "f_loop":
                   f_loop(g.cmd);
                   break;

                 case "f_start_savevdo":
                   g.cam_ctrl.startVideoRecording();
                   break;

                 case "page_rbind":
                   xval= await getfval(skey, vcmdtext);
                   g.page_rbind = xval;
                   break;

                 case "f_auto_savevdo":
                   int i_delay = g.cint(g.cmdval("vdo_time"), 10);
                   String sound_url = g.cmdval("sound_url");
                   g.cam_ctrl.startVideoRecording();
                   if (sound_url != "") {
                     g.play_sound2(sound_url);
                   }
                   Future.delayed(Duration(seconds: i_delay), () {
                     g.cam_ctrl.stopVideoRecording().then((XFile file) async {
                       final dir = await g.get_dir_download();
                       g.create_dir("/ladyclub");
                       final to_file = path.join(dir.path,
                           "f_${g.get_datetime_id()}.mp4");


                       g.moveFile(File(file.path), to_file);
                       g.plink["get_file"] = to_file;
                       g.select_file = to_file;
                       g.stop_player();

                       if (g.cmdval("fn_click") != "") {
                         g.t_click = g.cmdval("fn_click");
                       }
                     });
                   });
                   break;


                 case "f_capture_photo":
                   await g.cam_ctrl.takePicture().then((XFile file) async {
                     g.plink["get_file"] = file.path;
                     if (g.cmdval("fn_click") != "") {
                       g.t_click = g.cmdval("fn_click");
                     }
                   });
                   break;

                 case "f_end_savevdo":
                   g.cam_ctrl.stopVideoRecording().then((XFile file) async {
                     final dir = await g.get_dir_download();
                     final sfile = path.join(
                         dir.path, "f_${g.get_datetime_id()}.mp4");
                     g.moveFile(File(file.path), sfile);
                     g.plink["vdo_file"] = sfile;
                     g.select_file = sfile;
                     if (g.cmdval("fn_click") != "") {
                       g.t_click = g.cmdval("fn_click");
                     }
                   });

                   break;

                 case "f_play_sound":
                   g.play_sound(vcmdtext);
                   break;


                 case "f_calc":
                 case "eval":
                   try {


                     vcmdtext=getfval(skey,vcmdtext);
                     math.Parser p = math.Parser();
                     math.Expression exp = p.parse(vcmdtext);
                     String rt = exp.evaluate(math.EvaluationType.REAL, null)
                         .toString(); // if context is not available replace it with null.
                     g.pvar["eval"] = rt;
                     xval = g.cmdval("cal2field");
                     if (xval != "") {
                       xval = g.cmdval("cal2field");
                       g.saveiform(xval, rt);
                       update_field(skey, xval, rt);
                     }
                   }catch(e){
                     //alert("f_calc.error.${e} :${vcmdtext}");
                   }
                   break;


                 case "f_select":
                 /* g.tmsg("call this");
                  String value = 'flutter';
                  List<S2Choice<String>> options = [
                    S2Choice<String>(value: 'ion', title: 'Ionic'),
                    S2Choice<String>(value: 'flu', title: 'Flutter'),
                    S2Choice<String>(value: 'rea', title: 'React Native'),
                  ];

                  @override
                  Widget build(BuildContext context) {
                    return SmartSelect<String>.single(
                        title: 'Frameworks',
                        value: value,
                        choiceItems: options,
                    );
                  }*/


                   break;

                 case "f_open_panel":
                   g.panel_control[skey].open();
                   // g.gpc[skey]c.setPanelPosition(0.5)
                   break;
                 case "f_download_file":
                   /*
                   Map<Permission, PermissionStatus> statuses = await [
                     Permission.storage,
                     //add more permission to request here.
                   ].request();

                   if (statuses[Permission.storage].isGranted) {
                     var dir = await DownloadsPathProvider.downloadsDirectory;
                     if (dir != null) {
                       String file_url = vcmdtext;
                       String fn_click = g.cmdval("fn_click");
                       String ext = g.get_extname(vcmdtext);
                       String savename = "download_${g.gen_file()}.${ext}";
                       String savePath = dir.path + "/$savename";
                       print(savePath);

                       try {
                         await dio.Dio().download(
                             file_url,
                             savePath,
                             onReceiveProgress: (received, total) {
                               if (total != -1) {
                                 print((received / total * 100).toStringAsFixed(
                                     0) + "%");
                                 g.papp["percen_download"] =
                                     (received / total * 100).toStringAsFixed(
                                         0) + "%";
                                 if (g.cmdval("show_download_status") ==
                                     "true") {
                                   g.update_app_stream();
                                 }
                                 //you can build progressbar feature too
                               }
                             });
                         print("File is saved to download folder.");
                         if (fn_click != "") {
                           ojclick(skey, fn_click);
                         }
                       } on dio.DioError catch (e) {
                         print(e.message);
                       }
                     }
                   } else {
                     print("No permission to read and write.");
                   }*/
                 //checkcode
                   break;
                 case "f_clear_db":
                   a = vcmdtext.split(",");
                   a.forEach((s1) {
                     if (g.db.containsKey(s1)) {
                       g.db.remove(s1);
                     }
                   });
                   break;


                 case "f_start_save_sound":

                   //checkcode
                   /*
                 //   start_save_sound();

                   FlutterAudioRecorder2 _recorder;
                   Recording _current;
                   RecordingStatus _currentStatus = RecordingStatus.Unset;

                   try {
                     bool hasPermission = await FlutterAudioRecorder2
                         .hasPermissions ?? false;

                     if (hasPermission) {
                       String customPath = '/voice_';
                       Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
                       if (Platform.isIOS) {
                         appDocDirectory = await getDownloadDirectory();
                       } else {
                         appDocDirectory = (await getDownloadDirectory());
                       }

                       // can add extension like ".mp4" ".wav" ".m4a" ".aac"
                       customPath = appDocDirectory.path +
                           customPath +
                           DateTime
                               .now()
                               .millisecondsSinceEpoch
                               .toString();

                       // .wav <---> AudioFormat.WAV
                       // .mp4 .m4a .aac <---> AudioFormat.AAC
                       // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
                       _recorder =
                           FlutterAudioRecorder2(customPath + ".mp4");

                       await _recorder.initialized;
                       // after initialization
                       var current = await _recorder.current(channel: 0);
                       print(current);
                       // should be "Initialized", if all working fine
                       // setState(() {
                       //   _current = current;
                       //   _currentStatus = current!.status!;
                       //   print(_currentStatus);
                       // });
                     } else {
                       *//*     ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: new Text("You must accept permissions")));
               *//*
                     }
                   } catch (e) {
                     print(e);
                   }

                   try {
                     await _recorder.start();
                     var recording = await _recorder.current(channel: 0);
                     *//* setState(() {
                      _current = recording;
                    });*//*

                     const tick = const Duration(milliseconds: 50);
                     new Timer.periodic(tick, (Timer t) async {
                       if (_currentStatus == RecordingStatus.Stopped) {
                         t.cancel();
                       }

                       var current = await _recorder.current(channel: 0);
                       // print(current.status);
                       *//*  setState(() {
                        _current = current;
                        _currentStatus = _current.status;

                      });*//*
                     });
                   } catch (e) {
                     print(e);
                   }


                   Future.delayed(const Duration(milliseconds: 3000), () async {
                     var result = await _recorder.stop();
                     print("Stop recording: ${result.path}");
                     print("Stop recording: ${result.duration}");
                     // File file = widget.localFileSystem.file(result.path);
                     g.tmsg("File length: ${result.path}");
                   });
*/

                   break;
                 case "f_end_save_sound":
                   g.recordingSession.closeRecorder();
                   await g.recordingSession.stopRecorder();
                   break;

                 case "f_wait":
                 case "_fwait":
                   if (vcmdtext == "true") {
                     await g.show_loadding(true);
                   } else if (vcmdtext == "false") {
                     await g.show_loadding(false);
                   }

                   break;
                 case "f_save2c":
                   List<String> a = vcmdtext.split(",");
                   List<String> b;
                   a.forEach((s1) {
                     b = s1.split("[");
                     g.c[b[0]] = b[1];
                     try {
                       g.px[skey][b[0]] = b[1];
                     } catch (e) {}
                   });
                   break;
                 case "f_app_setting":
                   g.app_setting(vcmdtext);
                   break;
                 case "mix_code":
                   try {
                     List<String> a = vcmdtext.split(",");
                     if (a.length >= 3) {
                       String gval = "";
                       String aval = a[1];
                       String bval = a[2];

                       if (g.cint(aval, 0) <= g.cint(bval, 0)) {
                         gval = aval + "x" + bval;
                       } else {
                         gval = bval + "x" + aval;
                       }
                       if (a.length >= 4) {
                         gval = a[3] + gval + a[3];
                       }

                       g.papp[a[0]] = gval;
                       g.send_bind[a[0]] = gval;
                       g.c[a[0]] = gval;
                       print("mix_code ${a[0]}=${gval}");
                     }
                   } catch (e) {}


                   break;


                 case "f_show_wait":
                   if (vcmdtext == "true") {
                     g.showoverlay(true);
                   } else {
                     g.showoverlay(false);
                   }
                   break;
                 case "call_service":
                   call_service(vcmdtext, skey);
                   break;

                 case "t_click":
                   g.t_click = vcmdtext;
                   break;

                 case "f_add_event_bus":
                   g.addeventbus(skey, vcmdtext);
                   break;
                 case "f_set_page_active":
                   g.is_active = (vcmdtext == "true");
                   break;

                 case "f_show_noti":
                   g.show_noti(vcmdtext);
                   break;
                 case "f_clear_noti":
                   g.clear_all_noti();
                   break;

                 case "f_share_screen":
                   g.f_share_screen();
                   break;
                 case "f_readscreen":
                   g.read_screen(g.ctx());
                   break;
                 case "del_apik":
                   a = vcmdtext.split(",");
                   a.forEach((s1) {
                     if (g.mem.containsKey(s1)) {
                       g.mem.remove(s1);
                     }
                   });
                   break;

                 case "f_hidekeyboard":
                   FocusManager.instance.primaryFocus.unfocus();
                   break;

                 case "f_filedownload":
                   try {
                     // alert(vcmdtext);
                     //g.openlink("https://stackoverflow.com/");
                     var r = await downloadFile(vcmdtext, g.cmd);

                     /* String fdir=(await getExternalStorageDirectory()).path;
                    final taskId = await FlutterDownloader.enqueue(
                      url: vcmdtext,
                      savedDir: fdir,
                      showNotification: true,
                      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                    );*/

                   } catch (e) {}
                   break;
                 case "per_req":
                   await per_req(vcmdtext);
                   break;

                 case "show_var":
                   List<String> a = vcmdtext.split(",");
                   a.forEach((s1) {
                     switch (s1) {
                       case "a":
                         alert("${s1}:${g.papp}");
                         break;
                       case "v":
                         alert("${s1}:${g.pvar}");
                         break;
                       case "pf":
                         alert("${s1}:${g.pprofile}");
                         break;
                       case "c":
                         alert("${s1}:${g.c}");
                         break;
                     }
                   });
                   break;

                 case "f_sortx":
                   try {
                     //v1,v2,tofield
                     a = vcmdtext.split(",");
                     sval = "";
                     if (g.cint(a[0], 0) <= g.cint(a[1], 0)) {
                       sval = "x" + a[0] + "x" + a[1] + "x";
                     } else {
                       sval = "x" + a[1] + "x" + a[0] + "x";
                     }
                     if (a.length > 2) {
                       g.pvar[a[2]] = sval;
                     } else {
                       g.pvar["f_sortx"] = sval;
                     }
                     // alert(g.getrunseq()+"f_sortx:${sval}  ${g.pvar}");
                   } catch (e) {}
                   break;

                 case "f_saveprofile":
                   try {
                     List allrow = jsonDecode(g.jsonx)[vcmdtext] as List;
                     if (allrow.length > 0) {
                       Map<String, dynamic> h = allrow[0] as Map<String,
                           dynamic>;
                       await g.saveprofile(h);
                     }
                   } catch (e) {
                     print("save2key.error" + e.toString());
                   }


                   break;


                 case "f_selectrow":
                 /* g.j=new Map<String, dynamic>();
                  try {
                  List<String> a1=vcmdtext.split(",");
                  if(a1.length>=2){
                    if(g.db.containsKey(a1[0])){
                      g.j=g.db[a1[0]][g.cint(a1[1],0)];
                     // alert(g.j.toString());
                    }
                  }}catch(e){}*/


                   break;

                 case "f_webcmd":
                 //  g.webcontrol.evaluateJavascript('mobile_cmd("${cmd_text}")');
                   break;

                 case "init_app":
                   g.cfg_api_pr = "";
                   break;

                 case "reset_cfg_api_pr":
                   g.cfg_api_pr = "";
                   break;

                 case "cfg_api_pr":
                   vcmdtext = vcmdtext.replaceAll("[", "=");
                   g.cfg_api_pr = vcmdtext;
                   break;

                 case "f_reset_uiversion":
                   await removekey("ui_data");
                   await removekey("ui_version");

                   break;

                   // grid_id[fieldname,fieldname....[savetolink
                 case "f_readdatagrid":

                   try {
                     a = vcmdtext.split("[");
                     b = a[1].split(",");
                     String s = "";
                     gridview_ex gx = getui(skey, a[0]);
                     int im = gx.dt.length;
                     Map<String, dynamic> dr = new Map<String,
                         dynamic>(); // language

                     for (int ir = 0; ir < im; ir++) {
                       dr = g.db[a[0]][ir];
                       s += dr[b[0]] + "/" + dr[b[1]] + ",";
                     }
                     s=g.rcut(s);
                     if (a.length >= 3) {
                       g.plink[a[2]] = s;
                     }
                   }catch(e){}

                   break;

                 case "fn_readfieldinrow":
                 //read_gridrow=gridix,fieldname,tolink
                   try {
                     bool have_data = true;
                     String tval = "";
                     a = vcmdtext.split(",");
                     b = g.cmdval("getfield").split(",");
                     String sval = "";
                     String sl = "";
                     if (g.list_ui[skey].containsKey(a[0])) {
                       gridview_ex gx = g.list_ui[skey][a[0]] as gridview_ex;
                       gx.dt.forEach((h) {
                         if (b.length > 0) {
                           sl = "";
                           b.forEach((s2) {
                             tval = g.null2str(h[s2]);
                             sl += tval + "/";
                             if (tval == "") {
                               have_data = false;
                             }
                           });
                           sl = g.rcut(sl);
                         }
                         sval += sl + ",";
                       });
                       sval = g.rcut(sval);

                       if (g.isdebug()) {
                         alert("fn_readfieldinrow=" + sval);
                       }
                       g.plink[a[2]] = sval;

                       if (!have_data) {
                         if (g.cmd.containsKey("getfield_nclick")) {
                           ojclick(skey, g.cmdval("getfield_nclick"));
                           break;
                           return;
                         }
                       }
                     }
                   } catch (e) {}

                   break;

                 case "setvalif":
                   a = g.cmdval("setvalif").split("[");
                   if (a[0] == a[1]) {
                     a = g.cmdval("ysetval").split(",");
                     a.forEach((s1) {
                       b = s1.split("[");
                       g.setxval(b[0], b[1]);
                     });
                   } else {
                     a = g.cmdval("nsetval").split(",");
                     a.forEach((s1) {
                       b = s1.split("[");
                       g.setxval(b[0], b[1]);
                     });
                   }
                   break;

                 case "f_openlink":
                   await g.openlink(g.decode_url(vcmdtext));
                   ojclick(skey, g.cmdval("fx_click"));
                   break;

                 case "f_openlinkv2":
                   await g.openlinkv2(g.decode_url(vcmdtext));
                   ojclick(skey, g.cmdval("fn_click"));
                   break;

                 case "f_setappid":
                   await removekey("ui_data");
                   await removekey("ui_version");
                   if(vcmdtext!=""){
                     sval=vcmdtext;
                   }else {
                     sval = await input_dialog();
                   }
                   g.savekey("appid", sval);
                   Future.delayed(const Duration(milliseconds: 1000), () {
                     g.restartapp("");
                   });
                   break;

                 case "f_clear_appid":
                   await removekey("ui_data");
                   await removekey("ui_version");
                   g.savekey("appid", sval);
                   Future.delayed(const Duration(milliseconds: 1000), () {
                     g.restartapp("");
                   });
                   break;
                 case "_showid":
                   alert(g.list_ui[skey].keys.toString());
                   break;
                 case "f_saveform":
                   f_saveform(skey);
                   break;
                 case "f_saveform2":
                   f_saveform2(skey);
                   break;

                 case "f_chatwith":
                   f_chatwith(skey);
                   break;

                 case "f_chatlist_query":
                   f_chatlist_query(skey);

                   break;

                 case "f_readgps":
                 case "f_getgps":
                 case "f_getlocation":
                 case "_getlocation":
                   await g.f_readgps();
                   break;
                 case "_getdeviceid":
                   g.sys["device_id"] = getDeviceID();
                   break;
                 case "f_getdate":
                 case "_getdate":
                 //Navigator.push(g.ctx(), _selectDate); //new

                   try {


                     String date_format=g.cstr(g.cmdval("date_format"), "dd/MM/yyyy");
                     DateTime selectedDate = DateTime.now();
                     final DateTime picked = await showDatePicker(
                         context:g.ctx(),
                         initialDate: selectedDate,
                         firstDate: DateTime(1900),
                         lastDate: DateTime(2200)
                     );
                     xval= DateFormat(date_format). format(picked);
                     plink["getdate"] = xval;

                     if(vcmdtext!="true"){
                       g.saveiform(vcmdtext, xval);
                       update_field(skey, vcmdtext, xval);
                     }
                     ojclick(skey, g.cmdval("fx_click"));



                     /* DateTimePicker(
                       initialValue: '',
                       use24HourFormat: true,
                          dateLabelText: 'Date',
                       onChanged: (val) {
                         plink["getdate"] = val;
                       },
                       validator: (val) {
                         plink["getdate"] = val;
                         return null;
                       },
                       onSaved: (val) {
                         plink["getdate"] = val;
                         ojclick(skey, g.cmdval("fx_click"));
                       },
                     );*/


                   } catch (e) {}

                   break;
                 case "f_gettime":

                   try {



                     final TimeOfDay picked = await showTimePicker(
                         context: g.ctx(),
                         initialTime: TimeOfDay.now(),
                         builder: (context, childWidget) {
                           return MediaQuery(
                               data: MediaQuery.of(context).copyWith(
                                 // Using 24-Hour format
                                   alwaysUse24HourFormat: true),
                               // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                               child: childWidget);
                         });


                     xval= "${picked.hour}:${picked.minute}";

                     plink["gettime"] = xval;
                     print("f_gettime=${xval}");



                     if(vcmdtext!="true"){
                       g.saveiform(vcmdtext, xval);
                       update_field(skey, vcmdtext, xval);
                     }
                     ojclick(skey, g.cmdval("fx_click"));

                   } catch (e) {
                     g.tmsg("f_gettime.error.${e}");
                   }

                   break;

                 case "f_selectphoto":
                 case "_selectphoto":
                   await f_getfile(skey, vcmdtext);
                   break;

                 case "datagrid_setdb":

                   a = vcmdtext.split(",");
                   g.ggrid_id = a[0];
                   if (g.list_ui[skey].containsKey(a[0])) {
                     gridview_ex gx = g.list_ui[skey][a[0]];
                     gx.eventx.add("datagrid_setdb");
                   }else {
                     print("key:${a[0]} ${g.list_ui[skey].keys}");
                   }

                   break;


                 case "datagrid_delrow":
                 case "datagrid_delrow":
                   a = vcmdtext.split(",");
                   g.ggrid_id = a[0];

                   if (g.list_ui[skey].containsKey(a[0])) {
                     gridview_ex gx = g.list_ui[skey][a[0]];
                     gx.eventx.add("datagrid_delrow");
                   }
                   break;


                 case "_resetdatagrid":
                   try{

                     List a = vcmdtext.split(",");
                     Map<String, dynamic> h = new Map<String, dynamic>();
                     a.forEach((str) {
                       if(g.list_ui.containsKey(skey)){
                       if (g.list_ui[skey].containsKey(str)) {
                         gridview_ex gx = g.list_ui[skey][str];
                         String grid_id = gx.id();
                         if (g.db.containsKey(grid_id)) {
                           for (int i = 0; i < g.db[grid_id].length; i++) {
                             h = g.db[grid_id][i];
                             g.db[grid_id][i]["checkbox"] = "0";
                             g.db[grid_id][i]["rcheck"] = "0";
                           }
                           g.ggrid_id = grid_id;
                           gx.eventx.add("datagrid_reload");
                         }
                       }}
                     });

                   }catch(e){}



                   break;

                 case "datagrid_clearcheckbox":
                   List a = vcmdtext.split(",");
                   Map<String, dynamic> h = new Map<String, dynamic>();
                   a.forEach((str) {
                     print("datagrid_clearcheckbox:" + str);

                     if (g.list_ui[skey].containsKey(str)) {
                       gridview_ex gx = g.list_ui[skey][str];
                       String grid_id = gx.id();
                       if (g.db.containsKey(grid_id)) {
                         for (int i = 0; i < g.db[grid_id].length; i++) {
                           h = g.db[grid_id][i];
                           g.db[grid_id][i]["checkbox"] = "0";
                           g.db[grid_id][i]["rcheck"] = "0";
                         }
                       }
                     }
                   });
                   break;

                 case "datagrid_cmd":


                   vcmdtext=getfval(skey,vcmdtext);
                   a=vcmdtext.split(",");
                   var gx=g.readui(a[0], skey);
                   if(gx!=null){
                     (gx as gridview_ex).eventx.add(a[1]);
                   }
                   break;

                   // gridic,goto_page[1
                 case "datagrid_addcmd":
                   vcmdtext=getfval(skey,vcmdtext);
                   a=vcmdtext.split(",");
                   var gx=g.readui(a[0], skey);
                   if(gx!=null){
                     (gx as gridview_ex).eventx.add(a[1]);
                   }

                   break;


                 case "f_updaterow":
                 // a=vcmdtext.split(",");
                 // if(g.list_ui[skey].containsKey(a[0])){
                 //   gridview_ex gx=g.list_ui[skey][a[0]];
                 //   gx.eventx.add("f_updaterow");
                 // }
                   break;


                 case "datagrid_reset":
                   List a = vcmdtext.split(",");
                   a.forEach((scol) {
                     if (scol != "") {
                       if (g.list_ui[skey].containsKey(scol)) {
                         gridview_ex grd = g.list_ui[skey][scol];
                       }
                     }
                   });
                   break;

               // datagrid_filter=grid_id,
                 case "datagrid_filter":


                 // g.tmsg("find_${skey} ${g.list_ui[skey].keys}");

                   try {
                     List a = vcmdtext.split(",");
                     a.forEach((s) {
                       if (s != "") {
                         List arr = s.split(".");
                         if (g.list_ui[skey].containsKey(arr[0])) {
                           if (g.list_ui[skey].containsKey(arr[0])) {
                             //  g.tmsg("datagrid_found ${arr[0]} ");
                             gridview_ex gx = g.list_ui[skey][arr[0]];
                             print("filter_grid:" + arr[0] + ":" + s);
                             gx.s_filter = s;
                             gx.eventx.add("datagrid_filter");
                             //gx.setcmd(s);
                             logx("${arr[0]}: Ykey=${g.list_ui[skey]}");
                           }
                         } else {
                           // g.tmsg("datagrid_filter_not_found ${arr[0]} ${g.list_ui[skey].keys}");
                           logx("${arr[0]}: Nkey=${g.list_ui[skey]}");
                         }
                       }
                     });
                   } catch (e) {
                     // alert("datagrid_filter.error."+e.toString());
                   }
                   break;

                 case "datagrid_filter2":

                   a=vcmdtext.split(",");
                   ggrid_id=a[0];
                   gridview_ex gx = getui(skey,ggrid_id);

                   if(gx!=null){
                     gx.eventx.add("datagrid_filter");
                   }

                   break;


                 case "firebase_createprofile":
                   try {
                     print("_fb_createprofile");
                     UserCredential u = await FirebaseAuth.instance
                         .createUserWithEmailAndPassword(
                         email: g.cmdval("u_email"),
                         password: g.cmdval("u_password"));
                     ojclick(skey, g.cmdval("fx_click"));
                   } catch (e) {
                     alert("_fb_createprofile.error." + e.toString());
                   }

                   break;

                 case "firebase_login":
                   if (g.regis_firebase) {
                     try {
                       await FirebaseAuth.instance.signInWithEmailAndPassword(
                           email: g.cmdval("u_email"),
                           password: g.cmdval("u_password")
                       );
                       ojclick(skey, g.cmdval("fx_click"));
                     } catch (e) {
                       alert("firebase_login.error." + e.toString());
                     }
                   }


                   break;

                 case "firebase_query":
                   if (g.regis_firebase) {
                     try {
                       String spath = g.cmdval("path");


                       //g.tmsg("call query query path:${spath}");

                       List dlist = [];
                       Map<dynamic, dynamic> h = new Map<dynamic, dynamic>();
                       String tkey = "";
                       String into_datagrid = g.cmdval("into_datagrid");
                       String firebase_tag = g.cmdval("firebase_tag");
                       int icount = 0;
                       if (firebase_tag == "realtime_database") {
                         if (g.fbpath != "") {
                           try {
                             // g.rt_db.child("").remove();
                           } catch (e) {}
                         }

                         try {
                           if (g.db.containsKey(into_datagrid)) {
                             if (g.db[into_datagrid].length == 0) {
                               icount = 1;
                             }
                           }
                         } catch (e) {}

                         g.fbpath = spath;
                         g.rt_db
                             .child(spath)
                             .limitToLast(1)
                             .onChildAdded
                             .listen((event) {
                           if (icount > 0) {
                             h = new Map<String, dynamic>.from(
                                 event.snapshot.value);
                             h["k"] = event.snapshot.key;


                             // g.tmsg("firebase_query:"+h.toString());


                             dlist.add(h);
                             if (into_datagrid != "") {
                               g.db[into_datagrid] = dlist;
                               print("db/" + into_datagrid + ":" +
                                   g.db[into_datagrid].toString());


                               g.datagrid_tag = "firebase";
                               finto_datagrid(
                                   skey, skey + "." + into_datagrid, false);
                             }
                           }
                           icount += 1;
                         });
                       } else {
                         if (into_datagrid != "") {
                           g.datagrid_tag = "";
                           g.rt_db.child(spath).limitToLast(20)
                               .orderByKey()
                               .once()
                               .then((DataSnapshot snapshot) {
                             snapshot.value.forEach((key, value) {
                               h = new Map<String, dynamic>.from(value);
                               h["k"] = key.toString();
                               dlist.add(h);
                             });


                             // dlist.sort((a, b) {
                             //   return a.value['k'].toString().toLowerCase().compareTo(b.value['k'].toString().toLowerCase());
                             // });

                             g.db[into_datagrid] = dlist;
                             print("db/" + into_datagrid + ":" +
                                 g.db[into_datagrid].toString());
                             Future.delayed(const Duration(
                                 milliseconds: 1000), () {
                               finto_datagrid(
                                   skey, skey + "." + into_datagrid, false);
                             });
                           });
                         }
                       }
                     } catch (e) {
                       alert("error");
                     }
                   }


                   break;

                 case "closeapp":
                   g.closeapp();
                   break;

                 case "reloadapi":
                   reloadapi();
                   break;

                 case "firebase_cmd":
                   await firebase_cmd(vcmdtext, skey);
                   break;

                 case "f_qrscan":
                   /*
                   switch (vcmdtext) {
                     case "photo":
                       await Permission.storage.request();
                       String vqrscan = await qrscan.scanPhoto();
                       g.pvar["qrscan"] = vqrscan;
                       break;
                     default:
                       await Permission.camera.request();
                       String barcode = await qrscan.scan();
                       if (barcode == null) {
                         barcode = "";
                       }
                       g.pvar["qrscan"] = barcode;
                       break;
                   }
*/
                 //checkcode

                   break;
                 case "f_scanqrcode_fromfile":
                   /*
                   await Permission.storage.request();
                   final ImagePicker _picker = ImagePicker();
                   var sfile = await _picker.getImage(
                       source: ImageSource.gallery);

                   String barcode = await xscan.Scan.parse(sfile.path);
                   if (barcode != null) {
                     g.pvar["get_qrcode"] = barcode;
                     g.plink["get_qrcode"] = barcode;
                     ojclick(skey, "scan_qrcode_click");
                   }*/ //checkcode

                   break;
                 case "scan_qrcode":
                 case "_scan_qrcode":
                   /*
                   try {
                     await Permission.camera.request();
                     var rt = await BarcodeScanner.scan();
                     g.pvar["get_qrcode"] = rt.toString();
                     g.plink["get_qrcode"] = rt.toString();
                     ojclick(skey, "scan_qrcode_click");
                     if (g.cmd.containsKey("fx_click")) {
                       ojclick(skey, "fx_click");
                     }
                   } catch (e) {}*/

               //checkcode
                   break;

                 case "android_scan":
                   /*
                   await Permission.camera.request();
                   g.pvar["get_qrcode"] = "";
                   String barcode = await qrscan.scan();
                   g.pvar["get_qrcode"] = barcode;
                   g.plink["get_qrcode"] = barcode;
                   ojclick(skey, "scan_qrcode_click");*/

                   break;


                 case "qcheck":
                   String r = selectx(vcmdtext, skey);
                   alert("qcheck:" + g.q.toString());


                   break;

                 case "_qcheck":

                   String r = selectx(getfval(skey,vcmdtext), skey);
                   alert("_qcheck=" + g.q.toString());
                   // alert("_form="+g.f[skey].toString());
                   break;
                 case "_showk":
                   alert("_readk:" + g.pkey.toString());
                   break;
                 case "_listui":
                 //do_callback();
                   break;

                 case "_clearx":
                 case "f_clearvar":
                 case "f_clearxval":
                   clearval(vcmdtext);
                   break;

                 case "f_removefield":
                   a = vcmdtext.split(",");
                   a.forEach((s1) {
                     b = s1.split(".");
                     switch (b[0]) {
                       case "v":
                         if (g.pvar.containsKey(b[1])) {
                           g.pvar.remove(b[1]);
                         }
                         break;
                       case "l":
                         if (g.plink.containsKey(b[1])) {
                           g.plink.remove(b[1]);
                         }
                         break;
                       case "sys":
                         if (g.sys.containsKey(b[1])) {
                           g.sys.remove(b[1]);
                         }
                         break;
                       case "s":
                         if (g.sys.containsKey(b[1])) {
                           g.sys.remove(b[1]);
                         }
                         break;
                       case "b":
                         if (g.pback.containsKey(b[1])) {
                           g.pback.remove(b[1]);
                         }
                         break;
                       case "fx":
                         if (g.fx.containsKey(b[1])) {
                           g.fx.remove(b[1]);
                         }
                         break;
                     }
                   });
                   break;


                 case "_save2v":
                   try {
                     selectx(vcmdtext, skey);
                     g.q.forEach((k, v) {
                       g.pvar[k] = v;
                     });
                   } catch (e) {}
                   break;
                 case "_save2k":
                   try {
                     selectx(vcmdtext, skey);
                     g.q.forEach((k, v) {
                       g.savekey(k, v);
                     });
                   } catch (e) {}
                   break;
               // a[aa,b[bb,c[cc


                 case "save2l":
                   try {
                     List<String> a = vcmdtext.split(",");
                     List<String> b;
                     a.forEach((s1) {
                       b = s1.split("[");
                       if (b.length >= 2) {
                         g.plink[b[0]] = b[1];
                       }
                     });
                   } catch (e) {}
                   break;

                 case "savedata":
                 case "fsave":
                 case "savex":
                 case "fn_save":
                 case "f_save2":
                   savedata(skey, vcmdtext);
                   break;

                 case "f_save2l":
                   try {
                     a = vcmdtext.split(",");
                     a.forEach((s1) {
                       b = s1.split("[");
                       if (b.length >= 2) {
                         g.plink[b[0]] = b[1];
                       }
                     });
                   } catch (e) {}
                   break;
                 case "f_save2link":
                   try {
                     a = vcmdtext.split(",");
                     a.forEach((s1) {
                       b = s1.split("[");
                       if (b.length >= 2) {
                         g.plink[b[0]] = b[1];
                       }
                     });
                   } catch (e) {}
                   break;

                 case "f_save2v":
                   try {
                     a = vcmdtext.split(",");
                     a.forEach((s1) {
                       b = s1.split("[");
                       if (b.length >= 2) {
                         g.pvar[b[0]] = b[1];
                       }
                     });
                   } catch (e) {}
                   break;
                 case "f_save2back":
                   try {
                     a = vcmdtext.split(",");
                     a.forEach((s1) {
                       b = s1.split("[");
                       if (b.length >= 2) {
                         g.pback[b[0]] = b[1];
                       }
                     });
                   } catch (e) {}
                   break;
                 case "f_save2send":
                   try {
                     a = vcmdtext.split(",");
                     a.forEach((s1) {
                       b = s1.split("[");
                       if (b.length >= 2) {
                         g.psend[b[0]] = b[1];
                       }
                     });
                   } catch (e) {}
                   break;

                 case "f_save2s":
                   try {
                     a = vcmdtext.split(",");
                     a.forEach((s1) {
                       b = s1.split("[");
                       if (b.length >= 2) {
                         g.sys[b[0]] = b[1];
                       }
                     });
                   } catch (e) {}
                   break;

                 case "save2v":
                   try {
                     List<String> a = vcmdtext.split(",");
                     List<String> b;
                     a.forEach((s1) {
                       b = s1.split("[");
                       if (b.length >= 2) {
                         g.pvar[b[0]] = b[1];
                       }
                     });
                   } catch (e) {}
                   break;

                 case "_save2l":
                   try {
                     selectx(vcmdtext, skey);
                     g.q.forEach((k, v) {
                       g.plink[k] = v;
                     });
                   } catch (e) {}
                   break;

                 case "_save2s":
                   try {
                     selectx(vcmdtext, skey);
                     g.q.forEach((k, v) {
                       g.sys[k] = v;
                     });
                   } catch (e) {}
                   break;
               // a[vx,b[vb,c[@vc
                 case "fn_bind":
                   var allui = find.byKey(Key(vcmdtext));
                   alert(vcmdtext + ":" + allui
                       .evaluate()
                       .length
                       .toString());

                   break;
                 case "f_bind":
                 case "_setbind":
                 case "_bindx":
                   f_bind(vcmdtext, skey);
                   break;
                 case "_bind":
                   try {
                     selectx(vcmdtext, skey);
                     print("_bind:" + g.q.toString() + ":" + skey + " " +
                         g.list_ui[skey].toString());
                     if (g.q.length > 0) {
                       g.q.forEach((k, v) {
                         g.saveiform(k, v);
                         update_field(skey, k, v);
                       });
                       g.q.forEach((k, v) {
                         if (g.list_ui[skey].containsKey(k)) {
                           setojval(g.list_ui[skey][k], v);
                         }
                       });
                       //updateui(g.ctx());
                     }
                   } catch (e) {
                     msg("_bind.error." + e.toString());
                   }
                   break;
                 case "into_datagridv2":
                   finto_datagrid(skey, g.cmdval("into_datagridv2"), true);
                   break;

                 case "_clearpui":
                   g.pui[skey].clear();
                   updateuix(g.ctx());
                   break;

                 case "f_clearuser":
                   g.clearuser();

                   break;
                 case "f_clear_pref":
                   await g.clear_pref();
                   break;


                 case "_call_logoff":
                   g.clearuser();
                   g.restartapp("");
                   break;

                   // f_readcheckbox=gridid,field_name
                 case "f_readcheckbox":
                 case "_readcheckbox":
                 //  grd1,grd2,grd3,grd4
                   try {
                     List<String> arr = vcmdtext.split(",");
                     List<String> a;

                     String s = "";

                     Map<String, dynamic> dr = new Map<String, dynamic>();
                     Map<String, dynamic> dr_select = new Map<String,
                         dynamic>();

                     String field_name = "rdata";
                     for (String s1 in arr) {
                       a = s1.split(".");
                       s = a[0];
                       if (a.length >= 2) {
                         field_name = a[1];
                       }
                       int im = g.db[s].length;
                       String sx = "";

                       for (int ir = 0; ir < im; ir++) {
                         dr = g.db[s][ir];
                         if (dr.containsKey("rcheck")) {
                           if (g.cbool(g.null2str(dr["rcheck"]))) {
                             sx += g.fixstrval(g.null2str(dr[field_name])) +
                                 ",";
                           }
                         }
                       }


                       sx = g.rcut(sx);
                       if(g.cmdval("checkbox_in")!="true"){
                         sx =sx.replaceAll(",", " ");
                       }else {
                         sx = sx.replaceAll(",", "','");
                       }
                       sx=sx.trim();


                       s = a[a.length - 1];
                       g.plink["check_list"]=sx;
                       dr_select[s] = sx;
                       g.saveiform(s, sx);
                       if (g.cmdval("save2link") == "true") {
                         dr_select.forEach((tkey, svalue) {
                           g.plink[tkey] = svalue;
                         });
                       }
                     }
                     if (g.isdebug()) {
                       alert("_readcheckbox:" + dr_select.toString());
                     }
                   } catch (e) {
                     //msg("_readcheckbox.error."+e.toString());
                   }
                   break;


                 case "finto_datagrid":
                   into_datagrid(skey, g.jsonx);
                   break;

                 case "json2datagrid":
                   List<String> arr = vcmdtext.split(",");
                   List<String> b;
                   arr.forEach((scol) {
                     b = scol.split(".");
                     if (b.length == 3) {
                       b[1] = b[1] + "." + b[2];
                       b.removeLast();
                     }
                     try {
                       g.db[b[1]] = jsonDecode(g.jsonx)[b[0]] as List;
                       if (g.db_regis[skey] == null) {
                         g.db_regis[skey] = "";
                       }
                       g.db_regis[skey] += b[1];
                       print("regis:" + g.db_regis[skey].toString());
                     } catch (e) {
                       alert("json2datagrid.error" + e.toString());
                     }
                   });
                   finto_datagrid(skey, g.cmdval("json2datagrid"), false);
                   break;

                 case "_datagrid_update":
                   try {
                     allui = find.byType(gridview_ex);
                     gridview_ex wd;
                     for (int i = 0; i < allui
                         .evaluate()
                         .length; i++) {
                       wd = allui
                           .at(i)
                           .evaluate()
                           .single
                           .widget as gridview_ex;
                       if (g.db.containsKey(wd.id())) {
                         g.set_gridcmd(wd.id(), "datagrid_update");
                       }
                     }
                   } catch (e) {
                     print("_datagrid_update.error." + e.toString());
                   }


                   //  for (String skey in g.db.keys) {
                   //      g.db[skey].clear();
                   //  }
                   //
                   //  //update_datagrid(false);
                   // // updateui(this_ctx);

                   break;

                 case "_callfx":
                   var vcmd = vcmdtext.split(".");
                   allui = find.byType(gridview_ex); //find.byKey(Key(ids[1]));
                   gridview_ex wd;
                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     wd = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget as gridview_ex;
                     if (wd.id() == vcmd[0]) {
                       g.set_gridcmd(wd.id(), vcmd[1]);
                       break;
                     }
                   }
                   break;

               //
                 case "f_cboxcmd":
                   try {
                     allui =
                         find.byType(Container2_ex); //find.byKey(Key(ids[1]));
                     Container2_ex wd;
                     b = vcmdtext.split(",");
                     b.forEach((s1) {
                       a = s1.split(".");
                       for (int i = 0; i < allui
                           .evaluate()
                           .length; i++) {
                         wd = allui
                             .at(i)
                             .evaluate()
                             .single
                             .widget as Container2_ex;
                         if (wd.id() != "") {
                           if (g.ischeckid(skey, wd.id(), a[0])) {
                             wd.eventx.add(s1);
                             break;
                           }
                         }
                       }
                     });
                   } catch (e) {
                     alert("f_boxcmd.error." + e.toString());
                   }
                   break;


                 case "_updateui":
                 case "f_updateui":
                   await updateuix(g.ctx());
                   break;
                 case "tmsg":
                   calltmsg(getfval(skey,b[1]));
                   break;
                 case "f_tmsg":
                 case "_tmsg":
                   tmsg(getfval(skey,b[1]));
                   break;
                 case "f_bmsg":
                 case "_bmsg":
                 //  g.tmsg("call _bmsg");
                   g.bmsg(getfval(skey,b[1]));
                   break;
                 case "f_noti":
                   g.show_noti(getfval(skey,b[1]));
                   break;

                 case "f_regis_fmsg":
                   Future.delayed(Duration(milliseconds: 100), () {
                     f_regis_fmsg(skey);
                   });

                   break;
                 case "firebase_add":
                   await firebase_add(skey);
                   break;
               /* case "f_chat":


                  await Navigator.push(
                      g.ctx(),
                      MaterialPageRoute2(
                        builder: (context) =>fchat(),
                      ));
                  break;*/



                 case "_hidedatagrid":
                   try {
                     List<String> a = vcmdtext.split(",");
                     allui = find.byType(gridview_ex);
                     gridview_ex wd;
                     int im = allui
                         .evaluate()
                         .length;

                     for (int i = 0; i < im; i++) {
                       wd = allui
                           .at(i)
                           .evaluate()
                           .single
                           .widget as gridview_ex;
                       a.forEach((s) {
                         if (s == wd.id()) {
                           //wd.setcmd("hide");
                           wd.eventx.add("hide");
                         }
                       });
                     }
                   } catch (e) {}
                   break;
                 case "f_clear_datagrid":
                 case "_cleardatagrid":
                   try {
                     List<String> a = vcmdtext.split(",");
                     allui = find.byType(gridview_ex);
                     gridview_ex wd;
                     int im = allui
                         .evaluate()
                         .length;
                     for (int i = 0; i < im; i++) {
                       wd = allui
                           .at(i)
                           .evaluate()
                           .single
                           .widget as gridview_ex;

                       a.forEach((vid) {
                         if (g.idmath(wd.id(),vid)) {
                           wd.eventx.add("cleardb");
                         }
                       });


                     }
                   } catch (e) {}
                   break;


                 case "f_localnoti":
                   g.local_noti(
                       g.cmdval("noti_title"), g.cmdval("noti_detail"), "",
                       g.cmdval("noti_pic"));
                   break;

                 case "f_facebook_login":
                  // f_facebook_login();
                   break;
                 case "f_facebook_logoff":
                  // f_facebook_logoff();
                   break;

                 case "f_google_login":
                   f_google_login();
                   break;
                 case "f_google_logoff":
                   f_google_logoff();
                   break;
                 case "f_phone_login":
                   f_phone_login();
                   break;

                 case "f_apple_login":
                   f_apple_login();
                   break;
                 case "callpayx":
                   tmsg("callpayx");
                   break;
                 case "f_firebase_sub":
                   if (g.regis_firebase) {
                     try {
                       a = vcmdtext.split(",");
                       a.forEach((s1) {
                         if (s1 != "") {
                           FirebaseMessaging.instance.subscribeToTopic(
                               s1); // subscribe topic News
                         }
                       });
                     } catch (e) {}
                   }

                   break;
                 case "f_firebase_unsub":
                   if (g.regis_firebase) {
                     try {
                       a = vcmdtext.split(",");
                       a.forEach((s1) {
                         if (s1 != "") {
                           FirebaseMessaging.instance.unsubscribeFromTopic(
                               s1); // subscribe topic News
                         }
                       });
                     } catch (e) {}
                   }

                   break;

                 case "_readeviceinfo":
                   g.getdevice_info();
                   break;

                 case "test":
                   String sfilename = g.getvdofile("");
                   tmsg("temp file name:" + sfilename);
                   break;

                 case "stack_cmd":
                 // swithcmd,paramter,uiid
                   allui =
                       find.byType(
                           indexedstackui_ex); //find.byKey(Key(ids[1]));
                   indexedstackui_ex wd;
                   a = vcmdtext.split(",");
                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     wd = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget;
                     if (a.length == 3) {
                       if (g.idmath(wd.getid(), a[2])) {
                         wd.addevent(vcmdtext);
                       }
                     } else {
                       wd.addevent(vcmdtext);
                     }
                   }
                   break;

                 case "web_cmd":

                 /*  allui = find.byType(webview_ex); //find.byKey(Key(ids[1]));
                   webview_ex wd;
                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     wd = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget;
                     wd.addevent(vcmdtext);
                   }*/
                   break;
                 case "restart_app":
                   g.restartapp("");
                   break;

                 case "app_restart":
                   g.restartapp(vcmdtext);
                   break;

                 case "settime_init0":
                   g.time_init0 = g.cint(vcmdtext, 0);
                   break;

                 case "start_app":
                   g.savekey("appid", vcmdtext);
                   g.restartapp("");
                   break;
                 case "setcallrclick":
                   g.callrclick = (vcmdtext == "true");
                   break;


                 case "regis_eventx":
                   regis_eventx(skey);
                   break;

                 case "f_tabcmd":
                   allui = find.byType(tabbox_ex); //find.byKey(Key(ids[1]));
                   tabbox_ex wd;
                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     wd = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget as tabbox_ex;
                     a = vcmdtext.split(",");
                     a.forEach((s1) {
                       b = s1.split(".");
                       if (b[0] == wd.id()) {
                         wd.eventx.add(s1);
                       }
                     });
                   }


                   // Future.delayed( Duration(milliseconds: 500), () {
                   //
                   //   f_readui(skey);
                   //   if(g.list_ui[skey].containsKey("init0")){
                   //      text_ex b=g.list_ui[skey]["init0"];
                   //      cmd(b.getcmd(),skey,true);
                   //
                   //   }
                   // });

                   break;

                 case "close_page":
                   g.rclick = "";
                   if (g.cmd.containsKey("callback_ojclick")) {
                     g.rclick = g.cmdval("callback_ojclick");
                   }
                   if (g.cmd.containsKey("rclick_delay")) {
                     g.rclick_delay = g.cint(g.cmdval("rclick_delay"), 0);
                   }
                   if (g.cmdval("send_callback") != "") {
                     selectx(g.null2str(g.cmd["send_callback"]), skey);
                     g.row_callback = new Map<String, dynamic>();
                     g.q.forEach((vkey, vval) {
                       g.row_callback[vkey] = vval;
                     });
                     g.q = new Map<String, dynamic>();
                     g.send_callback = g.cmdval("send_callback");
                   }
                   g.nav = "back";
                   clear_pop();
                   Navigator.pop(g.ctx(), g.q);
                   break;


                 case "f_calldelay":
                   g.calldelay = g.cint(vcmdtext, 0);
                   break;
                 case "nav_time":
                   g.nav_time = g.cint(vcmdtext, 0);
                   break;
                 case "clear_pageform":
                   if (vcmdtext == "*") {
                     g.clear_pageform();
                   } else {
                     a = vcmdtext.split(",");
                     a.forEach((scol) {
                       try {
                         g.iform[g.active_key][scol] = "";
                       } catch (e) {}
                     });
                   }
                   break;
                 case "alert":
                 case "_msgbox":
                   
                   vcmdtext=getfval(skey,vcmdtext);
                   vcmdtext=vcmdtext.replaceAll("?skey",skey);
                   g.alert(vcmdtext);
                   
                   break;


                 case "set_maincolor":
                   g.main_color = vcmdtext;
                   break;

                 case "_update_qloop":
                   g.qloop_key = g.newkey();
                   break;

                 case "f_addstream":
                 case "f_addstreem":
                   a = vcmdtext.split(",");
                   a.forEach((str) {
                     b = str.split("[");
                     g.papp[b[0]] = b[1];
                   });
                   g.app_stream.add("update");
                   break;
                 case "f_setup_firebase":
                   f_setup_firebase(skey);
                   break;
                 case "f_firebase_connect":
                 case "f_firebase_regis":
                   await f_firebase_regis(skey,g.cmd);
                   break;
                 case "f_create_userchat":
                   f_create_userchat(skey);
                   break;
                 case "f_create_account":
                   f_create_account(skey);
                   break;
                 case "f_firebase_login":
                   f_firebase_login(skey);
                   break;
                 case "f_goto_chatlist":
                   f_goto_chatlist();
                   break;
                 case "f_sendnoti":
                   f_sendnoti(skey);
                   break;

                 case "f_openpanel":
                   try{
                     if (vcmdtext == "l") {
                       Scaffold.of(g.ctx()).openDrawer();
                     } else if (vcmdtext == "r") {
                       Scaffold.of(g.ctx()).openEndDrawer();
                     }else {
                       Scaffold.of(g.ctx()).openDrawer();
                     }
                   }catch(e){}
                   break;
                 case "f_datagrid2db":
                   a = vcmdtext.split("[");
                   allui = find.byType(gridview_ex); //find.byKey(Key(ids[1]));
                   gridview_ex wd;
                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     wd = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget as gridview_ex;
                     if (wd.id() == a[0]) {
                       //g.tmsg("found ${a[0]} save to ${a[1]}");
                       g.db[a[1]] = wd.dt;
                     }
                   }
                   break;
                 case "f_datagridfromdb":
                   a = vcmdtext.split("[");
                   allui = find.byType(gridview_ex); //find.byKey(Key(ids[1]));
                   gridview_ex wd;
                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     wd = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget as gridview_ex;
                     if (wd.id() == a[0]) {
                       wd.add_event("setdb[" + vcmdtext);
                       // wd.add_event(s)
                     }
                   }
                   break;

                 case "panel_cmd":
                   switch (vcmdtext) {
                     case "open":
                       panel_control[skey].show();
                       Future.delayed(Duration(milliseconds: 0), () {
                         panel_control[skey].open();
                       });
                       break;
                     case "close":
                       panel_control[skey].close();
                       break;
                     case "hide":
                       panel_control[skey].hide();
                       break;

                     case "show":
                       panel_control[skey].show();
                       break;
                   }
                   break;
                 case "f_mqtt_connect":
                   await f_mqtt_connect(skey);
                   break;
                 case "f_mqtt_sub":
                   await f_mqtt_sub();
                   break;
                 case "f_mqtt_subx":
                   await f_mqtt_connect(skey);
                   // f_mqtt_subx();
                   break;
                 case "f_mqtt_unsub":
                   f_mqtt_unsub();
                   break;
                 case "f_mqtt_pub":
                   f_mqtt_pub();
                   break;
                 case "f_mqtt_discconnect":
                   f_mqtt_discconnect();
                   break;

                 case "firebase_follow":
                   g.firebase_follow(vcmdtext);
                   break;
                 case "firebase_kremove":
                   a = vcmdtext.split(",");
                   a.forEach((s1) {
                     if (k_data.containsKey(s1)) {
                       try {
                         rt_db.child(k_data[s1]).remove();
                       } catch (e) {}
                     }
                   });

                   break;
                 case "firebase_removepath":
                   a = vcmdtext.split(",");
                   a.forEach((s1) {
                     try {
                       rt_db.child(s1).remove();
                     } catch (e) {}
                   });

                   break;

                 case "firebase_x":
                   String spath = g.cmdval("path");
                   var drow = g.readlinepr(vcmdtext);

                   if (g.cmd.containsKey("fbdata")) {
                     List<String> a = g.cmdval("fbdata").split(",");
                     a.forEach((s1) {
                       b = s1.split("[");
                       drow[b[0]] = b[1];
                     });
                   }

                   switch (g.cmdval("ftag")) {
                     case "add":
                       g.rt_db.child(spath).set(drow);
                       break;
                     case "push":
                       g.rt_db.child(spath).push().set(drow);
                       break;
                     case "addnew":
                       g.rt_db.child(spath + "/" + g.getuuid()).set(drow);
                       break;
                     case "edit":
                       g.rt_db.child(spath).update(drow);
                       break;
                     case "del":
                       g.rt_db.child(spath).remove();
                       break;
                   }
                   //firebas
                   break;

                 case "f_showui":

                   a=vcmdtext.split(",");
                   var wd;
                   allui = find.byType(show_ex);
                   show_ex vx;



                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     vx = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget;
                     a.forEach((vid) {
                       if (g.idmath(vx.getid(), vid)) {
                         vx.eventx.add(g.cmdval("show"));
                       }
                     });

                   }
                   break;
                 case "f_updateimg":
                 //img1[url1,img2[url2

                   networkimage_ex imgui;
                   a = vcmdtext.split(",");
                   a.forEach((s1) {
                     b = s1.split("[");
                     vid = b[0];

                     if (g.list_ui[skey].containsKey(vid)) {
                       if (g.list_ui[skey][vid] is networkimage_ex) {
                         imgui = g.list_ui[skey][vid];
                         imgui.eventx.add(b[1]);
                       }
                     }
                     vid = skey + "." + b[0];
                     if (g.list_ui[skey].containsKey(vid)) {
                       if (g.list_ui[skey][vid] is networkimage_ex) {
                         imgui = g.list_ui[skey][vid];
                         imgui.eventx.add(b[1]);
                       }
                     }
                   });

                   // networkimage_ex imgui;
                   // g.list_ui[skey].keys.forEach((scol) {
                   //   if(g.list_ui[skey][scol] is networkimage_ex){
                   //     imgui=g.list_ui[skey][scol];
                   //     imgui.eventx.add("");
                   //   }
                   // });

                   break;
                 case "f_toggle":
                   var wd;
                   allui = find.byType(show_ex);
                   show_ex vx;
                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     vx = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget;
                     if (g.str_in2(vx.getid(), vcmdtext)) {
                       vx.eventx.add("x");
                     }
                   }
                   break;
                 case "f_hideui":
                   var wd;
                   allui = find.byType(show_ex);
                   show_ex vx;
                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     vx = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget;
                     if (g.str_in2(vx.getid(), vcmdtext)) {
                       vx.eventx.add("false");
                     }
                   }
                   break;


                 case "show_nav":
                   if (vcmdtext == "false") {
                     //g.add_event("hide_bottombar");
                   } else {
                    // g.add_event("show_bottombar");
                   }
                   break;

                 case "setxevent":
                   g.add_event(vcmdtext);
                   break;
                 case "f_share":
                 case "_share":

                   Share.share(g.decode_url(vcmdtext));
                   break;

                 case "_updateview":
                   allui = find.byType(textfield_ex); //find.byKey(Key(ids[1]));
                   Widget wd;
                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     wd = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget;
                     setojval(wd, "_edit");
                   }

                   allui = find.byType(text_ex); //find.byKey(Key(ids[1]));
                   text_ex wd2;
                   for (int i = 0; i < allui
                       .evaluate()
                       .length; i++) {
                     wd2 = allui
                         .at(i)
                         .evaluate()
                         .single
                         .widget as text_ex;
                     setojval(wd2, wd2.id() + "_edit");
                   }


                   //tmsg("call updateview: "+g.f.toString());
                   // updateui(g.ctx());
                   break;

                 case "send_rowbind":
                 // try {
                 //   a = vcmdtext.split(".");
                 //   g.rowbind = g.db[a[0]][g.cint(a[1])];
                 //
                 //   if( g.rowbind.length==0){
                 //     alert("not_found_row:"+a.toString());
                 //   }else {
                 //     tmsg(g.rowbind.toString());
                 //   }
                 //
                 // }catch(e){
                 //   alert("send_rowbind.error."+e.toString());
                 // }

                   break;
                 case "saverow2link":
                   a = vcmdtext.split(".");
                   g.q = g.db[a[0]][g.cint(a[1], 0)];
                   g.q.forEach((k, v) {
                     g.plink[k] = v;
                   });
                   break;
                 case "_tmsg":
                   tmsg(getfval(skey,b[1]));
                   break;


                 case "f_read_rcheck":
                   await readrcheck(skey, g.cmdval("f_read_rcheck"));
                   break;

               // datagrid_updaterow=grid_id/r
                 case "datagrid_updaterow":

                   try{

                     cmd_text = getfval(skey, cmd_text);
                     g.readcmd(cmd_text);

                     vcmdtext= await getfval(skey, vcmdtext);

                     var grid_id = vcmdtext.split(",")[0];
                     g.ggrid_id = grid_id;
                     if (g.cmd.containsKey("datagrid_updaterow")) {
                       var ui = getui(skey,ggrid_id);//getui_bytype(skey, ggrid_id, "gridview");

                       // datagrid_updaterow

                       if (ui != null) {
                         print("call_datagrid_updaterow");
                         gridview_ex gx = ui as gridview_ex;
                         gx.add_event("datagrid_updaterow");
                       }
                       else {
                         print(
                             "call_datagrid_updaterow_not_found ${grid_id} : ${vcmdtext} ");
                         print("UI=${g.list_ui[skey].keys}");
                         // alert("not_found_datagrid:${vcmdtext} ${g.list_ui[skey].toString()}");
                       }
                     }

                   }catch(e){}

                   break;


                 case "setrow":
                   vcmdtext= await getfval(skey, vcmdtext);
                   a = vcmdtext.split(",");
                   if (g.list_ui[skey].containsKey(a[0])) {
                     gridview_ex gx = g.list_ui[skey][a[0]];
                     gx.eventx.add("setrow");
                   } else {
                     // alert("not_found_ui:"+a[0]+" from :"+g.list_ui[skey].keys.toString());
                   }

                   break;
                 case "set_checkbox":
                   vcmdtext= await getfval(skey, vcmdtext);
                   var grid_id = vcmdtext.split(",")[0];
                   g.ggrid_id = grid_id;
                   if (g.cmd.containsKey("set_checkbox")) {
                     var ui = getui_bytype(skey, ggrid_id, "gridview");
                     if (ui != null) {
                       print("setrcheck");
                       gridview_ex gx = ui as gridview_ex;
                       gx.add_event("set_checkbox");
                     }
                     else {
                       print(
                           "call_datagrid_updaterow_not_found ${grid_id} : ${vcmdtext} ");
                       print("UI=${g.list_ui[skey].keys}");
                     }
                   }

                   break;

                 case "open_page":
                 case "save2row":
                   try {
                     a = vcmdtext.split(".");
                     if (g.db.containsKey(a[0])) {
                       g.dr = g.db[a[0]][g.cint(a[1], 0)];
                       //g.tmsg("g dr=${g.dr}");

                     } else {
                       // g.tmsg("not_found_${g.db.keys}");
                     }
                   } catch (e) {}
                   break;

                   // delay_click=1000[cmd_x
                 case "delay_click":
                   a=vcmdtext.split("[");
                   int idelay=g.cintx(a[0]);
                   Future.delayed( Duration(milliseconds: idelay), () async {
                     g.t_click=a[1];
                   });
                   break;


                 case "callapi":

                   if(g.cmdval("api_delay")!=""){
                     Future.delayed(Duration(milliseconds: g.cint(g.cmdval("api_delay"),100)), () async {
                       await callapi(skey, getfval(skey,vcmdtext));
                     });
                   }else {
                     await callapi(skey, getfval(skey,vcmdtext));
                   }

                   break;

                 case "callapi2":
                   callapi(skey, getfval(skey,vcmdtext));
                   break;


                 case "openpage":
                 case "p":
                 case "callintent":

                   g.cmd_onetime=false;
                   print("call_from =${skey}");
                 String tval="";
                   Future.delayed(Duration(milliseconds: 1000), () {
                     g.iscall_intent = false;
                   });

                   try {
                     if (!g.iscall_intent) {

                       // reset
                       g.iscall_intent = true;
                       Fluttertoast.cancel();
                       webview_control=null;

                       if(g.cmdval("callapix")!=""){
                          callapi(skey, getfval(skey,g.cmdval("callapix")));
                       }
                       if(g.cmdval("wait_callapix")!=""){
                          await callapi(skey, getfval(skey,g.cmdval("wait_callapix")));
                       }

                       //await g.read_screen(g.ctx());
                       String reqkey = g.genkey();
                       g.c = new Map<String, dynamic>();
                       g.cmd.forEach((v_key, v_value) {
                         g.c[v_key] = v_value;
                       });

                       //v_concat=from,fto,x,roomid

                       try{
                       if(g.cmd.containsKey("send_concat")){
                         a=g.cmdval("send_concat").split(",");
                         if(a.length>=4){
                           xval= g.concate_string(a[0], a[1], a[2]);
                           g.c[a[3]]=xval;
                           g.cmd[a[3]]=xval;
                         }
                       }}catch(e){}


                     //  g.tmsg("cmd=${g.cmd}");
                       try{
                         if(g.cmd.containsKey("send_dr")){

                           List<String> a=g.cmdval("send_dr").split(",");
                           if(g.cmdval("send_dr").contains(".")){
                            a=g.cmdval("send_dr").split(".");
                           }


                           Map<String, dynamic> h = g.db[a[0]][g.cint(a[1], 0)];


                          // g.tmsg("send_dr=${h}");

                           h.forEach((skey, sval) {
                             g.c[skey] =  null2str(sval);
                           });

                         }}catch(e){
                        // g.alert("send_dr.error.${e} from cmd ${{g.cmd}}");
                       }

                  tval=g.cmdval("send_js");
                  try{
                       if(tval!=""){
                         List allrow = jsonDecode(g.jsonx)[tval] as List;
                         if (allrow.length > 0) {
                           Map<String, dynamic> h = allrow[0] as Map<String, dynamic>;
                           h.forEach((skey, sval) {
                             g.c[skey] =  null2str(sval);
                           });
                         }
                       }}catch(e){
                       // g.tmsg("send_js.error.${e}");
                       }


                       g.c["field"] = g.plink["field"];
                       g.c["f_editvalue"] = g.plink["f_editvalue"];
                       g.px[reqkey] = g.c;


                       bool isloadapp = false;
                       String page = b[1];
                       String page_ui;
                       String appid_req = "";
                       String from_appid = "";

                       if (g.cmd.containsKey("call_navtime")) {
                         g.call_navtime = g.cint(g.cmdval("call_navtime"), 0);
                       }


                       if (g.cmd.containsKey("f_lconcat")) {
                         await g.f_concat(g.cmdval("f_lconcat"));
                       }

                       if (g.cmdval("qsend") != "") {
                         selectx(g.cmdval("qsend"), skey);
                         g.q.forEach((key, value) {
                           g.c[key] = value;
                         });
                         //g.tmsg("qsend${g.cmdval("qsend")}= ${g.c}");

                       }


                       if (g.cmd.containsKey("loadapp")) {

                         appid_req = g.newkey();
                         String appid = g.cmdval("loadapp");

                         String ui_path=g.ui_path;
                         // custom load ui path from url
                         if(g.cmdval("ui_path")!=""){
                           ui_path=ui_path_tp.replaceAll("{url}", g.cmdval("ui_path"));
                         }

                         String urlcall = ui_path.replaceAll("{appid}", appid)
                             .replaceAll("{login_id}", g.login_id);

                         urlcall=geturl_ui(urlcall);

                         from_appid = appid;


                         g.json_appui[appid_req] = g.json_ui;
                         g.appid_req = appid_req;
                         g.active_appid = appid;

                         print("loadapp_ui_path=${urlcall}");
//g.tmsg("ui_path=${urlcall}");
                         final rx = await
                         g.http_get(g.geturl(urlcall));

                         if (rx.statusCode == 200) {
                           g.appui = rx.body;
                           g.json_ui = jsonDecode(g.appui);
                           // alert("load_ui"+ g.json_ui.keys.length.toString());
                           g.readappconfig_fromjson();


                           /*  g.json_ui=jsonDecode(rx.body);
                      g.app_database=jsonDecode(rx.body);
                      g.is_loadapp=true;*/


                         }
                       }

                       /*  if(g.json_appui.containsKey(g.active_appid)){

                    sui=g.readinfo(g.json_appui[g.active_appid],page);
                    g.json_ui=g.json_appui[g.active_appid];
                    sui=g.readinfo(g.json_ui,page);

                  }else {
                    sui=g.readinfo(g.json_ui,page);
                  }*/

                       page_ui = g.read_json(g.json_ui, page);
                       if (page_ui == "") {
                         if (!vcmdtext.contains(",")) {

/*

                      Map<String, dynamic> map = g.json_ui as Map<String, dynamic>;
                      String s="";
                      map.keys.forEach((s1) {
                        s+=s1+",";
                      });
*/


                           // alert("page_not_found:"+page+"  from: "+sui);
                           // print("page_not_found:"+page+"  from: "+sui);

                           // break;
                         }
                       }


                       g.row_callback = new Map<String, dynamic>();
                       g.nav = "next";
                       g.active_key = skey;
                       int time_callintent = g.time_waitui_intent;
                       String sclass = g.null2str(g.cmd["class"]);
                       bool is_appbar = true;

                       g.send_bind.clear();



                       page_ui = page_ui.replaceAll("{k}", skey);
                       page_ui = page_ui.replaceAll('"id":"', '"id":"$reqkey.');

                       if (g.cmd.containsKey("send_callapi")) {
                         selectx(g.cmd["send_callapi"], skey);
                         g.send_callapi = "";
                         g.q.forEach((k, v) {
                           g.send_callapi += "&" + k + "=" + v;
                         });
                         g.send_callapi = g.url_api + g.send_callapi;
                         print("send_callapi:" + g.send_callapi);
                       }
                       if (g.cmd.containsKey("send_bind")) {
                         g.q.clear();
                         selectx(g.cmd["send_bind"], skey);
                         g.send_bind.clear();
                         g.q.forEach((k, v) {
                           page_ui = page_ui.replaceAll("{s.$k}", v);
                           g.send_bind[k] = v;
                         });
                       }

                       //send_data=a[aa,b[bb,c[cc
                       if (g.cmd.containsKey("send_data")) {
                         List<String> a = g.cmdval("send_data").split(",");
                         List<String> b;
                         a.forEach((str) {
                           b = str.split("[");
                           if (b.length >= 2) {
                             g.send_bind[b[0]] = b[1];
                           }
                         });
                       }

                       if (g.cmd.containsKey("time_callintent")) {
                         time_callintent = g.cint(g.cmd["time_callintent"], 0);
                       }

                       if (g.cmd.containsKey("send_rowbind")) {
                         try {
                           a = g.cmdval("send_rowbind").split(".");
                           if (a.length == 3) {
                             a[0] = a[0] + "." + a[1];
                             a[1] = a[2];
                             a.removeLast();
                           }
                           g.tmp = g.db[a[0]][g.cint(a[1], 0)];
                           g.tmp.forEach((k, v) {
                             page_ui = page_ui.replaceAll("{s.$k}", v);
                           });
                         } catch (e) {
                           //alert("send_rowbind.error."+e.toString()+":"+a.toString());
                         }
                       }


                       bool replace_page = false;
                       if (g.cmd.containsKey("replace_page")) {
                         replace_page = (g.cmd["replace_page"] == "true");
                       }

                       g.init0cmd = "";
                       g.iscall_intent = true;

                       if (g.cmd.containsKey("init_run")) {
                         if (g.cmdval("init_run") == "false") {
                           g.init_run = false;
                         }
                       }



                       var page_key=g.genkey();
                       page_db[reqkey+"_json"]=g.jsonx;

                       page_ui=page_ui.replaceAll("{page_guid}",g.getuuid());

                       if (g.cmd.containsKey("show_type")) {
                         docallintent(
                             g.ctx(),
                             page_ui,
                             reqkey,
                             time_callintent,
                             skey,
                             replace_page,
                             g.cmdval("show_type"),
                             page,
                             cmd_text,
                             from_appid,
                             page,
                             appid_req);
                         break;
                       }
                       if (page != "") {
                         docallintent(
                             g.ctx(),
                             page_ui,
                             reqkey,
                             time_callintent,
                             skey,
                             replace_page,
                             "",
                             page,
                             cmd_text,
                             from_appid,
                             page,
                             appid_req);
                       }
                     } else {

                     }
                   } catch (e) {}

                   // auto clear


                   break;


               /* case "cmd_clearfield":
                  clear_field(skey,vcmdtext);
                  break;*/
                 case "_setupdateid":
                   g.update_id = g.newkey();
                   break;

                 case "auto_closepage":

                   int idelay = 100;
                   if (g.isNumeric(vcmdtext)) {
                     idelay = g.cint(vcmdtext, 0);
                   }

                   Future.delayed(Duration(milliseconds: idelay), () async {
                     g.nav = "back";
                     clear_pop();
                     Navigator.pop(g.ctx(), g.q);
                   });
                   break;

                 case "nav_exit_count":

                   nav_count=g.cint(vcmdtext,0);
                   g.nav = "back";
                   Navigator.pop(g.ctx(), g.q);

                   break;

                 case "nav_exit_code":

                   nav_code=vcmdtext;
                   g.nav = "back";
                   Navigator.pop(g.ctx(), g.q);

                   break;


                 case "nav_exit":
                   f_nav_exit(vcmdtext);
                   break;

                 case "closepage":

                   g.vcmdtext=vcmdtext;
                   g.show_loadding(false);
                   if (vcmdtext != "true") {
                     g.rclick = vcmdtext;
                   }
                   if (g.cmdval("send_callback") != "") {
                     selectx(g.null2str(g.cmd["send_callback"]), skey);
                     g.row_callback = new Map<String, dynamic>();
                     g.q.forEach((vkey, vval) {
                       g.row_callback[vkey] = vval;
                     });
                     g.q = new Map<String, dynamic>();
                     g.send_callback = g.cmdval("send_callback");
                   }
                   g.nav = "back";
                   clear_pop();
                   Navigator.pop(g.ctx(), g.q);

                   break;


                 case "fclick":
                 case "_ojclick":
                   int idelay = 0;
                   if (g.cmd.containsKey("fclick_delay")) {
                     idelay = g.cint(g.cmdval("fclick_delay"), 0);
                   }
                   Future.delayed(Duration(milliseconds: idelay), () {
                     //alert("ojclick:${vcmdtext}: from "+g.cmdval("_ojclick"));
                     ojclick(skey, g.cmdval("_ojclick"));
                   });
                   break;

                 case "r_close":
                   g.rclick = vcmdtext;
                   g.nav = "back";
                   clear_pop();
                   Navigator.pop(g.ctx(), g.q);

                   break;

                 case "exit_page_dialog":
                   String sval = g.backcmd;
                   g.backcmd = "";
                   g.nav = "back";
                   //Future.delayed(Duration(milliseconds: 10), () {
                   loopcmd(sval, skey, false);
                   // });
                   clear_pop();
                   Navigator.pop(g.ctx(), g.q);
                   break;

                 case "exit_page":

                   try{
                     g.nav = "back";
                     Navigator.pop(g.ctx());
                   }catch(e){}
                   break;
               }

               if (vcmd == "cmd") {
                 switch (vcmdtext) {
                   case "gridcmd":
                   // msg(skey);
                     allui =
                         find.byType(gridview_ex); //find.byKey(Key(ids[1]));
                     vid = g.cmdval("id");

                     gridview_ex wd;
                     for (int i = 0; i < allui
                         .evaluate()
                         .length; i++) {
                       wd = allui
                           .at(i)
                           .evaluate()
                           .single
                           .widget as gridview_ex;
                       if (wd.id() == vid) {
                         g.set_gridcmd(vid, g.cmdval("gridcmd"));
                         break;
                       }
                     }

                     break;


                   case "close_page":
                     g.rclick = "";
                     if (g.cmd.containsKey("callback_ojclick")) {
                       g.rclick = g.cmdval("callback_ojclick");
                     }
                     if (g.cmd.containsKey("rclick_delay")) {
                       g.rclick_delay = g.cint(g.cmdval("rclick_delay"), 0);
                     }
                     if (g.cmdval("send_callback") != "") {
                       selectx(g.null2str(g.cmd["send_callback"]), skey);
                       g.row_callback = new Map<String, dynamic>();
                       g.q.forEach((vkey, vval) {
                         g.row_callback[vkey] = vval;
                       });
                       g.q = new Map<String, dynamic>();
                       g.send_callback = g.cmdval("send_callback");
                     }
                     g.nav = "back";
                     clear_pop();
                     Navigator.pop(g.ctx(), g.q);

                     break;
                 }
               }

               if (g.cmdval("call_tclick") != "") {
                 g.t_click = g.cmdval("call_tclick");
               }
             }
           }
         }
       }

       try{
       if (g.cmdval("e_click") != "") {
         String e_click = g.cmdval("e_click");
         int e_click_delay = g.cint(g.cmdval("e_click_delay"), 0);
         Future.delayed(Duration(milliseconds: e_click_delay), () {
           ojclick(skey, e_click);
         });
       }
       if (g.cmdval("call_tclick") != "") {
         Future.delayed(Duration(milliseconds: 100), () {
           g.t_click = g.cmdval("call_tclick");
         });
       }
       if (g.cmdval("end_click") != "") {
         Future.delayed(Duration(milliseconds: 100), () {
           g.tmsg("end_click");
           g.t_click = g.cmdval("end_click");
         });
       }}catch(e){}
       g.cmd_index+=1;
       if(g.cmd_index<g.allcmd.length){
         runcmd(g.allcmd[cmd_index],skey,isinit);
       }

     });
   } catch (e) {
     print("cmd_error:" + e.toString());
     msg("cmd_error:" + e.toString());
   }
 } // end can_run
}


void firebase_cmd(String cmd,String skey){

  if(g.regis_firebase){


    try {
      String spath = g.null2str(g.cmdval("path"));
      if (spath == "") {
        spath = "x";
      }

      List<String> a, b;

      selectx(g.null2str(g.cmdval("qx")), skey);

      if (g.cmd.containsKey("fbdata")) {
        List<String> a = g.cmdval("fbdata").split(",");
        a.forEach((s1) {
          b = s1.split("[");
          g.q[b[0]] = b[1];
        });
      }


/*

    alert(
        "firebase_cmd:" + cmd + " path= " + spath + "data= " + g.q.toString());

*/


      if(spath!=""){
        switch (cmd) {
          case "add":
            g.rt_db.child(spath).set(g.q);
            break;
          case "push":
            g.rt_db.child(spath).push().set(g.q);
            break;
          case "addnew":
            g.rt_db.child(spath + "/" + g.getuuid()).set(g.q);
            break;
          case "edit":
            g.rt_db.child(spath).update(g.q);
            break;
          case "del":
            g.rt_db.child(spath).remove();
            break;
        }
      }



      //alert("firebase_cmd.ok"+g.rt_db.toString());
    }catch(e){
      //alert("firebase_cmd.error."+e.toString());
    }

  }


}



docallintent(BuildContext btx,
    String page_ui,
    String reqkey,
    int time_waitui,
    String page_key,
    isreplace,
    String show_type,
    String page_name,
    String cmd_text,
    String from_appid,
    String reqpage,
    String appid_req
    ) async {


  // reset call intent
  g.isrun=true;
  g.nav=="";
  g.gdatetime=new DateTime.now();
  g.player_url="";
  g.vcmdtext="";


  if(g.c.containsKey("wait_page_active")){
    g.wait_page_active(g.cint(g.null2str(g.c["wait_page_active"]), 400));
  }



// if(reqpage.contains(",")){
  //   g.ctx()box[reqid]=btx;
  // }

  List<String> a;
  var results;
  g.this_skey=reqkey;

  bool is_swippage=false;
  bool is_tabcontrol=false;

  if(g.cmdval("swipe_page")=="true"){
    is_swippage=true;
  }



  //SwipeablePageRoute

  if(show_type==""){
    if(!isreplace){
      // push next
      if(!page_name.contains(",")){
        if(!is_swippage){
          if(g.cmdval("show_type")=="fullscreen"){


            results= await Navigator.of(btx).push(new MaterialPageRoute<Null>(
                builder: (context) =>loadpage(page_name,false,page_ui,reqkey,true,null,time_waitui,0),
                fullscreenDialog: true
            ));

          }else {

            //main.callintent


            var page = await loadpage(page_name,false,page_ui,reqkey,true,null,time_waitui,0);
            if(g.c.containsKey("page_background")){
              results = await showCupertinoModalPopup(context: btx, builder:
                  (btx) => page
              );



            }else {


              String push_tag=g.cmdval("push_tag");
              switch(push_tag){
                case "a":
                  results= await Navigator.push(
                      btx,
                      MaterialTransparentRoute(
                          builder: (context) => page
                      ));
                  break;
                case "b":
                  results=  Navigator.of(btx).push(TransparentRoute(builder: (BuildContext context) => page));
                  break;

                case "c":
                  results=  await btx.pushTransparentRoute(page);
                  break;
                case "d":
                  results = Navigator.of(btx).push(
                    PageRouteBuilder(
                      transitionDuration:Duration(milliseconds:100),
                      reverseTransitionDuration:Duration(milliseconds:100),
                      opaque: false, // set to false
                      pageBuilder: (_, __, ___) => page,
                    ),
                  );
                  break;
                case "default":
                  results= await Navigator.push(
                      btx,
                      MaterialPageRoute(
                          builder: (context) => page
                      ));
                  break;
                default:
              results= await Navigator.push(
                      btx,
                  MaterialPageRoute2(
                          builder: (context) => page
                      ));
                  break;

              }


            }

          }

        }else {

          // swipe_back
          results=
              showModalBottomSheet(
              enableDrag: false,
              backgroundColor: Colors.transparent,
              context: btx,
              isScrollControlled: true,
              isDismissible: true,
              builder: (BuildContext context) {
                return

                   Dismissible(
                          direction: DismissDirection.startToEnd,
                          key:  Key(g.newkey()),
                          onDismissed: (_)  {
                            Navigator.of(btx).pop();

                          } ,
                          child:
                          FractionallySizedBox(
                            heightFactor:1.0,
                            child: loadpage(page_name,false,page_ui,reqkey,false,null,time_waitui,0),
                          )
                      );

              }
          );



        }

      }else {
        results= await Navigator.push(
            btx,
            MaterialPageRoute2(
                builder: (context) =>tabcontrol(page_name,context,g.cmdval("tabinfo"))
            ));
      }
    }else {


      // replace page

      if(!page_name.contains(",")){
        results= await Navigator.pushReplacement(
            btx,
            MaterialPageRoute2(
                builder: (context) =>loadpage(page_name,false,page_ui,reqkey,true,null,time_waitui,0)
            ));
      }else {

        results= await Navigator.pushReplacement(
            btx,
            MaterialPageRoute2(
                builder: (context) =>tabcontrol(page_name,context,g.cmdval("tabinfo"))
            ));
      }
    }
  }

  //bottom_sheet



 // g.tmsg(show_type);


  var vscroll=g.cmdval("close_dir");
  var vdirection=DismissDirection.startToEnd;
  switch(vscroll){
    case "up":
      vdirection=DismissDirection.up;
      break;
    case "down":
      vdirection=DismissDirection.down;
      break;
    case "h":
      vdirection=DismissDirection.horizontal;
      break;
    case "v":
      vdirection=DismissDirection.vertical;
      break;
    case "start2end":
      vdirection=DismissDirection.startToEnd;
      break;
    case "end2start":
      vdirection=DismissDirection.endToStart;
      break;
  }



  switch(show_type){

    case "swipeback":

      double i_height=g.null2num(g.cmdval("bottom_sheet_height"),0.6);
      double i_width=1.0;
      if(g.cmd.containsKey("top_space")){
        double top=g.cdbl(g.cmdval("top_space"),100);
        double height = g.screen_h;
        i_height=(10-((top*100)/height)/10)/10;// (top*100)/height;
      }
      if(g.cmd.containsKey("panel_height")){
        i_height=g.cdbl(g.cmdval("panel_height"),100);
      }
      if(g.cmd.containsKey("setxy")){
        a=g.cmdval("setxy").split(",");
        i_width=g.cdbl(a[0],1.0);
        i_height=g.cdbl(a[1],1.0);
      }


      results =  await showDialog(
          context: btx,
          useSafeArea: true,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return
              loadpage(page_name,false,page_ui,reqkey,false,null,time_waitui,0);

          }
      );

      break;
    /*case "full_dialog":


      results =  await showDialog(
          context: btx,
          useSafeArea: true,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return
              FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor:1.0,
                child: loadpage(page_name,false,sui,reqkey,false,null,time_waitui,0),
              );

          }
      );
      break;*/


      case "gdialog":
        results =  await showGeneralDialog(
          context: btx,
          barrierColor: Colors.transparent, // Background color
          barrierLabel: g.null2str(g.cmdval("page_name")),
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (_, __, ___) {
            return loadpage(page_name,false,page_ui,reqkey,false,null,time_waitui,0);
          },
        );
        break;

    case "dialog":

      double i_height=g.null2num(g.cmdval("bottom_sheet_height"),0.6);
      double i_width=1.0;
      if(g.cmd.containsKey("top_space")){
        double top=g.cdbl(g.cmdval("top_space"),100);
        double height = g.screen_h;
        i_height=(10-((top*100)/height)/10)/10;// (top*100)/height;
      }
      if(g.cmd.containsKey("panel_height")){
        i_height=g.cdbl(g.cmdval("panel_height"),100);
      }
      if(g.cmd.containsKey("setxy")){
        a=g.cmdval("setxy").split(",");
        i_width=g.cdbl(a[0],1.0);
        i_height=g.cdbl(a[1],1.0);
      }

      results =  await showDialog(
          context: btx,
          useSafeArea: true,
          barrierDismissible: true,
         // useRootNavigator:g.readbool(g.cmdval("set_root_nav"), true),
          builder: (BuildContext context) {
            return

              FractionallySizedBox(
                widthFactor: i_width,
                heightFactor:i_height,
                child: loadpage(page_name,false,page_ui,reqkey,false,null,time_waitui,0),
              );

             /* Dismissible(
                  direction: vdirection,
                  movementDuration:  Duration(milliseconds: 1),
                  key:  Key(g.newkey()),
                  onDismissed: (_)  {
                    Navigator.of(context).pop();

                  } ,
                  child:
                  FractionallySizedBox(
                    widthFactor: i_width,
                    heightFactor:i_height,
                    child: loadpage(page_name,false,sui,reqkey,false,null,time_waitui,0),
                  )
              );*/

          }
      );
      break;
    case "drag_bottom_sheet":

    case "bottom_sheet2":

    var iheight=double.maxFinite;

    if(g.cmd.containsKey("top_space")){
      iheight=g.screen_h-g.cdbl(g.cmdval("top_space"),0);
    }
    if(g.cmd.containsKey("height")){
      iheight=g.cdbl(g.cmdval("height"),iheight);
    }
    if(g.cmd.containsKey("pheight")){
      iheight=g.screen_h*cdbl(g.cmdval("pheight"),1.0);
    }

    results =  await  showMaterialModalBottomSheet(
        expand: g.cmdval("expand")=="true"?true:false,
        backgroundColor: Colors.transparent,
        duration: Duration(milliseconds: 0),
        context: g.ctx(),
        builder: (context) => Container(
          height: iheight,
            child:  loadpage(page_name,false,
            page_ui,
            reqkey,
            false,//
            null,
            time_waitui,
            0))
    );
      break;
    case "bottom_sheet":
      results =  await  show_bottom_sheet(
            loadpage(page_name,false,
                page_ui,
                reqkey,
                false,//
                null,
                time_waitui,
                0),show_type);
        g.is_bottom_sheet=false;

        break;
  }


  if (results != null) {
    print("do call intent callback");
  }


  Future.delayed( Duration(milliseconds: g.time_wait_intent_callback), () {
    rcallintent(page_key,btx,cmd_text,from_appid,reqpage,appid_req);
  });



}




show_bottom_sheet(loadpage lp,String tag){


  double top_radius=0.0;
  bool is_expand=false;
  Color bk_color= Colors.transparent;
  if(g.cmd.containsKey("top_radius")){
    top_radius=g.cdbl(g.cmdval("top_radius"),0.0);
  }
  if(g.cmd.containsKey("bk_color")){
    bk_color=g.getcolor(g.cmdval("bk_color"));
  }

  double ih = g.null2num(g.cmdval("bottom_sheet_height"), 0.4);
  double iw=1.0;
  if (g.cmd.containsKey("top_space")) {
    double top = g.cdbl(g.cmdval("top_space"), 100);
    double height =g.screen_h;
    ih = (10 - ((top * 100) / height) / 10) / 10; // (top*100)/height;

  }

  if (g.cmd.containsKey("panel_height")) {
    double top = g.cdbl(g.cmdval("panel_height"), 100);
    double height = g.screen_h;
    ih = (((top * 100) / height) / 10) / 10; // (top*100)/heigh
  }
  if(g.cmd.containsKey("pheight")){
    ih=cdbl(g.cmdval("pheight"),1.0);
  }

    return showModalBottomSheet(
        isScrollControlled: true,
        context: g.ctx(),
        builder: (context) =>
        Container(
                child: FractionallySizedBox(
                    heightFactor: ih,
                    widthFactor: iw,
                    child: Container(child: lp))));


}

class DialogUtils {
  static Future<bool> dialog_yesno(
      BuildContext context, String title, String message) async {

    if(title==""){
      title="Confirm";
    }
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:   SingleChildScrollView( // won't be scrollable
            child: Text(message),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(0.0),

        ),
                primary: g.getcolor("#FFFFFF"),
                onPrimary:Color.fromRGBO(0, 0, 0, 1.0),
                padding: EdgeInsets.all(8),
                textStyle: TextStyle(fontSize: 18, ),
              ),
              child:  Text("No"),
              onPressed: () {
                Navigator.of(context).pop(false);


              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(0.0),
        ),
                primary: g.getcolor("#000000"),
                padding: EdgeInsets.all(8),
                textStyle: TextStyle(fontSize: 18),
              ),
              child:  Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}


class _TransparentPageRoute<T> extends MaterialPageRoute<T> {
  _TransparentPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState,
    bool fullscreenDialog,
  }) : super(
    builder: builder,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
  );

  @override
  bool get opaque => false;
}


class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
      builder: builder,
      maintainState: maintainState,
      settings: settings,
      fullscreenDialog: fullscreenDialog);

  @override
  Color get barrierColor => Colors.transparent;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration =>  Duration(milliseconds: g.getnavtime());

  @override

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class MaterialTransparentRoute2<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  MaterialTransparentRoute2({
    @required this.builder, RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false, }) : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(settings: settings,
          fullscreenDialog: fullscreenDialog);
  final WidgetBuilder builder; @override Widget buildContent(BuildContext context) => builder(context);
  @override bool get opaque => false;
  @override final bool maintainState;
  @override
  Duration get transitionDuration =>  Duration(milliseconds: 0);
  @override String get debugLabel => '${super.debugLabel}(${settings.name})';
}

class MaterialTransparentRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  MaterialTransparentRoute({
    @required this.builder,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder builder;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  bool get opaque => false;


  @override
  Duration get transitionDuration =>  Duration(milliseconds: g.getnavtime());

  @override
  final bool maintainState;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}




class MaterialPageRoute2 extends MaterialPageRoute {
  MaterialPageRoute2({builder}) : super(builder: builder);
  @override
  Duration get transitionDuration =>  Duration(milliseconds: g.getnavtime());



}


class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration =>  Duration(milliseconds: g.getnavtime());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
   /* final result = builder(context);

    const begin = Offset(0.2, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
*/
    return builder(context);
  }
}


/*class SwipeablePageRoute2 extends SwipeablePageRoute {
  SwipeablePageRoute2({builder, bool onlySwipeFromEdge}) : super(builder: builder);
  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}*/



/*
class DismissKeyboard extends StatelessWidget {
  final Widget child;
  DismissKeyboard({this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: child,
    );
  }
}
*/


class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}





extension FileExtention on FileSystemEntity{
  String get name {
    return this?.path?.split("/")?.last;
  }
}


class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  static final _item = MediaItem(
    id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
    album: "Science Friday",
    title: "A Salute To Head-Scratching Science",
    artist: "Science Friday and WNYC Studios",
    duration: const Duration(milliseconds: 5739820),
    artUri: Uri.parse(
        'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
  );

  final _player = AudioPlayer();

  /// Initialise our audio handler.
  AudioPlayerHandler() {
    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // ... and also the current media item via mediaItem.
    mediaItem.add(_item);

    // Load the player.
    _player.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));
  }

  // In this simple example, we handle only 4 actions: play, pause, seek and
  // stop. Any button press from the Flutter UI, notification, lock screen or
  // headset will be routed through to these 4 methods so that you can handle
  // your audio playback logic in one place.

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  /// Transform a just_audio event into an audio_service state.
  ///
  /// This method is used from the constructor. Every event received from the
  /// just_audio player will be transformed into an audio_service state so that
  /// it can be broadcast to audio_service clients.
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState],
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack();
        }
        break;
    }
  }
}