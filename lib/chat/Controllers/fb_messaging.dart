import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../../chat/Model/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../g.dart' as g;
import 'fb_firestore.dart';

class NotificationController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static NotificationController get instance => NotificationController();

  Future takeFCMTokenWhenAppLaunch() async {
    try{
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        saveUerTokenToSharedPreference();
       // g.tmsg('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        saveUerTokenToSharedPreference();
       // g.tmsg('User granted provisional permission');
      } else {
       // g.tmsg('User declined or has not accepted permission');
      }

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
       // g.tmsg('onMessageOpenedApp');
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      });
    }catch(e) {
      print(e.message);
    }
  }

  Future<void> gettoken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken(
        vapidKey: firebaseCloudvapidKey
    ).then((val) async {

      g.papp["firebase_fcmtoken"]=val;
      g.pprofile["firebase_fcmtoken"]=val;



    });
  }

  Future<void> saveUerTokenToSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken(
        vapidKey: firebaseCloudvapidKey
    ).then((val) async {
      prefs.setString('FCMToken', val);
      g.papp["firebase_fcmtoken"]=val;
      g.pprofile["firebase_fcmtoken"]=val;
    });
  }

  Future<void> updateTokenToServer() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken(
        vapidKey: firebaseCloudvapidKey
    ).then((val) async {
      print('Token: '+val);
      prefs.setString('FCMToken', val);
      String userID = prefs.get('userId');

      g.papp["firebase_id"]=userID;
      g.papp["firbase_fcmtokey"]=val;
      g.pprofile["firebase_fcmtoken"]=val;


      if(userID != null) {
        FirebaseAuth.instance.authStateChanges().listen((User user) {
          if (user != null) {
            FBCloudStore.instanace.updateUserToken(userID, val);
          }
        });
      }
    });
  }

  Future initLocalNotification() async{
    if (Platform.isIOS ) {
      // set iOS Local notification.
      var initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }else {
      var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }
  }

  Future _onDidReceiveLocalNotification(int id, String title, String body, String payload) async { }

  Future _selectNotification(String payload) async { }

  Future<void> send_noti_touser(peerUserToken,stitle,sdetail,refid) async {



    try{
      await http.post(

        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$firebaseCloudserverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'title': stitle,
              'body':sdetail,
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
            'to': peerUserToken,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendNotificationMessageToPeerUser(unReadMSGCount,messageType,textFromTextField,myName,chatID,peerUserToken,myImageUrl) async {
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    try{
      await http.post(
        // 'https://fcm.googleapis.com/fcm/send',
        // 'https://api.rnfirebase.io/messaging/send',
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$firebaseCloudserverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': messageType == 'text' ? '$textFromTextField' : '(Photo)',
              'title': '$myName',
              'badge':'$unReadMSGCount',//'$unReadMSGCount'
              "sound" : "default",
              "image" : myImageUrl
            },
            // 'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'chatroomid': chatID,
              'userImage':myImageUrl,
              'userName':'$myName',
              'message': messageType == 'text' ? '$textFromTextField' : '(Photo)',
            },
            'to': peerUserToken,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}