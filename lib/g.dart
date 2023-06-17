// TODO Implement this library.
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:context_holder/context_holder.dart';
import 'package:dio/dio.dart';
//import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_js/javascript_runtime.dart';
//import 'package:flutter_restart/flutter_restart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/public/tau.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart' as gplace;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share/share.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:system_settings/system_settings.dart';

import '../main.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:thumbnails/thumbnails.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:connectivity/connectivity.dart';
//import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'dart:ui' as ui;


import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
//import 'package:geolocation/geolocation.dart' as geo;
import 'package:location/location.dart';


import 'dart:developer' as logger;
import 'dart:math' as math;



// preloved
String vcmdtext ="";
DateTime currentBackPressTime;
DateTime run_time=null ;
InAppWebViewController webview_control=null;




String main_appid="x2";
String  server_path="https://prelovedthailand.com";
String  ui_path="https://prelovedthailand.com/getui.php?login_id={login_id}&appid={appid}&device_os={device_os}&screen_x={screen_x}&screen_y={screen_y}&osv={osv}&code_version={code_version}";




String ui_path_tp  = "{url}/getui.php?login_id={login_id}&appid={appid}&device_os={device_os}&screen_x={screen_x}&screen_y={screen_y}&osv={osv}&code_version={code_version}";
String url_pin       = server_path+"/gimg/pin.png";
String nophoto_url   = server_path+"/gimg/init_photo.png";
String url_closeicon = server_path+"/gimg/wclose.png";

String android_sha="5C:5C:40:97:76:8A:8E:98:B9:DD:CB:D5:C7:26:E9:EB:3B:41:E8:87";
String google_api_key="";
LatLng my_location = LatLng(13.6675878,100.6816933);


Map<String, dynamic> g_database = new Map<String, dynamic>();
Map<String, dynamic> hx = new Map<String, dynamic>();

GoogleSignInAccount googleUser;

BluetoothPrint bluetoothPrint = BluetoothPrint.instance;


String textfield_background_colorx="#FFFFFF";
String gborder_color="#D9D9D9";
String gfirebase_token;




bool cmd_onetime=false;
bool isshow_overlay=false;





FijkPlayer xplayer = FijkPlayer();
FijkPlayer player = FijkPlayer();

JavascriptRuntime flutterJs=null;


UserCredential fb_user;



LatLng g_location;



List<String> allcmd;
int cmd_index=0;
int nav_count=0;
String nav_code="";

String p_point;
AudioHandler a_player=null;
bool init_run=true;
bool init0_req=false;
//FacebookLogin facebookLogin = FacebookLogin();

DateTime gdatetime;


bool enable_service=true;


int iservice=1000;




bool can_runcmd=true;
int reqid=0;

String tab_ui="test";
bool regis_firebase=true;
String g_startcolor="#F7F6E8";
String main_color="#095595";

String service_mqtt_server="";
String service_mqtt_sub="";
String xcmd="";
String backcmd="";


double  screen_w=0.0;
double  screen_h=0.0;



String lock_time="";

String ggrid_id="";

// player
List<CameraDescription> gcameras;
CameraController cam_ctrl;
final FijkPlayer g_vdoplayer =  FijkPlayer();


FlutterSound flutterSound = new FlutterSound();
FlutterSoundRecorder recordingSession;




String cfg_api_pr="";
bool callapi_ok=false;
bool iscall_intent=false;
bool is_active=true;
bool is_bottom_sheet=false;

bool nav_is_exit=false;

var ui_wait;

String page_rbind="";


String ui_version="";
String app_name="";
String api_url_log="";

String active_appid="";
String select_filetype="";
String appid_req="";
String rcmd_text="";
String mqtt_msg="";

String service_msg="";

List<String> cmdq;

String xval="";

var gplayer = AudioPlayer();                   // Create a player

StreamController<String> ev =null;
StreamController<String> app_stream = new StreamController.broadcast();
MqttServerClient gmqtt_client=null;
MqttServerClient gmqtt_service=null;


Map<String, MqttServerClient> gmqtt = new Map<String, MqttServerClient>();


String strload_ui = '''

{
  "type": "Column",
  "crossAxisAlignment": "start",
  "mainAxisAlignment": "start",
  "mainAxisSize": "max",
  "textBaseline": "alphabetic",
  "textDirection": "ltr",
  "verticalDirection": "down",
  "children":[
    {
      "type" : "Text",
      "data" : "Flutter"
    },
    {
      "type": "RaisedButton",
      "color": "##FF00FF",
      "padding": "8,8,8,8",
      "textColor": "#00FF00",
      "elevation" : 8.0,
      "splashColor" : "#00FF00",
      "child" : {
        "type": "Text",
        "data": "Widget"
      }
    },
    {
      "type" : "Text",
      "data" : "Demo"
    }
  ]
}
''';






bool g_resetcheckbox=true;
bool callrclick=false;
bool isrun=false;
bool is_regis_localnoti=false;


// app variable


Map<String, dynamic> page_db = new Map<String, dynamic>();  // flag



Map<String, dynamic> fg = new Map<String, dynamic>();  // flag


Map<String, String> mqtt_key = new Map<String, String>();  // language


Map<String, Map<String, dynamic>> px = new Map<String, Map<String, dynamic>>();  //  page variable
Map<String, dynamic> lg = new Map<String, dynamic>();  // language
Map<String, dynamic> c = new Map<String, dynamic>();  //call intent
Map<String, dynamic> cr = new Map<String, dynamic>();  //callback intent
Map<String, dynamic> i = new Map<String, dynamic>();
Map<String, dynamic> json_appui = new Map<String, dynamic>();
Map<String, dynamic> k_data = new Map<String, dynamic>();
Map<String, dynamic> pvar = new Map<String, dynamic>();
Map<String, dynamic> tmp = new Map<String, dynamic>();
Map<String, dynamic> q = new Map<String, dynamic>();
Map<String, dynamic> pkey = new Map<String, dynamic>();
Map<String, dynamic> pprofile = new Map<String, dynamic>(); //profile
Map<String, dynamic> jh = new Map<String, dynamic>(); //header
Map<String, dynamic> fr = new Map<String, dynamic>(); //focus row


Map<String, PanelController> panel_control = new Map<String, PanelController>();



Map<String, dynamic> plink = new Map<String, dynamic>(); // link
Map<String, dynamic> preturn = new Map<String, dynamic>();
Map<String, dynamic> psend = new Map<String, dynamic>(); // link
Map<String, dynamic> pback = new Map<String, dynamic>(); // link
Map<String, dynamic> send_bind = new Map<String, dynamic>();
Map<String, dynamic> fx = new Map<String, dynamic>();  // form
Map<String, dynamic> form = new Map<String, dynamic>();  // form
Map<String, Map<String, dynamic>> iform = new Map<String, Map<String, dynamic>>();  // form

Map<String, dynamic> papp = new Map<String, dynamic>();  // app
Map<String, dynamic> j = new Map<String, dynamic>();  //f_selectrow
Map<String, dynamic> jd = new Map<String, dynamic>();  //defualt call api row


Map<String, dynamic> t_cmd = new Map<String, dynamic>();
Map<String, dynamic> g = new Map<String, dynamic>();
Map<String, dynamic> cmd = new Map<String, dynamic>();
Map<String, dynamic> rowbind = new Map<String, dynamic>();
Map<String, String> mem = new Map<String, String>();
Map<String, String> x = new Map<String, String>();
Map<String, dynamic> sys = new Map<String, dynamic>(); // link



Map<String, dynamic> row_callback = new Map<String, dynamic>(); // link
Map<String, String> db_regis = new Map<String, String>();
Map<String, dynamic> row_firebase = new Map<String, dynamic>();
Map<String, dynamic> run_one = new Map<String, dynamic>();


Map<String, dynamic> regisui = new Map<String, dynamic>();
Map<String, dynamic> note_tag = new Map<String, dynamic>();  // language
Map<String, dynamic> dr = new Map<String, dynamic>();  // language


bool is_noti=false;
Map<String, Map<String, dynamic>> pui = new Map<String, Map<String, dynamic>>();
Map<String, Map<String, dynamic>> pr = new Map<String, Map<String, dynamic>>();
Map<String, Map<String, dynamic>> list_ui = new Map<String, Map<String, dynamic>>();


Map<String, dynamic> into_grid = new Map<String, dynamic>(); //focus row

String last_cmd="";


Map<String, dynamic> is_regisui = new Map<String, dynamic>();

bool null_take_action=false;


StreamController<String> event_bus = new StreamController.broadcast();

String str_cmd="";
//WebViewController webcontrol;


//final app = GlobalKey<NavigatorState>();
//final GlobalKey<NavigatorState> nav_key = GlobalKey<NavigatorState>();



int logseq=0;
String setscroll="";
String fbpath="";
String device_id="";

bool callapi_endjob=true;
String code_version="13032022";

var g_empty = '''
{
  "type": "Container"
}
''';

List<Widget> btab = [];
List<String> arr,a1,b1,c1;



Map<String, List> xdb = new Map<String, List>();
Map<String, List> db = new Map<String, List>();
Map<String, List> jdb = new Map<String, List>();
//Map<String, Map> f = new Map<String, Map>();  //  form every page
Map<String, dynamic> fval = new Map<String, dynamic>();  //  form every page

int time_waitui_tab=500;
int time_waitui_intent=1000;
int time_init0=100;

int time_wait_intent_callback=250;

//betterPlayerController gplayer=null;



int rclick_delay=100;
String rclick="";
String grid_update="";
String send_callback="";
String nav="";
String b_click="";
String t_click="";
String page_cmd="";

String select_file="";
String qloop_key="";
String scroll_tag="";


List listcmd=[];


List<String> batch_cmd;

//BuildContext g_ctx;
bool iscallcmd=false;
bool requpdate=false;
String send_callapi="";
String jsonx="";
String app_json="";
//String api_json="";
String active_key="";
Map<String, dynamic> gridcmd = new Map<String, dynamic>();
Map<String, dynamic> jdatabase = new Map<String, dynamic>();
String this_skey="";

String datagrid_tag="";



String page_id="";

/*
Map<String, Map<String, dynamic>> info = new Map<String, Map<String, dynamic>>();
Map<String, Map<String, dynamic>> cfg = new Map<String, Map<String, dynamic>>();
Map<String, Map<String, dynamic>> cfg_app = new Map<String, Map<String, dynamic>>();
Map<String, Map<String, dynamic>> app_cfg = new Map<String, Map<String, dynamic>>();
*/
Map<String, dynamic> info_os = new Map<String, dynamic>();
Map<String, dynamic> info = new Map<String, dynamic>();
Map<String, dynamic> info_app = new Map<String, dynamic>();
Map<String, dynamic> cfg = new Map<String, dynamic>();
Map<String, dynamic> cfg_app = new Map<String, dynamic>();



