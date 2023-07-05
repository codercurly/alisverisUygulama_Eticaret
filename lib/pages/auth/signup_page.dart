import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/sign_up_body_model.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImgs = [
      "g.png",
      "t.png",
      "f.png"

    ];

    void _registration(AuthController authController){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        ShowCustomSnackBar("adınızı girin", title: "Ad");
      } else if(phone.isEmpty){

        ShowCustomSnackBar("numarınız girin", title: "Telefon");
      }else if(email.isEmpty){
        ShowCustomSnackBar("mailinizi girin", title: "Email");
      } else if(!GetUtils.isEmail(email)){
        ShowCustomSnackBar("geçerli bir e-posta adresi girin", title: "Geçersiz mail");
      }else if(password.isEmpty){
        ShowCustomSnackBar("şifrenizi girin", title: "şifre");
      }else if(password.length<6){
        ShowCustomSnackBar("Şifre en az 6 karakterden oluşmalı", title: "en az 6 karakter");
      }else{
        SignUpBody signUpBody = SignUpBody(name: name, password: password, phone: phone, email: email);
authController.registration(signUpBody).then((status) {
  if(status.isSuccess){
    print("helal len");
    Get.offNamed(RouteHelper.getInitial());
  }else{
    ShowCustomSnackBar(status.message);
  }
});
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10*4),
              Container(
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius20*4,
                    backgroundImage: AssetImage("assets/donut.png"),

                  ),
                ),
              ),
              AppTextField(
                hintText: "mail", icon: Icons.mail,
                textEditingController: emailController,),
              SizedBox(height: Dimensions.height20,),
              //pass
              AppTextField(
                hintText: "password", icon: Icons.key,
                textEditingController: passwordController, isObscure: true),
              SizedBox(height: Dimensions.height20,),
              //phone
              AppTextField(
                hintText: "phone", icon: Icons.phone,
                textEditingController: phoneController,),
              SizedBox(height: Dimensions.height20,),
              //name
              AppTextField(
                hintText: "name", icon: Icons.person,
                textEditingController: nameController,),
              SizedBox(height: Dimensions.height20,),

              //buton
              GestureDetector(
                onTap: (){
                  _registration(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2.7,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30)
                  ),
                  child: Center(child: BigText(text: "Üye Ol", color: Colors.white,size: Dimensions.font23*1.5)),
                ),
              ),
              SizedBox(height: Dimensions.height10),
              RichText(text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=> Get.back(),
                  text: "zaten bir hesabın mı var? TIKLAYIN",style: TextStyle(fontSize: Dimensions.font23, color: Colors.grey))),
              SizedBox(height: Dimensions.height10*3),
              RichText(text: TextSpan(
                  text: "kaydolmak için bu yöntemlerden birini kullanabilirsin",style: TextStyle(fontSize: Dimensions.font23/1.150, color: Colors.grey))),
              Wrap(children: List.generate(3, (index) =>
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage("assets/" + signUpImgs[index]),
                    ),
                  )))
            ],
          ),
        ):CustomLoader();
      })
    );

  }
}
