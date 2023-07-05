import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:get/get.dart';

class NotificationHelper{

 static Future<void> initalize
     ( FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin)async {
  var androidInitialize = const AndroidInitializationSettings('notification_icon');
  var initializationSettings = InitializationSettings();
  var onSelectNotification = flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  var iOSInitialize =const DarwinInitializationSettings ();
  var initializationsSettings = InitializationSettings(android:  androidInitialize, iOS: iOSInitialize);
  flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (payload){
   try{
    if(payload !=null){


    }else{

    }
   }catch(e){
    if (kDebugMode) {
      print(e.toString());
    }
    return;
   }
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
   alert: true,
   badge: true,
   sound: true
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
   print("-------------------onmessage");
   print("onmessage ${message.notification?.title} / ${message.notification?.body}/${message.notification?.titleLocKey}");

  showNotification(message, flutterLocalNotificationsPlugin);

   if(Get.find<AuthController>().userLoggedIn()){

   }

  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

   print(" openedApp: ${message.notification?.title} / ${message.notification?.body}/"
       "${message.notification?.titleLocKey}");
try{
 if(message.notification?.titleLocKey !=null ){
  //Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(message.notification!.titleLocKey!)));
 }
} catch(e){
 print(e.toString());
}

  });
}

static Future<void> showNotification(RemoteMessage msg,
    FlutterLocalNotificationsPlugin fln) async{
  BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
   msg.notification!.body!, htmlFormatBigText: true,
  contentTitle: msg.notification!.title!, htmlFormatContentTitle: true
  );
  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('channel_id_1', 'dbfood',
  importance: Importance.high, styleInformation:  bigTextStyleInformation, priority:  Priority.high,
   playSound: true
  );
 NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,
 iOS: const DarwinNotificationDetails()
 );

 await fln.show(0, msg.notification?.title, msg.notification?.body, platformChannelSpecifics);
 }

}