import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
new FlutterLocalNotificationsPlugin();

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("onBackgroundMessage: $message");
  //_showBigPictureNotification(message);
  return Future<void>.value();
}


Future onSelectNotification(String payload) async {

}

class NotificationHandler {


  FirebaseMessaging _fcm;// = FirebaseMessaging();
  StreamSubscription iosSubscription;
  static final NotificationHandler _singleton =
  new NotificationHandler._internal();

  factory NotificationHandler() {
    return _singleton;
  }
  NotificationHandler._internal();


  initializeFcmNotification() async {

    /*

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("---------------------On Message--------------------");
        displayNotification(message['data']['title'],message['data']['body']);
        _saveNotificationToLocal(message);
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler ,
      onLaunch: (Map<String, dynamic> message) async {
        print("---------------------On Lunch--------------------");
        _saveNotificationToLocal(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("---------------------On Resume--------------------");
        _saveNotificationToLocal(message);
      },
    );

    */



  }

  _saveNotificationToLocal(Map<String, dynamic> message){

    String sender_id = message['data']['sender_id'];
    String message_id = message['data']['message_id'];
    String title = message['data']['title'];
    String body = message['data']['body'];
    String del_time  = getCurrentDateTime();


  }

  String getCurrentDateTime(){
    var now = new DateTime.now();
    var formatter = new DateFormat('MMM d yy h:mm a');
    String formatted = formatter.format(now);
    return formatted;
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    String fcmToken = await _fcm.getToken();
  }


  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }

  void displayNotification(String title,String body) async{
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '10000',
        'FLUTTER_NOTIFICATION_CHANNEL',
        'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '$title', '$body', platformChannelSpecifics,
        payload: 'item x');
  }
}