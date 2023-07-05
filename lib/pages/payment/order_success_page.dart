import 'package:flutter/material.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/custom_button.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({Key? key, required this.orderID, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(status==0){
      Future.delayed(Duration(seconds: 1),(){});
    }
    return Scaffold(body: Center(
      child: SizedBox(width: Dimensions.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(status ==1? "assets/onay.png":"assets/fatal.jpg",
            width: 100,height: 100,),
          SizedBox(height: Dimensions.height45),
          Text(status ==1?"başarılı":"bir şeyler ters gitti",style:
            TextStyle(fontSize: Dimensions.font23)),
          SizedBox(height: Dimensions.height20),
          Padding(padding: EdgeInsets.symmetric(
              horizontal: Dimensions.height20, vertical: Dimensions.width20),
          child: Text(status ==1? "sipariş alındı":"sipariş hatalı",style:
          TextStyle(fontSize: Dimensions.font23, color: Theme.of(context).disabledColor
          ), textAlign: TextAlign.center),
          ),SizedBox(height: Dimensions.height20),
          Padding(padding: EdgeInsets.all(Dimensions.height20),
          child: CustomButton(buttonText: "GERİ DÖN",onPressed:
          () => Get.offAllNamed(RouteHelper.getInitial())))
      
        
        ],),),
    ),);

  }
}
