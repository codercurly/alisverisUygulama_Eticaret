import 'dart:async';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_controller.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  late Animation<double> animation;
  late AnimationController _controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    Get.find<AuthController>().updateToken();
    _loadResource();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    Timer(const Duration(seconds: 3),
        () => Get.toNamed(RouteHelper.getInitial()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: ScaleTransition(
            scale: animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset("assets/logo.png", fit: BoxFit.fill,
                      height: Dimensions.height20*10,
                      width: Dimensions.width30*4.4),
                ),
                SizedBox(height: 30),
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 32),
                )
              ],
            )));
  }
}
