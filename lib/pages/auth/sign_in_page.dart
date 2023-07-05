import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/pages/auth/signup_page.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();


    void _login(AuthController authController){
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

     if(phone.isEmpty){
        ShowCustomSnackBar("tel girin", title: "Telefon");
      }else if(password.isEmpty){
        ShowCustomSnackBar("şifrenizi girin", title: "şifre");
      }else if(password.length<6){
        ShowCustomSnackBar("Şifre en az 6 karakterden oluşmalı", title: "en az 6 karakter");
      }else{
     authController.login(phone, password).then((status) {
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            ShowCustomSnackBar(status.message);
            print(status.message);
          }
        });
      }
    }


    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10*4),
              Container(
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius20*4,
                    backgroundImage: AssetImage("assets/donut.webp"),

                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Merhaba", style: TextStyle(fontSize: Dimensions.font20*3,
                        fontWeight: FontWeight.bold
                    )),
                    Text("Giriş yapın", style: TextStyle(fontSize: Dimensions.font20,
                        color: Colors.grey
                    )),
                  ],
                ),
              ),
              //phone

              SizedBox(height: Dimensions.height20,),
              AppTextField(
                hintText: "tel", icon: Icons.phone,
                textEditingController: phoneController,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                  hintText: "şifre", icon: Icons.key,
                  textEditingController: passwordController, isObscure: true),
              SizedBox(height: Dimensions.height20,),
              //phone



              //buton
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2.7,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30)
                  ),
                  child: Center(child: BigText(text: "Giriş Yap", color: Colors.white,size: Dimensions.font23*1.5)),
                ),
              ),
              SizedBox(height: Dimensions.height10*3),
              RichText(

                text: TextSpan(

                    text: " Henüz bir hesabın yok mu? ",style:
                TextStyle(fontSize: Dimensions.font23/1.150, color: Colors.grey),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=> Get.to(()=>SignUpPage(), transition: Transition.fadeIn),
                        text: "KAYDOL",style:
                      TextStyle(fontSize: Dimensions.font23/1.150, color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                      )]
                ),

              ),

            ],
          ),
        ):CustomLoader();
      })
    );

  }
}