int ikey=1;
String scmd="";
String init0cmd="";
String jsfill="";
String run_cmd="";
String login_id ="";

bool  net_connect =false;

String update_id ="";

bool islogin=false;
bool regis_noti=false;
bool regis_noti2=false;

BuildContext scaffoldContext;
//FirebaseMessaging fbmsg; // = FirebaseMessaging();
final rt_db = FirebaseDatabase.instance.reference();


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();






init(){

  ikey=1;
  db.clear();
  q = new Map<String, dynamic>();
  cmd = new Map<String, dynamic>();
  send_bind = new Map<String, dynamic>();


}
Future<String> read_device_info() async {
  var deviceInfo = DeviceInfoPlugin();

  String uuid="";
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    uuid= iosDeviceInfo.identifierForVendor; // unique ID on iOS
    sys["device_via"]="ios";
    sys["device_model"]=iosDeviceInfo.model;
    sys["device_name"]=iosDeviceInfo.name;
    sys["device_version"]=iosDeviceInfo.systemVersion.toString();


    papp["device_via"]="ios";
    papp["device_model"]=iosDeviceInfo.model;
    papp["device_name"]=iosDeviceInfo.name;
    papp["device_version"]=iosDeviceInfo.systemVersion.toString();


  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    uuid= androidDeviceInfo.androidId; // unique ID on Android

    sys["device_via"]="android";
    sys["device_model"]=androidDeviceInfo.model;
    sys["device_name"]=androidDeviceInfo.display;
    sys["device_version"]=androidDeviceInfo.version.baseOS.toString();


    papp["device_via"]="android";
    papp["device_model"]=androidDeviceInfo.model;
    papp["device_name"]=androidDeviceInfo.display;
    papp["device_version"]=androidDeviceInfo.version.baseOS.toString();

  }

  device_id=uuid;

  papp["device_id"]=uuid;
  sys["device_id"]=uuid;

  print("_________________________");
  print("device_info=${sys}");


  return uuid;
}

Future<void> clear_pref() async {
  try{
    final pref = await SharedPreferences.getInstance();
    await pref.clear();

  }catch(e){}
}

Future<void> clearuser() async {

  try {
    islogin = false;
    login_id = "";
    clear_k();
    papp = new Map<String, dynamic>(); // app
    pprofile = new Map<String, dynamic>(); // app

  }catch(e){}
  await clear_pref();


}

hide_keyboard(){
  FocusManager.instance.primaryFocus.unfocus();

}
bool idmath(String a,String b){
  return (a.split(".").last.toLowerCase()==b.split(".").last.toLowerCase());
}
void addeventbus(String skey,String sevent){

  try{
    if(!event_bus.isClosed){
      event_bus.add(sevent);
    }}catch(e){}
}

String getvid(String s){
  return s.split(".").last;
}
String decode_url(String s){
  s=s.replaceAll("%2C",",");
  s=s.replaceAll("%3D","=");
  s=s.replaceAll("(eq)","=");
  s=s.replaceAll("%3B",";");
  return s;
}
String encode_url(String s){
  s=s.replaceAll(",", "%2C");
  s=s.replaceAll("=", "%3D");
  s=s.replaceAll(";", "%3B");
  return s;
}
click_cmd( Map<String, dynamic> m){
  try{
    if(m.containsKey("b_click")){
      b_click=null2str(m["b_click"]);
    }
    if(m.containsKey("click2cmd")){
      run_cmd=null2str(m["click2cmd"]);
    }
  }catch(e){
  }
}
void close_app(){
  try{

    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }

  }catch(e){}
}

void saveiform(String uiId,String sval){
  try {
    if (!iform.containsKey(active_key)) {
      iform[active_key] = new Map<String, dynamic>();
    }
    if (uiId.contains(".")) {
      uiId = uiId.split(".")[1];
    }
    iform[active_key][uiId] = sval;
  }catch(e){}
}
double get_width(double d){
  if(d==-0.1){
    d=double.infinity;
  }
  else if(d==-0.2){
    d=double.maxFinite;
  }else if(d<0){
    d=MediaQuery.of(ctx()).size.width+d;
  }
  return d;
}
double get_height(double d){
  if(d==-0.1){
    d=double.infinity;
  }
  else if(d==-0.2){
    d=double.maxFinite;
  }else if(d<0){
    d=MediaQuery.of(ctx()).size.height+d;
  }
  return d;
}

Future<String> save2photofile(Uint8List vbytes) async {

  String dir = (await getApplicationDocumentsDirectory()).path;
  String fullPath = dir+gen_file()+".png";
  File file = File(fullPath);
  await file.writeAsBytes(vbytes);
  return file.path;

}


bool isfoundfield(String id){
  if(id.contains(".")){
    id=id.split(".")[1];
  }
  if(iform.containsKey(active_key)){
    return iform[active_key].containsKey(id);
  }
  return false;
}
String getdatafield(String id){
  if(id.contains(".")){
    id=id.split(".")[1];
  }
  if(iform.containsKey(active_key)){
    return null2str(iform[active_key][id]);
  }
  return "";
}


getkeyboardtype(String skeyboard){

  switch(skeyboard){
    case "multiline":
      return TextInputType.multiline;
      break;
    case "datetime":
      return TextInputType.datetime;
      break;
    case "emailAddress":
      return TextInputType.emailAddress;
      break;
    case "name":
      return TextInputType.name;
      break;
    case "number":
      return TextInputType.number;
      break;
    case "phone":
      return TextInputType.phone;
      break;
    case "streetAddress":
      return TextInputType.streetAddress;
      break;
    case "text":
      return TextInputType.text;
      break;
    case "url":
      return TextInputType.url;
      break;
    case "values":
      return TextInputType.values;
      break;
    case "visiblePassword":
      return TextInputType.visiblePassword;
      break;
    case "values":
      return TextInputType.values;
      break;
    default:
      return TextInputType.text;
      break;
  }
}



void savevfield(String fieldName,String sval){
  try {
    var x = iform[active_key];
    if (x == null) {
      x = newmap();
    }
    /*if(field_name.contains(".")){
      field_name=field_name.split(".")[1];
    }*/
    x[fieldName] = sval;
    iform[active_key] = x;
  }catch(e){}
}
bool isdebug(){
  return (cmdval("_setdebug")=="true")||(cmdval("setdebug")=="true");
}

String getvfield(String fieldName){
  try {
    var x = form[active_key];
    if (x == null) {
      x = newmap();
    }
    return null2str(x[fieldName]);
  }catch(e){}
  return "";

}


inc_val(int ic,int istep){
  return ic+istep;
}

double iscreen(double i){
  if(i==-1.0){
    return double.infinity;
  }
  if(i==-1.1){
    return double.infinity;
  }
  return i;
}
double get_mobilesize(double i){
  if(i==-1.0){
    return MediaQuery.of(ctx()).size.width;
  }
  if(i==-2.0){
    return MediaQuery.of(ctx()).size.height;
  }

  return i;
}




bool str_in2(String scheck,String sall){
  scheck=","+scheck+",";
  sall=","+sall+",";

  return sall.toLowerCase().contains(scheck.toLowerCase());

}

bool str_in(String strsrc,String strcheck){
  bool r=false;
  List<String> a=strcheck.split(",");
  a.forEach((s1) {
    if(strsrc.toLowerCase()==s1.toString()){
      r=true;
      return r;
    }
  });
  return r;
}


void setting_appid(dynamic jx,String appid){
  json_appui[appid]=jx;
  active_appid=appid;
}

String readconfig(String k){
  try {
    return null2str(cfg[k]);
  }catch(e){
  }
  return "";
}
String cstr(String s,String def){
    if(s!="" && s!= null){
    return s;
  }
  return def;
}


clear_gdb(String k){
  try{
    if(db != null){
      if (db.containsKey(k)) {
        db[k].clear();
      }
    }
  }catch(e){}
}
String readselect(String s,String skey){
  if(skey==""){
    skey=active_key;
  }
  String r="";
  selectx(s, skey);
  q.forEach((key, value) {
    r=value;
  });
  return r;
}

app_setting(String stag){

  switch(stag){
    case "noti":
      SystemSettings.appNotifications();
      break;
    case "setting":
      SystemSettings.system();
      break;
    case "location":
      SystemSettings.location();
      break;
    case "wifi":
      SystemSettings.wifi();
      break;
    case "bluetooth":
      SystemSettings.bluetooth();
      break;
    case "nfc":
    // SystemSettings.nf
      break;

    case "poweroption":
    // SystemSettings.po
      break;

    case "security":
      SystemSettings.security();
      break;
    case "display":
      SystemSettings.display();
      break;
    case "date":
      SystemSettings.date();
      break;
    case "sound":
      SystemSettings.sound();
      break;
    case "app":
      SystemSettings.apps();
      break;

    case "network":
      SystemSettings.wireless();
      break;

    case "info":
      SystemSettings.deviceInfo();
      break;
    case "dataused":
      SystemSettings.dataUsage();
      break;
    case "dataroaming":
      SystemSettings.dataRoaming();
      break;
    case "Locale":
      SystemSettings.locale();
      break;
    case "defaultapp":
      SystemSettings.defaultApps();
      break;

    case "airplanemode":
      SystemSettings.airplaneMode();
      break;
    case "privacy":
      SystemSettings.privacy();
      break;
    case "accessibility":
      SystemSettings.accessibility();
      break;
    case "internalstorage":
      SystemSettings.internalStorage();
      break;
    case "notificationpolicy":
      SystemSettings.notificationPolicy();
      break;
    default:
      SystemSettings.app();
      break;
  }
}

String getos(){
  return Platform.operatingSystem.toLowerCase(); //in your code
}

Future<void>getdevice_info() async{
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      sys["device_os"]="android";

      var build = await deviceInfoPlugin.androidInfo;
      sys["device_name"]=build.model;
      sys["device_version"]=build.version.release;
      sys["osv"]=build.version.release;
      sys["device_id"]=build.androidId;


    } else if (Platform.isIOS) {
      sys["device_os"]="ios";

      var data = await deviceInfoPlugin.iosInfo;
      sys["device_name"]=data.name;
      sys["device_version"]= data.systemVersion;
      sys["osv"]= data.systemVersion;
      sys["device_id"]=data.identifierForVendor;;

    }
  } on PlatformException {
    print('Failed to get platform version');
  }

}


