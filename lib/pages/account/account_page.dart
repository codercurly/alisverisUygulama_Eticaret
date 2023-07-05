import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icons.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/custom_app_barr.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("giriş yapılı");
    }
    return Scaffold(
      appBar:  CustomAppBar(title: "Profil"),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?(userController.isLoading? CustomLoader():Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              AppIcon(size1:Dimensions.height10*15,icon: Icons.person, BgColor:
              AppColors.mainColor,size: Dimensions.height15*10,iconColor: Colors.white,),
              SizedBox(height: Dimensions.height30),

              Expanded(child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountWidget(appIcon: AppIcon(size1:Dimensions.width10*5,icon: Icons.person, BgColor:
                    AppColors.mainColor,size: Dimensions.iconSize31,iconColor: Colors.white,top: 0), bigText:
                    BigText(text:userController.isLoading?"":  userController.userModel?.name??""),),
                    SizedBox(height: Dimensions.height30),
                    //tel
                    AccountWidget(appIcon: AppIcon(size1:Dimensions.width10*5,icon: Icons.phone, BgColor:
                    Colors.pink.shade200,size: Dimensions.iconSize31,iconColor: Colors.white,top: 0), bigText:
                    BigText(text:userController.isLoading?"": userController.userModel?.phone??""),),
                    SizedBox(height: Dimensions.height30),
                    //email
                    AccountWidget(appIcon: AppIcon(size1:Dimensions.width10*5,icon: Icons.mail_outline, BgColor:
                    AppColors.yellowColor,size: Dimensions.iconSize31,iconColor: Colors.white,top: 0), bigText:
                    BigText(text:userController.isLoading?"":  userController.userModel?.email??""),),
                    SizedBox(height: Dimensions.height30),
                    //adres
                   GetBuilder<LocationController>(builder: (locationController){
                     if(_userLoggedIn&&locationController.addressList.isEmpty&& locationController.getUserAddressFromlocalStroage()==""){
                      return  GestureDetector(
                           onTap: (){
                             Get.offNamed(RouteHelper.getAddressPage());
                           },
                           child: AccountWidget(appIcon: AppIcon(size1:Dimensions.width10*5,icon: Icons.location_on, BgColor:
                           AppColors.iconColor2,size: Dimensions.iconSize31,iconColor: Colors.white,top: 0), bigText:
                           BigText(text:userController.isLoading?"":  "Lütfen adresinizi girin")),
                         );

                     }else{
                       return  GestureDetector(
                         onTap: (){
                           Get.offNamed(RouteHelper.getAddressPage());
                         },
                         child: AccountWidget(appIcon: AppIcon(size1:Dimensions.width10*5,icon: Icons.location_on, BgColor:
                         AppColors.iconColor2,size: Dimensions.iconSize31,iconColor: Colors.white,top: 0), bigText:
                         BigText(text: userController.isLoading?"": "Adresiniz",)),
                       );
                     }
                   }),
                    SizedBox(height: Dimensions.height30),
                    //mesaj
                    AccountWidget(appIcon: AppIcon(size1:Dimensions.width10*5,icon: Icons.message, BgColor:
                    Colors.green.shade200,size: Dimensions.iconSize31,iconColor: Colors.white,top: 0), bigText:
                    BigText(text: "mesajınız",),),
                    SizedBox(height: Dimensions.height30),
                    //logout
                    GestureDetector(
                      onTap: (){
                        if(Get.find<AuthController>().userLoggedIn()){
                          Get.find<AuthController>().clearSharedData();
                          Get.find<CartController>().clear();
                          Get.find<CartController>().clearCartHistory();
                          Get.find<LocationController>().clearAddressList();
                          Get.offNamed(RouteHelper.getSignInPage());
                        }
                      },
                      child: AccountWidget(appIcon: AppIcon(size1:Dimensions.width10*5,icon: Icons.logout, BgColor:
                      Colors.red.shade200,size: Dimensions.iconSize31,iconColor: Colors.white,top: 0), bigText:
                      BigText(text: userController.isLoading?"": "çıkış yap")),
                    ),
                    SizedBox(height: Dimensions.height30),
                    //
                  ],
                ),
              ))

            ],
          ),
        )):Container(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height45*9,
                  margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                  padding: EdgeInsets.all(Dimensions.height10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/sad.webp"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(height: Dimensions.height30*2),
                GestureDetector(
                  onTap: (){
                    Get.offNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20*6,
                    margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                    padding: EdgeInsets.all(Dimensions.height10),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30)
                    ),
                    child: Center(child: BigText(text: "Giriş Yap",color: Colors.white,size:33)),
                  ),
                )
              ],
            ),
          ),
        );
      })
    );

  }
}
