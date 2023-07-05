
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_controller.dart';
import 'package:food_delivery/helper/notification_helper.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:food_delivery/helper/dependencies.dart' as dep;
import 'package:url_strategy/url_strategy.dart';


Future<dynamic> myBackgroundMessageHandler (RemoteMessage message) async {
  print("arkaplanda  ${message.notification?.title}"
      "/${message.notification?.body}/"
      "${message.notification?.titleLocKey}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin= FlutterLocalNotificationsPlugin();

  Future<void> main() async{
    setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  await dep.init();

  try{
    if(GetPlatform.isMobile){
      final RemoteMessage? remoteMessage =await FirebaseMessaging.instance.getInitialMessage();
      await NotificationHelper.initalize(FlutterLocalNotificationsPlugin());
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  }catch(e){
    if (kDebugMode) {
      print(e.toString());
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
   return GetBuilder<PopularProductController>(builder: (_){
     return GetBuilder<RecommendedProductController>(builder: (_){
       return  GetMaterialApp(
         title: 'Flutter Demo',
         debugShowCheckedModeBanner: false,
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
         //home: SignInPage(),
         theme: ThemeData(
           primaryColor: AppColors.mainColor
         ),
       );
     });

   });
  }

}