// getvdofile(videoPathUrl) async {
//   var appDocDir = await getApplicationDocumentsDirectory();
//   final folderPath = appDocDir.path;
//   String thumb = await Thumbnails.getThumbnail(
//       thumbnailFolder: folderPath,
//       videoFile: videoPathUrl,
//       imageType: ThumbFormat.PNG,//this image will store in created folderpath
//       quality: 30);
//   print(thumb);
//   return thumb;
// }

//

getvdoimg(videoPathUrl) async {
/*
  var appDocDir = await getApplicationDocumentsDirectory();
  final folderPath = appDocDir.path;
  String thumb = await Thumbnails.getThumbnail(
      thumbnailFolder: folderPath,
      videoFile: videoPathUrl,
      imageType: ThumbFormat.JPEG,//this image will store in created folderpath
      quality: 30);
  print("vdoimg="+thumb);
  return thumb;*/
//checkcode
return  "";

}


getvdofile(String fileUrl) async {
/*
  String fileName = await VideoThumbnail.thumbnailFile(
    video: file_url,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.WEBP,
    maxHeight: 64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
    quality: 75,
  );


  return fileName;*/

  return "";


}




String getparameter_fromstring(String s){
  String x="";

  try {

    bool isstart=false;
    String v="";
    List a=s.split('');
    a.forEach((s) {

      if(isstart){
        if(s=="}"){
          isstart=false;
          x+=v+",";
          v="";
        }else {
          v+=s;
        }
      }
      if(s=="{"){
        isstart=true;
      }
    });

  }catch(e){
    print("getpr.error."+e.toString());
  }
  print("getpr___________:"+x);
  return x;

}

regiskey(String skey){

  if(skey==null || skey==""){return;}
  if(pui[skey]==null){
    pui[skey]= newmap();
  }

}

newmap(){
  return new Map<String, dynamic>();
}


String getrunseq(){
  logseq+=1;
  return logseq.toString();
}
String wedget_text='''
"type": "RaisedButton",
      "click_event" : "&_callfx=gridview_adddata",
      "child" : {
        "type": "Text",
        "data": "Widget"
      }
''';

String strsjs="";

Map<String, dynamic> json_ui;
Map<String, dynamic> json_ui_src;
//dynamic file_uix;
String appui="";
String appui_org="";


String xxx="";
bool ispush=false;
bool iscomfirm=false;
bool isloadprofile=false;
int ui_id=0;
String lastval="";
String k="";
String url_api="";
String bkcolor="";
int calldelay=0;
int nav_time=0;
int call_navtime=-1;
bool isrunfirsttime=false;

String player_url="";

bool cbool(Object s){
  s=null2str(s);
  if(s=="0" || s=="" || s==false||s=="false"||s==null){
    return false;
  }
  return true;
}
bool cboolx(Object s,bool  ret){
  s=null2str(s);
  if(s=="0" || s=="" || s==false||s=="false"||s==null){
    return false;
  }
  return ret;
}
int getnavtime(){
  if (call_navtime==-1) {
    return nav_time;
  }
  return nav_time;
}
bool isnumber(String s){
  return (double.tryParse(s) != null);
}
String timeago(DateTime input){
  try {
    Duration diff = DateTime.now().difference(input);
    if (diff.inDays >= 1) {
      return '${diff.inDays} day(s) ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour(s) ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }catch(e){

  }
  return "";
}

Future<String> f_concat(String s) async {
  String gval = "";
  try {
    List<String> a = s.split(",");
    try {
      if (a.length >= 3) {
        String aval = a[1];
        String bval = a[2];

        if (cint(aval, 0) <= cint(bval, 0)) {
          gval = aval + "x" + bval;
        } else {
          gval = bval + "x" + aval;
        }
      }
    } catch (e) {}
    plink[a[0]]=gval;
  }catch(e){}
  return gval;
}

http_get(String url) async {

  // var rx= await Dio().get(url);
  //
  // log("j${rx.data}");
  // return  rx.data;


  return  await http.post(
    Uri.parse(url),
    headers:  {
      "Authorization":"apikey",
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    },
    encoding: Encoding.getByName('utf-8'),
  );

  /*return http.get(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Charset': 'utf-8'
      });

  await http.post(
    uri,
    headers: headers,
    encoding: encoding,
  );*/

}


Future<void> send_noti_touser(String stoken,stitle,sdetail,simage,refid) async {

  //tmsg("send_noti_to_user ${stoken}");
  String firebaseMsgkey=null2str(info["firebase_msgkey"]);

  try{
    await http.post(

      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=$firebaseMsgkey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': stitle,
            'body':sdetail,
            'image':simage,
            'badge':1,
            "refid" : refid,
            "sound" : "default"
          },
          // 'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'refid':refid,
            'title': stitle,
            'body':sdetail,
          },
          'to': stoken,
        },
      ),
    );
  } catch (e) {
    print(e);
  }
}



bool is_json(String s){
  try {
    var decodedJSON = json.decode(s);
    return true;
  } on FormatException catch (e) {
  }
  return false;
}
read_info(String name){
  if(info==null){
    return "";
  }
  return null2str(info[name]);
}
read_cfg(String name){
  if(cfg_app==null){
    return "";
  }
  return null2str(cfg_app[name]);
}
save_config(){

  try{
    info_app=info;
    cfg_app=cfg;
  }catch(e){}

}

readappconfig_fromdb() async {
  //if(info==null){
  try {
    var prefs = await SharedPreferences.getInstance();
    var keys = prefs.getKeys();
    var prefsMap = Map<String, dynamic>();

    for (String key in keys) {
      pkey[key] = prefs.get(key).toString();
      sys[key] = prefs.get(key).toString();
    }

    print("pref=${pkey}");
    try {
      info = jsonDecode(pkey["info"]);
      cfg = jsonDecode(pkey["cfg"]);


      info_os = jsonDecode(pkey["info_os"]);
      info_os.forEach((key, value) {
        info[key]=value;
      });

      info_app=info;
      cfg_app=cfg;


    } catch (e) {}
    //}

  }catch(e){}
}
readappconfig_fromjson(){

  String gval="";
  String info_apptext="";
  try{


    gval=read_json(json_ui, "info");
    info = jsonDecode(read_json(json_ui, "info"));


    try{
      if (Platform.isAndroid) {
        info_apptext=read_json(json_ui, "info_android");
        info_os = jsonDecode(info_apptext);
        info_os.forEach((key, value) {
          info[key]=value;
        });
      } else if (Platform.isIOS) {
        info_apptext=read_json(json_ui, "info_ios");
        info_os = jsonDecode(info_apptext);
        info_os.forEach((key, value) {
          info[key]=value;
        });
      }
    }catch(e){
      print_log("read app_config.error check info_android info_ios.${e}");
    };


    savekey("info",gval);
    savekey("info_os",info_apptext);

    save_textfile("info", gval);
    save_textfile("info_os", info_apptext);


    google_api_key=null2str(info["google_api_key"]);





  }catch(e){}



  try{
    gval=read_json(json_ui, "cfg");
    cfg = jsonDecode(gval);

    // save config
    savekey("cfg",gval);

    Map<String, dynamic> hcfg = new Map<String, dynamic>();
    hcfg=cfg as Map<String, dynamic>;
    hcfg.forEach((skey, sval) {
      savekey(skey, sval);
    });

    save_textfile("cfg", gval);


  }catch(e){}

  try {


    app_name = read_info("app_name");
    url_api = read_info("url_api");

if( null2str(info["app_setting"])!=""){
     savedata("", read_info("app_setting"));
  }

    if( null2str(info["main_color"]) != ""){
      main_color=read_info("main_color");
    }
    if( null2str(info["theme_color"]) != ""){
      main_color=read_info("theme_color");
    }


    time_waitui_tab = null2int(info["time_waitui"],200);
    time_waitui_intent = null2int(info["time_waituipage"],200);


    String vnavTime =  null2str(info["nav_time"]);
    if(vnavTime !=""){
      nav_time=cint(vnavTime,nav_time);
    }

/*
    if(null2str(info["ui_path"])!=""){
      savekey("ui_path",null2str(info["ui_path"]));
    }*/


    if (Platform.isAndroid) {
      sys["device_os"]="android";
      pkey["device_os"]="android";
      papp["device_os"]="android";


    } else if (Platform.isIOS) {
      sys["device_os"]="ios";
      pkey["device_os"]="android";
      papp["device_os"]="android";

    }



  }catch(e){
  }



  print_log("x_device:${read_info("x_device")}");

}


Future<Directory> get_dir_download() async {
  if (Platform.isAndroid) {
   // return await DownloadsPathProvider.downloadsDirectory;
  }
  return await getApplicationDocumentsDirectory();
}

show_noti(String stext){
  BotToast.showSimpleNotification(title:stext);
}
clear_all_noti(){
  BotToast.cleanAll();
}
show_loadding(bool isshow){
  if(isshow){
    BotToast.showLoading(
        clickClose: false,
        allowClick: false,
        crossPage: false,
        animationDuration:
        Duration(milliseconds: 100),
        animationReverseDuration:
        Duration(milliseconds: 100),
        duration: Duration(
          seconds:500,
        ));
  }else {
    BotToast.closeAllLoading();
  }
}

Future<Directory> get_dir_doc() async {
  return await getApplicationDocumentsDirectory();
}

Future<File> moveFile(File sourceFile, String newPath) async {
  try {
    // prefer using rename as it is probably faster
    return await sourceFile.rename(newPath);
  } on FileSystemException catch (e) {
    // if rename fails, copy the source file and then delete it
    final newFile = await sourceFile.copy(newPath);
    await sourceFile.delete();
    return newFile;
  }
}

update_app_stream(){
  app_stream.add("update");
}
String gen_file(){
  var now = new DateTime.now();
  var formatter = new DateFormat('ddMMyyyy_hh_mm_ss');
  return formatter.format(now);

}

String defstr(String s,String defstr){
  if(s==""){
    return defstr;
  }
  return s;
}
String newkey(){
  return UniqueKey().toString();
}
String get_extname(String fileName) {
  return "." + fileName.split('.').last;
}
String get_datetime_id(){
  return new DateTime.now().millisecondsSinceEpoch.toString();
}

Key getnewkey(){
  return UniqueKey();
}
String fixstrval(String s){
  return s.replaceAll(" ","_").toLowerCase();
}


