import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:GetBuilder<OrderController>(builder:(orderController){
      if(orderController.isLoading==false){
       List<OrderModel> orderList=[];
        if(orderController.currentOrderList!=null){
          orderList = (isCurrent ? orderController.currentOrderList!.reversed.toList():
          orderController.historyOrderList!.reversed.toList()).cast<OrderModel>();
        }
        return SizedBox(width: Dimensions.screenWidth,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.height10,
            vertical:Dimensions.width10),
          child: ListView.builder(

              itemCount:1,
              //orderList.length,
              itemBuilder: (context, index){
            return InkWell(onTap: ()=>null,
            child: Container(
              margin: EdgeInsets.all(Dimensions.height10/2),
                decoration: BoxDecoration(
                    color:Colors.white,
                    boxShadow: [
                  BoxShadow(
                      offset: Offset(0,1),
                      blurRadius: 3,
                      color: Colors.black45)
                ]),
                child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Sipariş No: 20105" , style: TextStyle(
                fontSize: Dimensions.font20
              ),
                // + orderList[index].id.toString()
                ),
              Column(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding:  EdgeInsets.symmetric(horizontal: Dimensions.height10/2,
                        vertical:Dimensions.width10/2),
                  margin: EdgeInsets.all(Dimensions.height10),
                    decoration: BoxDecoration(
                      color:AppColors.mainColor
                    ),
                    child: Text("bekliyor", style:
                    TextStyle(fontSize: Dimensions.font20-4),)),
              //orderList[index].orderStatus.toString()
              SizedBox(height: Dimensions.height10/2),
              InkWell(onTap:  ()=>null,
              child: Column(
                children: [
                  Container(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.height10,
                          vertical:Dimensions.width10/2),
                      margin: EdgeInsets.only(right: Dimensions.height10/2),
                      decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Theme.of(context).primaryColor),
                      color:Colors.white,
                  ),child: Row(
                    children: [
                     Image.asset("assets/cargo.png", height: Dimensions.height30,
                         width: Dimensions.width30),
SizedBox(width: Dimensions.width10),
                      Text("izle", style: TextStyle(fontSize: Dimensions.font20-3),),
                    ],
                  )),
                  SizedBox(height: Dimensions.height10)
                ],
              ),)
              ],
              )
              ],
            )));
          }),
        ),);
      }else{
        return CustomLoader();
      }

    }));
  }
}
