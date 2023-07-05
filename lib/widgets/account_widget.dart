import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icons.dart';

import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.width10/2),
      margin: EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height10,
      right: Dimensions.width20,
      bottom: Dimensions.height10
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width10),
          bigText
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow:[ BoxShadow(
          offset: Offset(0,5),
          blurRadius: 1,
          color: Colors.grey.withOpacity(0.2)
        )]
      ),
    );

  }
}