Future<String> downloadImage(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future<Null> local_noti(String sTitle,String sDetail,String stag,String imgTitle) async {

  await regis_localnoti();

  try {


    iservice+=1;
    String  notiType=cmdval("noti_type");


    String imgTitle="https://s.isanook.com/hi/0/rp/r/w728/ya0xa0m1w0/aHR0cHM6Ly9zLmlzYW5vb2suY29tL2hpLzAvdWQvMzA5LzE1NDk0NDkvc2Ftc3VuZy5qcGc=.jpg";
    String imgDetail="https://s.isanook.com/hi/0/rp/r/w728/ya0xa0m1w0/aHR0cHM6Ly9zLmlzYW5vb2suY29tL2hpLzAvdWQvMzA5LzE1NDk0NDkvMTU0OTQ0OS0yMDIyMDExMzEyMDAxMy01MzgxNmNhLmpwZw==.jpg";




    if(notiType==""){

      var androidPlatformChannelSpecifics = AndroidNotificationDetails("${iservice}",
          'FLUTTER_NOTIFICATION_CHANNEL', 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
          importance: Importance.max, priority: Priority.high);
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();

      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(iservice, sTitle,
          sDetail, platformChannelSpecifics,
          payload: 'payload');
    }else if(notiType=="img"){

      final String largeIconPath = await downloadImage(
          imgTitle, 'largeIcon');
      final String bigPicturePath = await downloadImage(
          imgDetail, 'bigPicture');
      final BigPictureStyleInformation bigPictureStyleInformation =
      BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
          largeIcon: FilePathAndroidBitmap(largeIconPath),
          contentTitle: sTitle,
          htmlFormatContentTitle: true,
          summaryText: sDetail,
          htmlFormatSummaryText: true);
      final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails("${iservice}",
          'FLUTTER_NOTIFICATION_CHANNEL',
          'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
          styleInformation: bigPictureStyleInformation);
      final NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          iservice, sTitle, sDetail, platformChannelSpecifics);
    }


    print("local_noti_success");
  }catch(e){
    tmsg("localnoti_error."+e.toString());
  }



}



regis_localnoti() async {




  if(!is_regis_localnoti){

    var initializationSettingsAndroid =
    AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
          print("onDidReceiveLocalNotification called.");
        });
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
          // when user tap on notification.
          print("onSelectNotification called.");

        });




    is_regis_localnoti=true;
  }

}




bool havekey(Map<String, dynamic> h,String strKey){
  if(h==null){
    return false;
  }
  return h.containsKey(strKey);
}

bool ischeckid(String skey,String wdId,String strChek){
  return (wdId==strChek||wdId==skey+"."+strChek);
}

void initFirebaseMessagingx() {



  //
  // firebaseMessaging.configure(
  //     onBackgroundMessage: backgroundMessageHandler,
  //     onMessage: (Map<String, dynamic> message) async {
  //       is_noti=true;
  //       try  {
  //
  //         print("onMessage v1: $message");
  //         Map mapNotification = message["notification"];
  //         String title = mapNotification["title"];
  //         String body = mapNotification["body"];
  //         local_noti(title,body);
  //
  //       }catch(e){}
  //
  //
  //
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //     }
  // );
  //
  //
  //
  //
  //
  //
  // firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(sound: true, badge: true, alert: true));
  // firebaseMessaging.onIosSettingsRegistered
  //     .listen((IosNotificationSettings settings) {
  //   print("Settings registered: $settings");
  // });
  //
  // firebaseMessaging.getToken().then((String token) {
  //   assert(token != null);
  //   print("firebase_token : $token");
  //   sys["firebase_token"]=token;
  // });
  //




}


Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print('on background $message');
}



void initFirebaseMessagingxx() {

  //
  //
  // firebaseMessaging.configure(
  //   onMessage: (Map<String, dynamic> message) async {
  //     print("onMessage: $message");
  //   },
  //   onLaunch: (Map<String, dynamic> message) async {
  //     print("onLaunch: $message");
  //   },
  //   onResume: (Map<String, dynamic> message) async {
  //     print("onResume: $message");
  //   },
  // );
  //
  // firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(sound: true, badge: true, alert: true));
  // firebaseMessaging.onIosSettingsRegistered
  //     .listen((IosNotificationSettings settings) {
  //   print("Settings registered: $settings");
  // });
  //
  // firebaseMessaging.getToken().then((String token) {
  //   assert(token != null);
  //   print("Token : $token");
  // });
  //


}

//
// Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
//
//   if (message['data'] != null) {
//     final data = message['data'];
//
//     final title = data['title'];
//     final body = data['message'];
//
//     await _showNotificationWithDefaultSound(title, message);
//   }
//   return Future<void>.value();
// }

