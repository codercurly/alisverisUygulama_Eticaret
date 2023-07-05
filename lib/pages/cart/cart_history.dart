import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icons.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;
    Widget timeWidget(int index){
      var outputDate=DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseData =DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseData.toString());
        var outPutFormat = DateFormat("MM/dd/yyyy hh:mm ");
        var outputDate = outPutFormat.format(inputDate);
      }
      return BigText(text:outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            padding: EdgeInsets.only(top: Dimensions.height20),
            height: Dimensions.height20 * 5,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Sepet Geçmişi",
                  color: Colors.white,
                  size: Dimensions.font26,
                ),
                AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    size: Dimensions.iconSize16 * 2,
                    iconColor: Colors.white,
                    BgColor: AppColors.mainColor)
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController){
            return cartController.getCartHistoryList().length>0?Expanded(
                child: Container(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)

                        Container(
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              SizedBox(height: Dimensions.height15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children:
                                      List.generate(itemsPerOrder[i], (index) {
                                        if(listCounter<getCartHistoryList.length){
                                          listCounter++;
                                        }
                                        return index<=2?Container(
                                            height: Dimensions.height20*4,
                                            width: Dimensions.height20*4,
                                            margin: EdgeInsets.only(right: Dimensions.width10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(AppConstants
                                                      .BASE_URL +
                                                      AppConstants.UPLOADS_URI +
                                                      getCartHistoryList[listCounter-1]
                                                          .img!)),
                                            )):Container();
                                      })),
                                  Container(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: "toplam",color: Colors.black,),
                                        SizedBox(height: 5),
                                        BigText(text: itemsPerOrder[i].toString()+" Ürün",color: AppColors.titleColor),
                                        SizedBox(height: 5),
                                        GestureDetector(
                                          onTap: (){
                                            var orderTime = cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder ={};
                                            for(int j=0; j<getCartHistoryList.length;j++){
                                              if(getCartHistoryList[j].time==orderTime[i]){
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                              }
                                            }
                                            Get.find<CartController>().setItems = moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());

                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.height10, vertical: Dimensions.height10/2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                border: Border.all(width: 1,color: AppColors.mainColor)
                                            ),
                                            child: SmallText(text: "daha fazla", color: AppColors.mainColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                )):SizedBox(
                height: MediaQuery.of(context).size.height/1.4,
                child: Center(child: const NoDataPage(text: "henüz bir şey almadınız",imgPath: "assets/sadbox.png",)));
          })
        ],
      ),
    );
  }
}
