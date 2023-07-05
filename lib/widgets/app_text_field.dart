import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  bool maxLines;
  AppTextField({Key? key, required
  this.textEditingController,this.isObscure=false,
    required this.hintText, required this.icon,
  this.maxLines=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: Dimensions.height20,left: Dimensions.height20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow:[ BoxShadow(
              blurRadius: 4,
              spreadRadius: 5,
              offset: Offset(0,3),
              color: Colors.grey.withOpacity(0.2)
          )],
        ),  child: TextField(
      maxLines: maxLines?3:1,
      obscureText: isObscure?true:false,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColors.mainColor,),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.radius20),
          borderSide: BorderSide(width: 1.0,color: Colors.white),
        ),
        border:  OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.radius20),
        ),
      ),));
  }
}