Future<void>  run_firsttime() async {
  try {

    await flutterLocalNotificationsPlugin.cancelAll();
    if (!isrunfirsttime) {
      isrunfirsttime = true;
    }
  }catch(e){}

  if(tab_ui==""){
    tab_ui=read_json(json_ui,"tab");
  }


}
run_one_time(BuildContext ctx) async {
  /*try {
    cameras = await availableCameras();
  }catch(e){}*/


  read_screen(ctx);
  read_device_info();



  /* a_player = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.code2exit.preloved.channel.audio',
      androidNotificationChannelName: 'Music playback',
    ),
  );*/

  //tmsg("a_player config");



}
Future<Null> f_share_screen() async {

  try {
    RenderRepaintBoundary boundary =
    ctx().findRenderObject();
    if (boundary.debugNeedsPaint) {
      Timer(Duration(seconds: 1), () => f_share_screen());
      return null;
    }
    ui.Image image = await boundary.toImage();
    final directory = (await getExternalStorageDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    File imgFile = new File('$directory/${gen_file()}.png');
    imgFile.writeAsBytes(pngBytes);
    final RenderBox box = ctx().findRenderObject();

    await  Share.shareFiles(['${imgFile.path}'],subject: 'Share ScreenShot', text: 'Share ScreenShot');

    /* Share.shareFiles(paths)

        .shareFile(File('$directory/screenshot.png'),
        subject: 'Share ScreenShot',
        text: 'Hello, check your share files!',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
    );*/
  } on PlatformException catch (e) {
    print("Exception while taking screenshot:" + e.toString());
  }

}
void read_screen(BuildContext ctx){
  try{

    screen_w= MediaQuery.of(ctx).size.width;
    screen_h =  MediaQuery.of(ctx).size.height;

  }catch(e){}
}



int getdelaycall(){
  return calldelay;
}
String createid(){
  ui_id+=1;
  return "c_"+ui_id.toString();
}
String geturl(String url){
  return url.replaceAll("{login_id}", login_id)
      .replaceAll("{device_id}", null2str(sys["device_id"]))
      .replaceAll("{device_os}", null2str(sys["device_os"]));
}



void set_gridcmd(String id,String cmd){
  gridcmd[id]=cmd;
}

String getlayout(String k){
  if( json_ui[k]==null){
    return "";
  }
  return json_ui[k].toString();
}

String read_jsonk(dynamic oj,String str){
  List<String> a=str.split(",");
  a.forEach((k) {
    if( oj[k]!=null){
      print("json_ui_check_true:${oj[k]}");
      return oj[k].toString();
    }
  });
  return "";
}
String read_json(dynamic oj,String k){
  try {
    if (oj[k] == null) {
      return "";
    }
    return oj[k].toString();
  }catch(e){
    return "";
  }
}

null2int(Object oj,int def){
  if(oj==null||oj==""){
    return def;
  }
  try {

    return int.parse(oj.toString());
  }catch(e){
  }
  return  def;
}
null2dbl(Object oj,double def){
  if(oj==null||oj==""){
    return def;
  }
  try {
    return double.parse(oj.toString());
  }catch(e){
  }
  return  def;
}


// getImage(videoPathUrl) async {
//   var appDocDir = await getApplicationDocumentsDirectory();
//   final folderPath = appDocDir.path;
//   String thumb = await Thumbnails.getThumbnail(
//       thumbnailFolder: folderPath,
//       videoFile: videoPathUrl,
//       imageType: ThumbFormat.PNG,//this image will store in created folderpath
//       quality: 30);
//   print(thumb);
//   return thumb;
// }


null2num(Object oj,double def){
  try {
    if (oj != null) {
      return double.parse(oj.toString());
    }
  }catch(e){
  }
  return  def;
}

List<String> getlinkfromstring(String s){


  final urlRegExp = new RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
  final urlMatches = urlRegExp.allMatches(s);
  List<String> l = urlMatches.map(
          (urlMatch) => s.substring(urlMatch.start, urlMatch.end))
      .toList();
  if(l.length>0){
    s=l[0];
  }
  return l;
}
void logx(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String null2str(Object oj){
  try {
    if(oj == null){
      return "";
    }
    return oj.toString();
  }catch(e){}
  return "";

}
null2str2(Object oj,String defstr){
  String r="";
  try {
    if(oj == null){
      r ="";
    }
    r= oj.toString();
  }catch(e){}
  if(r==""){
    r=defstr;
  }
  return r;
}

String list2str(List l){
  String s="";
  l.forEach((s1) {
    s+=s1+",";
  });
  s=rcut(s);
  return s;
}

readlogin(){

  if(login_id==""){
    login_id=null2str(pkey["login_id"]);
  }
  if(login_id==""){
    login_id=null2str(pprofile["login_id"]);
  }


}
String strx(String a,String b){
  if(a==null||a==""){
    return b;
  }
  return a;
}

Color getcolor2(String strcolor,String defcolor) {
  if(null2str(strcolor)==""){
    strcolor=defcolor;
  }
  return getcolor(strcolor);
}

Color getcolor(String hexColorString) {
  if (hexColorString == null) {
    return null;
  }
  hexColorString = hexColorString.toUpperCase().replaceAll("#", "");
  if (hexColorString.length == 8) {
    hexColorString =  hexColorString;
  }else if (hexColorString.length == 6) {
    hexColorString = "FF" + hexColorString;
  }
  int colorInt = int.parse(hexColorString, radix: 16);
  return Color(colorInt);
}


String MapToJson(List<Map<String, dynamic>> map) {
  String res = "[";

  for (var s in map) {
    res += "{";

    for (String k in s.keys) {
      res += '"';
      res += k;
      res += '":"';
      res += s[k].toString();
      res += '",';
    }
    res = res.substring(0, res.length - 1);

    res += "},";
    res = res.substring(0, res.length - 1);
  }

  res += "]";

  return res;
}
String hashmap2json(dynamic d){
  return jsonEncode(d).toString();
}

Map<String, dynamic>  json2hashmap(String str_json){
return jsonDecode(str_json) as  Map<String, dynamic>;
}


bool str_contrain(String scheck,String sall){
  bool isfound=false;
  List<String> a=sall.split(",");
  a.forEach((s) {
    print("check:"+s+":"+scheck);
    if(scheck.contains(s)){
      isfound=true;
      return isfound;
    }
  });
  return  isfound;
}
bool strin(String scheck,String sall){
  bool isfound=false;
  List<String> a=sall.split(",");
  a.forEach((s) {
    print("check:"+s+":"+scheck);
    if(s==scheck){
      print("math:::::::::::::::::::");
      isfound=true;
      return isfound;
    }
  });
  return  isfound;
}

String getival(String s){
  List<String> a=s.split(".");
  if(i.containsKey(a[1])){
    return null2str(i[a[1]][a[2]]);
  }
  return "";
}

double calculateDistance(lat1, lon1, lat2, lon2){
  var p = 0.017453292519943295;
  var a = 0.5 - cos((lat2 - lat1) * p)/2 +
      cos(lat1 * p) * cos(lat2 * p) *
          (1 - cos((lon2 - lon1) * p))/2;
  return 12742 * asin(sqrt(a));
}
String google_apikey(){
  return google_api_key;
}
String google_apikey_ios(){
  return google_api_key;
}
String getuitag(Map<String, dynamic> m){
  if(m.containsKey("ui")){
    return m["ui"].toString();
  }
  if(m.containsKey("uitag")){
    return m["uitag"].toString();
  }
  return "";
}

add_event(String e){
  try{
    ev.add(e);
  }catch(e){}
}

String hval(Map<String, dynamic> h,s){
  return null2str(h[s]);
}
String cmdval(s){
  return null2str(cmd[s]);
}
// String fillstr(String s,){
//   return s.replaceAll("{@k}",skey);
// }

String getk(String s){
  return s.replaceAll("[<'", "").replaceAll("'>]", "");
}

Map<String, dynamic> str2hash(String s){
  // a[add,b[bb,c[cc
  Map<String, dynamic> h = new Map<String, dynamic>();
  List<String> a= s.split(",");
  List<String> b;
  a.forEach((s1) {
    b=s1.split("[");
    if(b.length>=2){
      h[b[0]]=b[1];
    }
  });
  return h;
}

readcmdvar(String s){
  Map<String, dynamic> vcmd = new Map<String, dynamic>();
  var a = s.split(";");
  var b;
  for( String s in a) {
    if (s != "") {
      b = s.split("=");
      vcmd[b[0]]=b[1];
    }
  }
  return vcmd;
}
String readcmd(String s){
  cmd = new Map<String, dynamic>();
  var a = s.split(";");
  var b;
  for( String s in a) {
    if (s != "") {
      b = s.split("=");
      cmd[b[0]]=b[1];
    }
  }
}
Map<String, dynamic> read_cmd(String s){
  Map<String, dynamic> cmd = new Map<String, dynamic>();
  var a = s.split(";");
  var b;
  for( String s in a) {
    if (s != "") {
      b = s.split("=");
      cmd[b[0]]=b[1];
    }
  }
  return cmd;
}
double cdblx(Object s){
  try {
    return double.parse(s.toString());
  }catch(e){}
  return 0;
}
double cdbl(Object s,double def){
  try {
    return double.parse(s.toString());
  }catch(e){}
  return def;
}
int str2int(String s){
  try {
    return int.parse(s);
  }catch(e){}
  return 0;
}
int cintx(s){
  try {
    return int.parse(s.toString());
  }catch(e){}
  return 0;
}
int cint(Object s,int def){
  try {
    return int.parse(s.toString());
  }catch(e){}
  return def;
}
String getuuid(){
  return Uuid().v4();
}
String create_uuid(){
  return Uuid().v4();
}
String genkey(){
  ikey+=1;
  return  ikey.toString();
}


removekey(String k) async {
  try{
    if(pkey.containsKey(k)){
      pkey.remove(k);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(k);

  }catch(e){
    tmsg("save key.error."+e.toString());
  }
}



readkey_now(String k) async {
  String r="";
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(k).toString();
  }catch(e){}
  return r;
}

savekey(String k,dynamic v) async {
  if(v!=null){
    try{
      pkey[k]=v;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("${k}", "${v}");

    }catch(e){
      tmsg("save key.error."+e.toString());
    }
  }
}

int getvalue_index(String s,List<String> l){
  for(int i=0; i< l.length; i++){
    if(s.toLowerCase()==l[i].toLowerCase()){
      return i;
    }
  }
  return 0;
}
Future<void> read_config() async {

  try {


    await read_device_info();

    if (Platform.isAndroid) {
      sys["device_os"]="android";
      pkey["device_os"]="android";
      papp["device_os"]="android";



    } else if (Platform.isIOS) {
      sys["device_os"]="ios";
      pkey["device_os"]="android";
      papp["device_os"]="android";

    }


    var prefs = await SharedPreferences.getInstance();
    var keys = prefs.getKeys();
    var prefsMap = Map<String, dynamic>();

    for (String key in keys) {
      pkey[key] = prefs.get(key).toString();
      sys[key] = prefs.get(key).toString();
    }


    print("pref_"+pkey.toString());
    login_id = null2str(pkey["login_id"]);

    if(login_id!=""){
      pprofile["login_id"]=login_id;
      pprofile["islogin"]="true";
    }

    if(pkey.containsKey("appid")){
      if(null2str(pkey["appid"])!=""){
        main_appid = null2str(pkey["appid"]);
        print("req___________________"+main_appid);
      }
    }

    // restore
    if(pkey.containsKey("this_pf")){
      try {
        pprofile = json.decode(pkey["this_pf"].toString());
        pkey.remove("this_pf");
      }catch(e){
        print("this_pf.error."+e.toString());
      }
    }

    if(pkey.containsKey("this_var")){
      pvar=json.decode(pkey["this_var"]);
      pkey.remove("this_var");
    }
    if(pkey.containsKey("this_app")){
      papp=json.decode(pkey["this_app"]);
      pkey.remove("this_app");
    }

  }catch(e){}


}

clear_k() async {
  try {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    pkey.clear();

  }catch(e){}
}
String readkey(k)  {
  try {

    if(pkey.containsKey(k)){
      return pkey[k].toString();
    }
  }catch(e){}
  return "";
}



String getfval(String skey,String s){

  s=s.replaceAll("{new_key}", newkey());
  String a = getparameter_fromstring(s);
  if (a != "") {

    try {
      selectx(a, skey);
      print("getfval=${q}");
    } catch (e) {}

    if (isdebug()) {
      //alert("runcmd.selectx:"+g.q.toString());
    }

    List<String> l = a.split(",");
    List<String> b;
    String x = "";
    l.forEach((s1) {
      b = s1.split(".");
      s = s.replaceAll(
          "{" + s1 + "}", null2str(q[b[b.length - 1]]));
      print("set $b[0]->$b[1] ");
    });
  }
  return s;
}
String getfval2(String skey,String s){
  if(skey==""){
    skey=active_key;
  }
  String a = getparameter_fromstring(s);
  if (a != "") {

    try {
      selectx(a, skey);
    } catch (e) {}


    List<String> l = a.split(",");
    List<String> b;
    String x = "";
    l.forEach((s1) {
      b = s1.split(".");
      s = s.replaceAll(
          "{" + s1 + "}", null2str(q[b[b.length - 1]]));
      print("read_ $b[0]->$b[1] ");
    });
  }
  return s;
}


close_page(String skey) {
  try{




    if(list_ui.containsKey(skey)){
      list_ui.remove(skey);
    }
    if(iform.containsKey(skey)){
      iform.remove(skey);
    }

    if(iform.containsKey(skey)){
      iform.remove(skey);
    }

    if(px.containsKey(skey)){
      px.remove(skey);
    }
    if(panel_control.containsKey(skey)){
      panel_control.remove(skey);
    }
    if(is_regisui.containsKey(skey)){
      is_regisui.remove(skey);
    }

    if(page_db.containsKey(skey+"_json")){
      page_db.remove(skey+"_json");
    }

    List<String> arr= db_regis[skey].toString().split(",");
    arr.forEach((s) {
      if(s!=""){
        if(db.containsKey(s)){
          db.remove(s);
        }
      }
    });
    if(form.containsKey(skey)){
      form.remove(skey);
    }


  }catch(e){}

}

f_read_gps_info() async {
  await Geolocator.isLocationServiceEnabled().then((enabled){
    if(enabled){
      pvar["gps_enable"]="true";
      return true;
    }else{
      pvar["gps_enable"]="false";
      return false;
    }
  });
}



Map<String, dynamic>readlinepr(String sval){
  Map<String, dynamic> r = new Map<String, dynamic>();
  arr=sval.split(",");
  arr.forEach((s1) {
    a1=s1.split("[");
    r[a1[0]]=a1[1];
  });
  return r;
}



save_var(String vname,String key,String value) {
  try{
    switch(vname){
      case "pf":
        pprofile[key]=value;
        break;
      case "l":
        plink[key]=value;
        break;
      case "lg":
        lg[key]=value;
        break;
      case "a":
        papp[key]=value;
        break;
      case "v":
        pvar[key]=value;
        break;
      case "h":
        jh[key]=value;
        break;
      case "c":
        c[key]=value;
        try{
          if(px.containsKey(this_skey)){
            px[this_skey][key]=c;
          }}catch(e){}
        break;
      case "k":
        savekey(key,value);
        break;
      case "f":
        saveiform(key, value);
        update_field(this_skey,key, value);
        break;
    }
  }catch(e){}

}
savedata2(String s,Map<String, dynamic> h) {
  List<String> sall=s.split(",");
  sall.forEach((s) {
    h.forEach((key, value) {
      switch(s){
        case "pf":
          pprofile[key]=value;
          if(key=="login_id"){
            saveprofile(h);
          }
          break;
        case "l":
          plink[key]=value;
          break;
        case "lg":
          lg[key]=value;
          break;
        case "a":
          papp[key]=value;
          break;
        case "v":
          pvar[key]=value;
          break;
        case "h":
          jh[key]=value;
          break;
        case "c":
          c[key]=value;
          try{
            if(px.containsKey(this_skey)){
              px[this_skey][key]=c;
            }}catch(e){}
          break;
        case "k":
          savekey(key,value);
          break;
        case "f":
          saveiform(key, value);
          update_field(this_skey,key, value);
          break;
      }
    });
  });
}
firebase_follow(String spath){
  /*

  try {

    String sk_follow=cmdval("k_follow");
    String save2=cmdval("fn_saveto");

    try {

      if (k_data.containsKey(sk_follow)) {
        (k_data[sk_follow] as StreamSubscription).cancel();
      }

    }catch(e){}


    StreamSubscription db= rt_db
        .child(spath)
        .onValue
        .listen((event) {
         row_firebase = new Map<String, dynamic>.from(event.snapshot.value);
         if(save2!=""){
           savedata2(save2, row_firebase);
         }
         if(event_bus!=null){
           event_bus.add("firebase_noti");
         }

         print("fbdata:"+row_firebase.toString());

    });

    if(sk_follow!=""){
      k_data[sk_follow]=db;
    }


  }catch(e){}*/


}





read_gps() async {
// checkcode
  /*
  geo.Geolocation.enableLocationServices().then((result) {
  }).catchError((e) {
  });
  geo.Geolocation.currentLocation(accuracy: geo.LocationAccuracy.best)
      .listen((result) {
    if (result.isSuccessful) {
      plink["my_lat"]= result.location.latitude;
      plink["my_lon"]= result.location.longitude;
      my_location = LatLng( result.location.latitude,result.location.longitude);

    }
  });*/
}

Future req_gps() async {
try{

  var location = Location();
  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) {
      return;
    }
  }

  var permission = await location.hasPermission();
  if (permission == PermissionStatus.denied) {
    permission = await location.requestPermission();
    if (permission != PermissionStatus.granted) {
      return;
    }
  }

  var loc = await location.getLocation();
  print("${loc.latitude} ${loc.longitude}");

  plink["my_lat"]=loc.latitude;
  plink["my_lon"]=loc.longitude;

  pvar["gps_lat"]=loc.latitude;
  pvar["gps_lon"]=loc.longitude;


}catch(e){}

}

