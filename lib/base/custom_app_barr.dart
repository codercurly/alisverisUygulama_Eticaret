import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize{
  final String title;
  final bool backButtonExist;
  Function? onBackPressed;
   CustomAppBar({Key? key, required this.title,
     this.backButtonExist=true, this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor:AppColors.mainColor,
      title: BigText(text: title, color: Colors.white),
      centerTitle: true,
      leading: backButtonExist?IconButton(onPressed:()=>
      onBackPressed!=null?onBackPressed!():
      Navigator.pushReplacementNamed(context, "/initial"),
          icon: Icon(Icons.arrow_back_ios)):SizedBox()
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(500, 50);
}
