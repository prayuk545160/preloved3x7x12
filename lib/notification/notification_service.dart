import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../g.dart';

class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {

    if(!regis_noti){

      regis_noti=true;
      var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) {
            print("onDidReceiveLocalNotification called.");
          });
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (payload) {
            print("onSelectNotification called.");

            // setState(() {
            //   message = payload;
            // });


          });

    }

  }


  Future selectNotification(String payload) async {
    //Handle notification tapped logic here
  }





}