f_readgps() async {

  try{

    var location = Location();
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }

    var loc = await location.getLocation();
    print("${loc.latitude} ${loc.longitude}");

    plink["my_lat"]=loc.latitude;
    plink["my_lon"]=loc.longitude;

    pvar["gps_lat"]=loc.latitude;
    pvar["gps_lon"]=loc.longitude;

    if(cmd.containsKey("getgps2click")){
      t_click=null2str(cmd["getgps2click"]);
    }


  }catch(e){}




/*

  try{


    await req_gps();
    geo.Geolocation.enableLocationServices().then((result) {
      geo.Geolocation.currentLocation(accuracy: geo.LocationAccuracy.best)
          .listen((result) {
        if (result.isSuccessful) {

          plink["my_lat"]=result.location.latitude;
          plink["my_lon"]=result.location.longitude;

          pvar["gps_lat"]=result.location.latitude;
          pvar["gps_lon"]=result.location.longitude;

          if(cmd.containsKey("x_click")){
            t_click=cmdval("x_click");
          }
        }
      });

    }).catchError((e) {
    });
  }catch(e){}
*/



}

 calltmsg(String strMsg) {
   Fluttertoast.showToast(
      msg:strMsg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

 tmsg(String strMsg) {


  var msg_pos=ToastGravity.SNACKBAR;

  switch(cmdval("tmsg_pos")){
    case "t":
      ToastGravity.TOP;
      break;
    case "c":
      ToastGravity.CENTER;
      break;

  }

   strMsg=strMsg.replaceAll("{msg_guid}",newkey());
   Fluttertoast.showToast(
      msg:strMsg,
      toastLength: Toast.LENGTH_SHORT,
      gravity:msg_pos,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
  );
}


Future<List>  readallkey()  async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getKeys().where((String key) => key != "lib_cached_image_data" && key != "lib_cached_image_data").map<Widget>((key) {
    return ListTile(
      title: Text(key),
      subtitle: Text(prefs.get(key).toString()),
    );
  }).toList(growable: false);

}





//
// Future<String> readkey(k)  async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return null2str(pref.get(k));
// }




Future bmsg(String strMsg) {
  try {
    ScaffoldMessenger.of(ctx()).clearSnackBars();
    ScaffoldMessenger.of(ctx()).showSnackBar(
        SnackBar(content: Text(strMsg))
    );
  }catch(e){
    //alert("bmsg.error.${e}");
  }

}

clear_pageform(){
  try {
    iform[active_key].forEach((key, value) {
      try {
        iform[active_key][key] = "";
      }catch(e){}
    });
  }catch(e){}
}
Map<String, dynamic>  getform(){
  return iform[active_key];
}
String readhval(Map<String, dynamic> h,String stree){
  String r="";
  List<String> a=stree.split(".");
  try {
    var hx = h;
    a.forEach((s1) {
      if(hx.containsKey(s1)){
        if (hx[s1] is Map<String, dynamic> ){
          hx=hx[s1];
        }else {
          r=hx[s1];
        }
      }
    });
    return r;
  }catch(e){
    // tmsg("error"+e.toString());
  }
  return r;
}

//
void setxval(String tkey,String tval){
  List<String> a=tkey.split(".");
  switch(a[0]){
    case "a":
      papp[a[1]]=tval;
      break;
    case "l":
      plink[a[1]]=tval;
      break;
    case "pf":
      pprofile[a[1]]=tval;
      break;
    case "sys":
      sys[a[1]]=tval;
      break;
  }
}
String getselectx(String rBind,String skey){


  plink.forEach((vkey, value) {
    rBind=rBind.replaceAll("@l."+vkey,value);
  });
  pvar.forEach((vkey, value) {
    rBind=rBind.replaceAll("@v."+vkey,value);
  });
  papp.forEach((vkey, value) {
    rBind=rBind.replaceAll("@a."+vkey,value);
  });

  return rBind;

}


readui(String sui,String skey){
  var uix=null;
  if(list_ui.containsKey(skey)){
    list_ui[skey].keys.forEach((uiName) {
      if(uiName.split(".").last.toLowerCase()==sui.split(".").last.toLowerCase()){
        uix= list_ui[skey][uiName];
        return uix;
      }
    });
  }
  return uix;
}
//v.social_tag[foryou
void savedata(String skey, String vcmdtext){


  try {
    List<String> a,b,cx;
    a=vcmdtext.split(",");
    a.forEach((s1) {

      b=s1.split("[");
      cx=b[0].split(".");


      switch(cx[0]){
        case "l":
          plink[cx[1]]=b[1];
          break;
        case "s":
          psend[cx[1]]=b[1];
          break;
        case "b":
          pback[cx[1]]=b[1];
          break;
        case "v":
          pvar[cx[1]]=b[1];
          break;
        case "sys":
          sys[cx[1]]=b[1];
          break;
        case "pf":
          pprofile[cx[1]]=b[1];
          break;
        case "a":
          papp[cx[1]]=b[1];
          break;
        case "k":
          savekey(cx[1], b[1]);
          break;
        case "cx":
          c[cx[1]]=b[1];
          if(px.containsKey(skey)){
            px[skey][cx[1]]=b[1];
          }
          break;
      }
    });
  }catch(e){
  }

}


String selectx(String s,skey){
  String sx = "";
  q.clear();
  try {
    String sval = "";
    List<String> a = s.split(",");
    List<String> b;
    String x = "";





    // if(s.contains("k.")){
    //   sleep(const Duration(seconds: 5));
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
        q[s] = null2str(cmd[s]);
        sx += "&" + s + "=" + null2str(cmd[s]);
      } else {
        b = s.split(".");

        switch (b[0]) {
          case "i":
            sval="";
            if(i.containsKey(b[1])){
              sval=null2str(i[b[1]][b[2]]);
            }
            break;

          case "f":
            if(isfoundfield(b[1])){
              sval=getdatafield(b[1]);
            }else {
              if (fx.containsKey(b[1])) {
                sval = fx[b[1]];
              }else {
                xval="${skey}.${b[1]}";
                if(list_ui[skey].containsKey(xval)){
                  sval=getojval(list_ui[skey][xval], skey, b[1]);
                }else {
                  xval="${b[1]}";
                  if(list_ui[skey].containsKey(xval)){
                    sval=getojval(list_ui[skey][xval], skey, b[1]);
                  }
                }
              }
            }
            break;
          case "fv":
            sval=getvfield(b[1]);
            break;
          case "fx":
            if (fx.containsKey(b[1])) {
              sval = fx[b[1]];
            }
            break;
          case "k":
          // g.readkey(b[1]).then((value) {
          //   sval = value;
          //   g.kk[b[1]] = value;
          // });
            if (pkey.containsKey(b[1])) {
              sval = pkey[b[1]];
            }
            break;
          case "g":
            sval = null2str(g[b[1]]);
            break;
          case "sys":
            sval = null2str(sys[b[1]]);
            break;
          case "r":
            sval = null2str(preturn[b[1]]);
            break;
          case "rb":
            sval = null2str(rowbind[b[1]]);
            break;
          case "v": // variable
            sval = null2str(pvar[b[1]]);
            break;
          case "pf": // variable
            sval = null2str(pprofile[b[1]]);
            break;
          case "lz": // variable
          case "l": // variable
            sval = null2str(plink[b[1]]);
            break;
          case "s": // variable
            sval = null2str(psend[b[1]]);
            break;
          case "b": // variable
            sval = null2str(pback[b[1]]);
            break;
          case "a": // variable
            sval = null2str(papp[b[1]]);
            break;
          case "c": // variable
            sval = null2str(c[b[1]]);
            break;
          case "lg": // variable
            sval = null2str(lg[b[1]]);
            break;
          case "j": // variable
            sval = null2str(jd[b[1]]);
            break;
          case "jd": // variable
            sval = null2str(jd[b[1]]);
            break;
          case "jh": // variable
            sval = null2str(jh[b[1]]);
            break;
          case "c": // variable
            sval = null2str(c[b[1]]);
            if(px.containsKey(skey)){
              sval=null2str(px[skey][b[1]]);
            }
            break;
          case "fr": // variable
            sval  = null2str(fr[b[1]]);
            break;
          case "js": // variable
            sval  = null2str(vjs[b[1]]);
            break;
          case "h": // variable
            sval = null2str(hx[b[1]]);
            break;
        }
        sval=encode_url(sval);
        q[b[1]] = sval;
        sx += "&" + b[1] + "=x" + sval;
      }
    });
  }catch(e){
    //alert("selectx.error."+e.toString());
  }

  // print("f:"+f[skey].toString());
  return sx;

}
Future alert(String strMsg) {
  return msg(strMsg);
}

Future msg(String strMsg) {


  return showDialog(
    context: ctx(),
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView( // won't be scrollable
          child: Text(strMsg),
        )  ,
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

getcmd(String cmdText,String skey){
  try{
    String a=getparameter_fromstring(cmdText);
    if(a!=""){
      selectx(a,skey);

      if(isdebug()){
        //alert("runcmd.selectx:"+q.toString());
      }
      List<String> l=a.split(",");
      List<String> b;
      String x="";
      l.forEach((s1) {
        b=s1.split(".");
        cmdText=cmdText.replaceAll("{"+s1+"}",null2str(q[b[b.length-1]]));
        print("set $b[0]->$b[1] ");
      });
    }
  }catch(e){}
  return cmdText;
}



String query_fromstr(String sin){

  String s="";
  List<String> sall = sin.split("");
  bool isstart = false;
  for (String c in sall) {
    if(isstart){
      s+=c;
    }
    if( c=="{"){
      isstart = true;
    }
    if( c== "}" ){
      if(isstart){
        s+=",";
      }
      isstart=false;
    }
  }
  s=s.replaceAll("{","").replaceAll("}","");
  if(s !="" ){
    s=rcut(s);
  }

  return s;

}

String replace_var(String s,String skey){


  String  s1=query_fromstr(s);

  if(s1==""){
    return s;
  }

  List<String> a=s1.split(",");
  List<String> b;
  selectx(s1, skey);
  a.forEach((sl1) {
    b=sl1.split(".");
    s=s.replaceAll("{"+sl1+"}", q[b[1]]);
  });
  return s;
}
String readjscmd(String k){
  try {
    var js = jsonDecode(read_json(json_ui, "cmd"));
    return js[k];
  }catch(e){}
  return "";

}

String lcut(String s){
  if(s==""){
    return "";
  }
  return s.substring(1,s.length-1);
}
String rcut(String s){
  if(s==""){
    return "";
  }
  return s.substring(0,s.length-1);
}



Future<Map<String, String>> getallkey() async {

  final prefs = await SharedPreferences.getInstance();
  final keys = prefs.getKeys();
  final prefsMap = Map<String, dynamic>();
  for(String key in keys) {
    prefsMap[key] = prefs.get(key);
    pkey[key]=prefs.get(key);
  }



}


void save_memory(String k,String v){
  mem[k]=v;
}
String read_memory(String k){
  return null2str(mem[k]);
}
Future<void> firebase_init(String skey,Map<String, dynamic>  tcmd) async {
  try {
    regis_firebase = true;
    /* if(json_ui.containsKey("firebase_config")){
      await firebase_config();
    }else {
      await Firebase.initializeApp();
    }*/

    await cmd_firebase_init();

  }catch(e){
    alert("firebase_init.error.${e}");
  }

}




cmd_firebase_init() async {


  try {

    String sfileConfig = "firebase_config";
    if (Platform.isIOS) {
      sfileConfig = "firebase_config_ios";
    }
    String sval = read_json(json_ui, sfileConfig);
    if(cmd.containsKey("firebase_config")){
      sval = read_json(json_ui, cmdval("firebase_config"));
    }
    var fbOption;
    if(sval!=""){
      try{
        var j = jsonDecode(sval);
        fbOption= new FirebaseOptions(
            appId: null2str(j["appId"]),
            apiKey: null2str(j["apiKey"]),
            databaseURL: null2str(j["databaseURL"]),
            storageBucket: null2str(j["storageBucket"]),
            messagingSenderId: null2str(j["messagingSenderId"]),
            projectId: null2str(j["projectId"]),
            authDomain: null2str(j["authDomain"]),
            measurementId: null2str(j["measurementId"]),
            trackingId: null2str(j["trackingId"]),
            deepLinkURLScheme: null2str(j["deepLinkURLScheme"]),
            androidClientId: null2str(j["androidClientId"]),
            iosClientId: null2str(j["iosClientId"]),
            iosBundleId: null2str(j["iosBundleId"]),
            appGroupId: null2str(j["appGroupId"])
        );
      }catch(e){

      }

    }



    if(isdebug()){
      alert("firebase_config_option:${fbOption}");
    }


    // default auto setup
    if(cmdval("setup_firebase_type") !=  "manual"){
      await Firebase.initializeApp();
    }else {
      await Firebase.initializeApp(
          name: null2str(j["name"]),
          options: fbOption
      );
    }


    if(isdebug()){
      alert("firebase_config_option_ok:${Firebase.apps}");
    }



  }catch(e){
    if(isdebug()){
      alert("cmd_firebase_init.error:${e}");
    }
  }
}

bool str2bool(String sbool){
  sbool=sbool.toLowerCase();
  if(sbool=="true" ||
      sbool=="1" ||
      sbool=="y" ||
      sbool=="yes"){
    return true;
  }
  return false;
}
bool readbool(String sbool,bool defbool){
  if(sbool!=""){
    return str2bool(sbool);
  }
  return defbool;
}

get_chipstyle( Map<String, dynamic> m,String stag){

  if(stag=="select"){
    return C2ChoiceStyle(showCheckmark: false,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        borderWidth: 0.0,
        elevation: 0.0,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        brightness: Brightness.dark,
        color: getcolor(
            strx(m["select_background_color"], "#735FB0")),
        labelStyle: TextStyle(
            color: getcolor(strx(m["select_color"], "#FFFFFF"))),
        borderShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            side: BorderSide(
                color: getcolor(strx(m["select_border_color"], "#FFFFFF")))
        ));
  }
  return C2ChoiceStyle(showCheckmark: false,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      borderWidth: 0.0,
      elevation: 0.0,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      brightness: Brightness.dark,
      color: getcolor(strx(m["background_color"], "#D0D0D0")),
      labelStyle: TextStyle(
          color: getcolor(strx(m["text_color"], "#000000"))),
      borderShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          side: BorderSide(
              color: getcolor(strx(m["border_color"], "#FFFFFF")))
      ));


}


ThemeData gettheme(){

  try{

    String font=null2str(info["font"]);
    //tmsg("font=${font}");
    if(font!=""){
      return ThemeData(
          primaryColor:getcolor(main_color),
          fontFamily: font,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        ),
          appBarTheme: AppBarTheme(
            elevation: 0, // This removes the shadow from all App Bars.
          ));
    }else {
      return ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent,
          ),
          primaryColor:getcolor(main_color),
          appBarTheme: AppBarTheme(
            elevation: 0, // This removes the shadow from all App Bars.
          ));
    }

  }catch(e){}



}

foundkey(String k) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return (prefs.get(k)!=null);
}

Future<void> net_isconnect() async {
  net_connect=true;
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    net_connect=true;
  } else {
    net_connect=false;
  }
}
void closeapp(){
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}

playsound(String url) async {

  try{
    gplayer.stop();
  }catch(e){}
  gplayer = AudioPlayer();                   // Create a player
  final duration = await gplayer.setUrl(url);
  gplayer.playerStateStream.listen((playerState) {
    if (playerState.processingState == ProcessingState.ready) {
      gplayer.play();                                  // Play without waiting for completion
    }
  });

}
play_sound(String stag){

  try {
    String url = cmdval("sound_url");
    switch (stag) {
      case "start":
        playsound(url);
        break;
      case "start_stream":
        try {
          gplayer.stop();
        } catch (e) {}
        gplayer = AudioPlayer(); // Create a player
        gplayer.setUrl(url); // Schemes: (https: | file: | asset: )
        try {
          gplayer.playerStateStream.listen((playerState) {
            final isPlaying = playerState.playing;
            final processingState = playerState.processingState;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              //buttonNotifier.value = ButtonState.loading;
            } else if (!isPlaying) {
              //buttonNotifier.value = ButtonState.paused;
            } else {
              //buttonNotifier.value = ButtonState.playing;
            }
          });

        } catch (e) {}


        break;
      case "stop":
        gplayer.stop();
        break;
      case "pause":
        gplayer.pause();
        break;
      case "play":
        gplayer.play();
        break;
      default:
        break;
    }
  }catch(e){}

}
stop_player(){
  if(gplayer.playing){
    try {
      gplayer.stop();
    } catch (e) {}
  }
}
play_sound2(String url){

  try {
    try {
      gplayer.stop();
    } catch (e) {}

    gplayer = AudioPlayer(); // Create a player
    gplayer.setUrl(url); // Schemes: (https: | file: | asset: )
    gplayer.play(); //
  }catch(e){}

}

create_dir(String sfolder) async {

  final Directory _appDocDirFolder =
  Directory(sfolder);
  if (await _appDocDirFolder.exists()) {
    //if folder already exists return path
    return _appDocDirFolder.path;
  } else {
    //if folder not exists create folder and then return its path
    final Directory _appDocDirNewFolder =
    await _appDocDirFolder.create(recursive: true);
    return _appDocDirNewFolder.path;
  }

}
Future<String> crete_doc_dir(String folderName) async {

  final Directory _appDocDir = await getApplicationDocumentsDirectory();
  //App Document Directory + folder name
  final Directory _appDocDirFolder =
  Directory('${_appDocDir.path}/$folderName/');
  return create_dir('${_appDocDir.path}/$folderName/');

}



showoverlay(bool isshow){
  try{

    if(isshow){
      ctx().showLoaderOverlay();
      isshow_overlay=true;
    }else {
      if(isshow_overlay){
        ctx().hideLoaderOverlay();
        isshow_overlay=false;
      }
    }

  }catch(e){}

}

String findurl(String text){
  String r="";


  RegExp exp = new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  Iterable<RegExpMatch> matches = exp.allMatches(text);

  matches.forEach((match) {
    r=text.substring(match.start, match.end);
    exit;
  });
  return r;
}


Future<void> _checkInternetConnection() async {
  bool _isConnected=false;
  try {
    final response = await InternetAddress.lookup('www.kindacode.com');
    if (response.isNotEmpty) {
      _isConnected = true;
    }
  } on SocketException catch (err) {
    _isConnected = false;
  }
  return _isConnected;
}

// replace_on_page_load
String page_replace(String s,String skey,String stag){
  try {

    if(skey==""){
      skey=active_key;
    }


    s=s.replaceAll("{k}", skey);
    List<String> a;
    jh.forEach((key, v) {
      try {
        s=s.replaceAll("{jhx." + key + "}", null2str(v));
      }catch(e){
      }
    });



    c.forEach((key, v) {
      try {
        s=s.replaceAll("{cx." + key + "}", null2str(v));
      }catch(e){
      }
    });


    if(px.containsKey(skey)){
      px[skey].forEach((k1, v1) {
        try {
          s=s.replaceAll("{px." + k1 + "}", null2str(v1));
        }catch(e){
        }
      });
    }



    if(jsonx!=""){
      try{
        List allrow= jsonDecode(jsonx)["d"] as List;
        if(allrow.length > 0 ) {
          allrow[0].forEach((key, v) {
            try {
              s=s.replaceAll("{jd." + key + "}", null2str(v));
            }catch(e){
            }
          });
        }
      }catch(e){}

      try{
        List allrow= jsonDecode(jsonx)["h"] as List;
        if(allrow.length > 0 ) {
          allrow[0].forEach((key, v) {
            try {
              s=s.replaceAll("{jh." + key + "}", null2str(v));
            }catch(e){
            }
          });
        }
      }catch(e){}

      // js_table
      if(cmdval("js_table") != ""){
        a=cmdval("js_table").split(",");
        a.forEach((table_name) {
          try{
            List allrow= jsonDecode(jsonx)[table_name] as List;
            if(allrow.length > 0 ) {
              allrow[0].forEach((key, v) {
                try {
                  s=s.replaceAll("{j${table_name}." + key + "}", null2str(v));
                }catch(e){
                }
              });
            }
          }catch(e){}
        });
      }

    }



    dr.forEach((key, v) {
      try {
        s=s.replaceAll("{drx." + key + "}", null2str(v));
      }catch(e){
      }
    });


    pprofile.forEach((key, v) {
      try {
        s=s.replaceAll("{pfx." + key + "}", null2str(v));
      }catch(e){
      }
    });





    j.forEach((key, v) {
      try {
        s=s.replaceAll("{jx." + key + "}", null2str(v));
      }catch(e){
      }
    });

    jd.forEach((key, v) {
      try {
        s=s.replaceAll("{jdx." + key + "}", null2str(v));
      }catch(e){
      }
    });
    jd.forEach((key, v) {
      try {
        s=s.replaceAll("{j." + key + "}", null2str(v));
      }catch(e){
      }
    });

    lg.forEach((key, v) {
      try {
        s=s.replaceAll("{lg." + key + "}", null2str(v));
      }catch(e){
      }
    });


    //  send
    if(send_bind.length>0){
      send_bind.forEach((k, v) {
        s=s.replaceAll("{s."+k+"}", null2str(v));
      });
    }

    if(send_bind.length>0){
      send_bind.forEach((k, v) {
        s=s.replaceAll("{sx."+k+"}", null2str(v));
      });
    }
    if(fr.length>0){
      fr.forEach((k, v) {
        s=s.replaceAll("{fr."+k+"}", null2str(v));
      });
    }

    // var
    if(pvar.length>0){
      pvar.forEach((k, v) {
        s=s.replaceAll("{vx."+k+"}", null2str(v));
      });
    }

    // app
    papp.forEach((key, v) {
      try {
        s = s.replaceAll("{ax."+key+"}",null2str(v));
      }catch(e){
      }
    });

    if (plink.length > 0) {
      plink.forEach((k, v) {
        try {
          s = s.replaceAll("{lx." + k + "}", null2str(v));
          //s = s.replaceAll("{l." + k + "}", null2str(v));
        } catch (e) {}
      });
    }

    try{

      if(cmd.containsKey("send_json")){

        List allrow = jsonDecode(jsonx)[cmdval("send_json")] as List;
        if (allrow.length > 0) {
          Map<String, dynamic> h = allrow[0] as Map<String, dynamic>;
          h.forEach((skey, sval) {
            print("replace_${skey}=${null2str(sval)}");
            s = s.replaceAll("{j." + skey + "}", null2str(sval));
          });
        }
      }


    }catch(e){}


    // from link
    Map<String, dynamic> h = new Map<String, dynamic>();
    h=cfg as   Map<String, dynamic>;
    h.forEach((k, v) {
      try {
        s=s.replaceAll("{cfg."+k+"}", null2str(v));
      }catch(e){}
    });


    if(sys.length>0){
      sys.forEach((k, v) {
        try {
          s = s.replaceAll("{x." + k + "}", null2str(v));
        }catch(e){}
      });
    }

    if(c.containsKey("replace_var")){
      a=null2str(c["replace_var"]).split(",");
      a.forEach((str) {
        switch(str){
          case "sys":
            pvar.forEach((key, v) {
              s=s.replaceAll("{sys."+key+"}",null2str(v));
            });
            break;
        }
      });
    }



  }catch(e){
    tmsg("fill_msg_error${e}");

  }

//log("return_page_ui=${}")
  return s;
}
void print_log(String text) {
 // final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  //pattern.allMatches(text).forEach((match) => print(match.group(0)));

  logger.log(text);
}
String getid(String s){
  try {
    return s.split(".").last;
  }catch(e){}
  return "";
}
String readurl(String url){
  return url.replaceAll("(eq)","=").replaceAll("%3d", "=");
}

openlinkv2(String url) async {
  url=decode_url(readurl(url));
  if (await canLaunch(url)) {
    await launch(url,
        forceWebView: true,
        enableJavaScript: true);
  } else {
    throw 'Could not launch $url';
  }
}

openlink(String url) async {
  try{
    url=decode_url(readurl(url));
    if (await canLaunch(url)) {
    await launch(url,
          forceSafariVC:(cmdval("used_safari")=="true") ,
          forceWebView: (cmdval("used_webview")=="true"),
          enableDomStorage: true,
          enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }

  }catch(e){}


}

openlink2(String url) async {

  try{

    if(url==""){
      url=plink["link"];
    }
    url=decode_url(readurl(url));
    await custom_tabs.launch(
      url,
      option: custom_tabs.CustomTabsOption(
        toolbarColor: cmd.containsKey("web_background_color")? getcolor(cmd["web_background_color"]):Colors.white,
        enableDefaultShare: false,
        enableUrlBarHiding: false,
        showPageTitle: true,
        extraCustomTabs: const <String>[
          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
          'org.mozilla.firefox',
          // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
          'com.microsoft.emmx',
        ],
      ),
    );

  }catch(e){
    print("custom_tab.error.${e}");
  }


}


String concate_string(String a,String b,String x){
  String r="";
  if(cint(a,0)<=cint(b,0)){
    r=a+x+b;
  }else {
    r=b+x+a;
  }
  return r;
}
saveprofile( Map<String, dynamic> h){
  try {

    h.forEach((key, value) {
      pprofile[key] = value;
    });
    savekey("this_pf", json.encode(pprofile));
    print("saveprofile_${pprofile}");

    if(h.containsKey("login_id")){
      login_id=h["login_id"];
      savekey("login_id", h["login_id"]);
      pkey["login_id"]=h["login_id"];
    }

  }catch(e){}

}

bool check_login(){
  return (null2str(pprofile["login_id"])!="");
}
BuildContext ctx(){
  //return g_ctx;
  //return OneContext().context;
  return ContextHolder.currentContext;
}


bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}






wait_page_active(int idelay){
  is_active=false;
  Future.delayed(Duration(milliseconds: idelay), () async {
    is_active=true;
  });
}

restartapp(String code)  async {


  if(cmdval("restartcode") != ""){
    code=cmdval("restartcode");
  }

  Future.delayed(Duration(milliseconds: 2000), () async {


    switch (code) {
    case "a":
      Navigator.pushNamedAndRemoveUntil(ctx(), '/', (_) => false);
      break;

    case "b":
     // FlutterRestart.restartApp();
      break;

    case "c":
      Phoenix.rebirth(ctx());
      break;
    default:
      try {
          if (Platform.isAndroid) {
            //FlutterRestart.restartApp();
          } else {
            try {
              Phoenix.rebirth(ctx());
            } catch (e) {}
            try {
              //FlutterRestart.restartApp();
            } catch (e) {}

            try {
              Navigator.pushNamedAndRemoveUntil(ctx(), '/', (_) => false);
            } catch (e) {}

          }
      } catch (e) {
        print("call restart app.error." + e.toString());
      }
      break;
  }
  });



}





  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http_get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }




save_textfile(String sfile,String text) async {
  try{
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/'+sfile);
    await file.writeAsString(text);
  }catch(e){}

}
Future<String> read_textfile(String sfile) async {

  String text="";
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/'+sfile);
    text = await file.readAsString();
  } catch (e) {
    // print("file_not_found:${sfile}");
  }
  return text;
}


class gx {
  //One instance, needs factory
  static gx _instance;
  factory gx() => _instance ??= new gx._();
  gx._();
  //
  String tClick ='';
  String account ='johanacct1';
  String getServerUrl(){
    return 'http://192.168.1.60';
  }
  String getAccountUrl(){
    return getServerUrl()+'/accounts/'+account;
  }
}


class h_delegate extends SliverPersistentHeaderDelegate {
  h_delegate({
    @required this.min_height,
    @required this.max_height,
    @required this.child,
  });
  final double min_height;
  final double max_height;
  final Widget child;

  @override
  double get minExtent => min_height;

  @override
  double get maxExtent => math.max(max_height, min_height);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(h_delegate oldDelegate) {
    return max_height != oldDelegate.max_height ||
        min_height != oldDelegate.min_height ||
        child != oldDelegate.child;
  }
}


/*
class MyAudioHandler extends BaseAudioHandler
    with QueueHandler, // mix in default queue callback implementations
        SeekHandler { // mix in default seek callback implementations

  // The most common callbacks:
  Future<void> play() async {
    // All 'play' requests from all origins route to here. Implement this
    // callback to start playing audio appropriate to your app. e.g. music.
  }
  Future<void> pause() async {}
  Future<void> stop() async {}
  Future<void> seek(Duration position) async {}
  Future<void> skipToQueueItem(int i) async {}
}*/


extension UtilListExtension on List{
  groupBy(String key) {
    try {
      List<Map<String, dynamic>> result = [];
      List<String> keys = [];

      this.forEach((f) => keys.add(f[key]));

      [...keys.toSet()].forEach((k) {
        List data = [...this.where((e) => e[key] == k)];
        result.add({k: data});
      });

      return result;
    } catch (e, s) {
      return this;
    }
  }
}
extension GroupingBy on Iterable<dynamic> {
  Map<String, List<dynamic>> groupingBy(String key){
    var result = <String, List<dynamic>>{};
    for(var element in this){
      result[element[key]] = (result[element[key]] ?? [])..add(element);
    }
    return result;
  }
}
/*
extension value_in on String {
  int parseInt() {
    return int.parse(this);
  }
}*/
